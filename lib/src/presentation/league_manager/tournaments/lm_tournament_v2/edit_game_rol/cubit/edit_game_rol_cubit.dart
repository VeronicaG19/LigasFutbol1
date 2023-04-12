import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/enums.dart';
import '../../../../../../domain/agenda/agenda.dart';
import '../../../../../../domain/field/entity/field.dart';
import '../../../../../../domain/field/service/i_field_service.dart';
import '../../../../../../domain/matches/dto/edit_match_dto/edit_match_dto.dart';
import '../../../../../../domain/matches/service/i_matches_service.dart';
import '../../../../../../domain/referee/dto/referee_by_address.dart';
import '../../../../../../domain/referee/service/i_referee_service.dart';

part 'edit_game_rol_state.dart';

@injectable
class EditGameRolCubit extends Cubit<EditGameRolState> {
  EditGameRolCubit(this._fieldService, this._refereeService,
      this._agendaService, this._matchService)
      : super(const EditGameRolState());

  final IFieldService _fieldService;
  final IRefereeService _refereeService;
  final IAgendaService _agendaService;
  final IMatchesService _matchService;
  final List<RefereeByAddress> _refereeList = [];
  final List<Field> _fieldList = [];
  late final int _matchId;

  Future<void> onLoadInitialResults(final int? matchId) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    _matchId = matchId ?? 0;
    final dateM = DateTime(
      state.selectedDate?.year ?? 2000,
      state.selectedDate?.month ?? 1,
      state.selectedDate?.day ?? 1,
      state.selectedHour?.hour ?? 00,
      state.selectedHour?.minute ?? 00,
    );
    final refereeRequest = await _refereeService.getRefereeByAddress(_matchId,
        state: state.selectedState ?? '', matchDate: dateM);
    final fieldRequest = await _fieldService.searchFieldByAddress(_matchId,
        state: state.selectedState ?? '', datematch: dateM);
    _refereeList.addAll(refereeRequest);
    _fieldList.addAll(fieldRequest);
    // _refereeList.addAll(List.generate(
    //     25,
    //     (index) => RefereeByAddress.empty.copyWith(
    //         refereeId: index, partyId: index, firstName: 'Arbitro $index')));
    // _fieldList.addAll(List.generate(
    //     19,
    //     (index) =>
    //         Field.empty.copyWith(fieldId: index, fieldName: 'campo $index')));
    emit(state.copyWith(
        refereeList: _refereeList,
        fieldList: _fieldList,
        screenState: BasicCubitScreenState.loaded));
  }

  Future<void> onFilterLists() async {
    emit(state.copyWith(
        screenState: BasicCubitScreenState.sending,
        refereeList: [],
        fieldList: []));
    _refereeList.clear();
    _fieldList.clear();
    final dateM = DateTime(
      state.selectedDate?.year ?? 2000,
      state.selectedDate?.month ?? 1,
      state.selectedDate?.day ?? 1,
      state.selectedHour?.hour ?? 00,
      state.selectedHour?.minute ?? 00,
    );
    final refereeRequest = await _refereeService.getRefereeByAddress(_matchId,
        state: state.selectedState ?? '', matchDate: dateM);
    final fieldRequest = await _fieldService.searchFieldByAddress(_matchId,
        state: state.selectedState ?? '', datematch: dateM);
    _refereeList.addAll(refereeRequest);
    _fieldList.addAll(fieldRequest);
    emit(state.copyWith(
        refereeList: _refereeList,
        fieldList: _fieldList,
        screenState: BasicCubitScreenState.loaded));
  }

  Future<void> onSelectReferee(RefereeByAddress value) async {
    if (state.screenState == BasicCubitScreenState.sending) return;
    emit(state.copyWith(selectedReferee: value));
  }

  Future<void> onSelectField(Field value) async {
    if (state.screenState == BasicCubitScreenState.sending) return;
    emit(state.copyWith(selectedField: value));
  }

  Future<void> onSubmit() async {
    if (state.screenState == BasicCubitScreenState.sending) return;
    emit(state.copyWith(screenState: BasicCubitScreenState.validating));
    if (state.selectedDate == null) {
      emit(state.copyWith(
          screenState: BasicCubitScreenState.emptyData,
          errorMessage: 'Selecciona la fecha del partido'));
      return;
    }
    if (state.selectedHour == null) {
      emit(state.copyWith(
          screenState: BasicCubitScreenState.emptyData,
          errorMessage: 'Selecciona la hora del partido'));
      return;
    }
    if (state.selectedReferee.isEmpty) {
      emit(state.copyWith(
          screenState: BasicCubitScreenState.emptyData,
          errorMessage: 'Debes seleccionar a un árbitro'));
      return;
    }
    if (state.selectedField.isEmpty) {
      emit(state.copyWith(
          screenState: BasicCubitScreenState.emptyData,
          errorMessage: 'Debes seleccionar un campo'));
      return;
    }
    emit(state.copyWith(
        screenState: BasicCubitScreenState.submissionInProgress));
    final dateM = DateTime(
      state.selectedDate!.year,
      state.selectedDate!.month,
      state.selectedDate!.day,
      state.selectedHour!.hour,
      state.selectedHour!.minute,
    );
    final refereeAvailability = await _validateRefereeAvailability(dateM);
    final fieldAvailability = await _validateFieldAvailability(dateM);
    if (!fieldAvailability) {
      emit(state.copyWith(
          screenState: BasicCubitScreenState.invalidData,
          errorMessage:
              'El campo no está disponible para la fecha ${DateFormat('dd-MM-yyyy HH:mm').format(dateM)}'));
      return;
    }
    if (!refereeAvailability) {
      emit(state.copyWith(
          screenState: BasicCubitScreenState.invalidData,
          errorMessage:
              'El árbitro no está disponible para la fecha ${DateFormat('dd-MM-yyyy HH:mm').format(dateM)}'));
      return;
    }
    final request = await _matchService.editMatchDto(EditMatchDTO(
      fieldId: state.selectedField.fieldId,
      refereeId: state.selectedReferee.refereeId,
      matchId: _matchId,
      dateMatch: dateM,
      hourMatch: dateM,
    ));
    request.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.errorMessage,
            screenState: BasicCubitScreenState.error)),
        (r) =>
            emit(state.copyWith(screenState: BasicCubitScreenState.success)));
  }

  Future<bool> _validateFieldAvailability(DateTime time) async {
    final fieldAvailability = await _agendaService
        .getFieldsAvailability(state.selectedField.activeId ?? 0);
    final availability = fieldAvailability.getOrElse(() => []);
    bool flag = false;
    final dateFormat = DateFormat('dd-MM-yyyy HH:mm');
    for (final e in availability) {
      if (time.isAfter(e.openingDate!) && time.isBefore(e.expirationDate!)) {
        flag = true;
      }
    }
    return flag;
  }

  Future<bool> _validateRefereeAvailability(DateTime time) async {
    final refereeAvailability = await _agendaService
        .getRefereeAvailability(state.selectedReferee.refereeId);
    final availability = refereeAvailability.getOrElse(() => []);
    bool flag = false;
    for (final e in availability) {
      if (time.isAfter(e.openingDate!) && time.isBefore(e.expirationDate!)) {
        flag = true;
      }
    }
    return flag;
  }

  void onChangeDate(DateTime dateTime) {
    emit(state.copyWith(selectedDate: dateTime));
    print("fecha seleccionada $dateTime");
  }

  void onChangeHour(DateTime dateTime) {
    emit(state.copyWith(selectedHour: dateTime));
    print("hora seleccionada $dateTime");
  }

  void onChangeState(String estado) {
    emit(state.copyWith(selectedState: estado));
    print("hora seleccionada $state");
  }
}
