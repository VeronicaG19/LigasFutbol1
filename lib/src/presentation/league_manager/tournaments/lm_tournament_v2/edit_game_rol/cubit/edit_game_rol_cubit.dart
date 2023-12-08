import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/enums.dart';
import '../../../../../../core/models/address_filter.dart';
import '../../../../../../core/models/map_filter_list.dart';
import '../../../../../../domain/agenda/agenda.dart';
import '../../../../../../domain/field/entity/field.dart';
import '../../../../../../domain/field/service/i_field_service.dart';
import '../../../../../../domain/matches/dto/detail_rol_match_dto/detail_rol_match_DTO.dart';
import '../../../../../../domain/matches/dto/edit_match_dto/edit_match_dto.dart';
import '../../../../../../domain/matches/service/i_matches_service.dart';
import '../../../../../../domain/referee/dto/referee_by_address.dart';
import '../../../../../../domain/referee/service/i_referee_service.dart';
import '../../../../../../domain/user_requests/entity/user_requests.dart';
import '../../../../../../domain/user_requests/service/i_user_requests_service.dart';

part 'edit_game_rol_state.dart';

@injectable
class EditGameRolCubit extends Cubit<EditGameRolState> {
  EditGameRolCubit(this._fieldService, this._refereeService,
      this._agendaService, this._matchService, this._requestsService)
      : super(const EditGameRolState());

  final IFieldService _fieldService;
  final IRefereeService _refereeService;
  final IAgendaService _agendaService;
  final IMatchesService _matchService;
  final IUserRequestsService _requestsService;
  final List<RefereeByAddress> _refereeList = [];
  final List<Field> _fieldList = [];
  final List<MapFilterList> _mixedElements = [];
  late DeatilRolMatchDTO _match;

  Future<void> onLoadInitialResults(
      final DeatilRolMatchDTO? match, int leagueId) async {
    _match = match ?? DeatilRolMatchDTO.empty;

    _validateInitialData(leagueId);
  }

  Future<void> _validateInitialData(int leagueId) async {
    emit(state.copyWith(
        screenState: BasicCubitScreenState.loading,
        leagueId: leagueId,
        selectedRefereeValue: 0,
        selectedFieldValue: 0));
    RefereeByAddress selectedReferee = RefereeByAddress.empty;
    Field selectedField = Field.empty;
    _refereeList.clear();
    _fieldList.clear();
    if (_match.refereeId != null) {
      selectedReferee = RefereeByAddress.empty
          .copyWith(refereeId: _match.refereeId, name: _match.refereeName);
    }
    if (_match.fieldMatchId != null) {
      selectedField =
          Field(fieldId: _match.fieldMatchId, fieldName: _match.fieldMatch);
    }
    final formattedDate1 = DateFormat('dd-MM-yyyy HH:mm');

    final dateMatch1 = _match.dateMatch == null
        ? null
        : formattedDate1.parse(_match.dateMatch ?? '');
    final fieldsRequest =
        await _fieldService.searchFieldByFilters(AddressFilter(
      state: state.selectedState,
      leagueId: _match.requestFieldId == null ? state.leagueId : null,
      status: _match.requestFieldId != null ? 2 : 0,
      matchDate: _match.requestFieldId == null ? dateMatch1 : null,
      matchHour: _match.requestFieldId == null ? dateMatch1 : null,
    ));
    final refereeRequest =
        await _refereeService.searchByFiltersReferee(AddressFilter(
      state: state.selectedState,
      leagueId: _match.requestRefereeId != null ? null : state.leagueId,
      status: _match.requestRefereeId != null ? 2 : 0,
      matchDate: _match.requestRefereeId == null ? dateMatch1 : null,
      matchHour: _match.requestRefereeId == null ? dateMatch1 : null,
    ));
    if ((_match.refereeId != null &&
            _match.statusRequestReferee == 'ACCEPTED') ||
        _match.refereeAssigmentId != null) {
      selectedReferee = refereeRequest.firstWhere(
          (element) => element.refereeId == _match.refereeId,
          orElse: () => RefereeByAddress.empty);
      _refereeList.add(selectedReferee);
    } else {
      if ((_match.requestRefereeId != null ||
              _match.refereeAssigmentId != null) &&
          _match.statusRequestReferee == 'SEND') {
        final requestInfo = await _requestsService.getRequestByStatusAndType(
            _match.matchId ?? 0, 3, 15);
        final refereeId = requestInfo.getOrElse(() => []).firstWhere(
            (element) => element.requestId == _match.requestRefereeId,
            orElse: () => UserRequests.empty);
        selectedReferee = refereeRequest.firstWhere(
            (element) => element.refereeId == refereeId.requestToId,
            orElse: () => RefereeByAddress.empty);
        _refereeList.add(selectedReferee);
      } else {
        _refereeList.addAll(refereeRequest);
      }
    }
    if (_match.fieldMatchId != null &&
        _match.statusRequestField == 'ACCEPTED') {
      selectedField = fieldsRequest.firstWhere(
          (element) => element.fieldId == _match.fieldMatchId,
          orElse: () => Field.empty);
      _fieldList.add(selectedField);
    } else {
      if (_match.requestFieldId != null &&
          _match.statusRequestField == 'SEND') {
        final requestInfo = await _requestsService.getRequestByStatusAndType(
            _match.matchId ?? 0, 3, 14);
        final fieldId = requestInfo.getOrElse(() => []).firstWhere(
            (element) => element.requestId == _match.requestFieldId,
            orElse: () => UserRequests.empty);
        selectedField = fieldsRequest.firstWhere(
            (element) => element.fieldId == fieldId.requestToId,
            orElse: () => Field.empty);
        _fieldList.add(selectedField);
      } else {
        _fieldList.addAll(fieldsRequest);
      }
    }
    final formattedDate = DateFormat('dd-MM-yyyy HH:mm');
    final dateMatch = _match.dateMatch == null
        ? null
        : formattedDate.parse(_match.dateMatch ?? '');
    _buildMixedList();
    emit(state.copyWith(
        refereeList: _refereeList.toSet().toList(),
        fieldList: _fieldList.toSet().toList(),
        mixedElementsList: _mixedElements.toSet().toList(),
        addressList: _mixedElements.toSet().toList(),
        selectedField: selectedField,
        selectedReferee: selectedReferee,
        selectedDate: dateMatch,
        selectedHour: dateMatch,
        screenState: BasicCubitScreenState.loaded));
  }

  Future<void> validateFieldData(int leagueId, int selectedValue) async {
    print(selectedValue);
    emit(state.copyWith(
        screenState: BasicCubitScreenState.loading,
        leagueId: leagueId,
        selectedFieldValue: selectedValue));
    Field selectedField = Field.empty;
    _fieldList.clear();

    if (_match.fieldMatchId != null) {
      selectedField =
          Field(fieldId: _match.fieldMatchId, fieldName: _match.fieldMatch);
    }
    final matchDateM = state.selectedDate == null
        ? null
        : DateTime(
            state.selectedDate?.year ?? DateTime.now().year,
            state.selectedDate?.month ?? DateTime.now().month,
            state.selectedDate?.day ?? DateTime.now().day,
          );
    final matchHourM = state.selectedHour == null
        ? null
        : DateTime(
            2000,
            1,
            1,
            state.selectedHour?.hour ?? 08,
            state.selectedHour?.minute ?? 00,
          );
    final fieldsRequest = await _fieldService.searchFieldByFilters(
      AddressFilter(
        state: state.selectedState,
        leagueId: state.leagueId,
        status: state.selectedFieldValue == 0 ? 0 : 1,
        latitude: state.latitude == 0 ? null : state.latitude?.toString(),
        longitude: state.longitude == 0 ? null : state.longitude?.toString(),
        matchDate: matchDateM,
        matchHour: matchHourM,
      ),
    );

    if (_match.fieldMatchId != null &&
        _match.statusRequestField == 'ACCEPTED') {
      selectedField = fieldsRequest.firstWhere(
          (element) => element.fieldId == _match.fieldMatchId,
          orElse: () => Field.empty);
      _fieldList.add(selectedField);
    } else {
      if (_match.requestFieldId != null &&
          _match.statusRequestField == 'SEND') {
        final requestInfo = await _requestsService.getRequestByStatusAndType(
            _match.matchId ?? 0, 3, 14);
        final fieldId = requestInfo.getOrElse(() => []).firstWhere(
            (element) => element.requestId == _match.requestFieldId,
            orElse: () => UserRequests.empty);
        selectedField = fieldsRequest.firstWhere(
            (element) => element.fieldId == fieldId.requestToId,
            orElse: () => Field.empty);
        _fieldList.add(selectedField);
      } else {
        _fieldList.addAll(fieldsRequest);
      }
    }

    _buildMixedListFilter(1);
    emit(state.copyWith(
        fieldList: _fieldList.toSet().toList(),
        mixedElementsList: _mixedElements.toSet().toList(),
        addressList: _mixedElements.toSet().toList(),
        selectedField: selectedField,
        screenState: BasicCubitScreenState.loaded));
  }

  Future<void> validateRefereeData(int leagueId, int selectedValue) async {
    print(selectedValue);
    emit(state.copyWith(
        screenState: BasicCubitScreenState.loading,
        leagueId: leagueId,
        selectedRefereeValue: selectedValue));
    RefereeByAddress selectedReferee = RefereeByAddress.empty;
    _refereeList.clear();
    if (_match.refereeId != null) {
      selectedReferee = RefereeByAddress.empty
          .copyWith(refereeId: _match.refereeId, name: _match.refereeName);
    }
    final matchDateM = state.selectedDate == null
        ? null
        : DateTime(
            state.selectedDate?.year ?? DateTime.now().year,
            state.selectedDate?.month ?? DateTime.now().month,
            state.selectedDate?.day ?? DateTime.now().day,
          );
    final matchHourM = state.selectedHour == null
        ? null
        : DateTime(
            2000,
            1,
            1,
            state.selectedHour?.hour ?? 08,
            state.selectedHour?.minute ?? 00,
          );
    final refereeRequest =
        await _refereeService.searchByFiltersReferee(AddressFilter(
      state: state.selectedState,
      leagueId: state.leagueId,
      status: state.selectedRefereeValue == 0 ? 0 : 1,
      latitude: state.latitude == 0 ? null : state.latitude?.toString(),
      longitude: state.longitude == 0 ? null : state.longitude?.toString(),
      matchDate: matchDateM,
      matchHour: matchHourM,
    ));
    if ((_match.refereeId != null &&
            _match.statusRequestReferee == 'ACCEPTED') ||
        _match.refereeAssigmentId != null) {
      selectedReferee = refereeRequest.firstWhere(
          (element) => element.refereeId == _match.refereeId,
          orElse: () => RefereeByAddress.empty);
      _refereeList.add(selectedReferee);
    } else {
      if ((_match.requestRefereeId != null ||
              _match.refereeAssigmentId != null) &&
          _match.statusRequestReferee == 'SEND') {
        final requestInfo = await _requestsService.getRequestByStatusAndType(
            _match.matchId ?? 0, 3, 15);
        final refereeId = requestInfo.getOrElse(() => []).firstWhere(
            (element) => element.requestId == _match.requestRefereeId,
            orElse: () => UserRequests.empty);
        selectedReferee = refereeRequest.firstWhere(
            (element) => element.refereeId == refereeId.requestToId,
            orElse: () => RefereeByAddress.empty);
        _refereeList.add(selectedReferee);
      } else {
        _refereeList.addAll(refereeRequest);
      }
    }

    _buildMixedListFilter(1);
    emit(state.copyWith(
        refereeList: _refereeList.toSet().toList(),
        mixedElementsList: _mixedElements.toSet().toList(),
        addressList: _mixedElements.toSet().toList(),
        selectedReferee: selectedReferee,
        screenState: BasicCubitScreenState.loaded));
  }

  Future<void> onFilterLists() async {
    if (_match.dateMatch != null &&
        (_match.requestFieldId != null || _match.fieldMatchId != null) &&
        (_match.requestRefereeId != null ||
            _match.refereeAssigmentId != null)) {
      return;
    }
    if (state.isMapLoading ||
        state.screenState == BasicCubitScreenState.sending) {
      return;
    }
    /*if (state.selectedHour == null && state.selectedDate != null) {
      emit(state.copyWith(
          screenState: BasicCubitScreenState.emptyData,
          errorMessage: 'Selecciona la hora'));
      return;
    }
    if (state.selectedHour != null && state.selectedDate == null) {
      emit(state.copyWith(
          screenState: BasicCubitScreenState.emptyData,
          errorMessage: 'Selecciona el día'));
      return;
    }*/
    emit(state.copyWith(
        screenState: BasicCubitScreenState.sending,
        refereeList: [],
        fieldList: [],
        latitude: 0,
        longitude: 0));
    _applyFilter();
  }

  Future<void> onFilterByMapPosition(
      double latitude, double longitude, int leagueId) async {
    if (state.isMapLoading ||
        state.screenState == BasicCubitScreenState.sending) {
      return;
    }
    emit(state.copyWith(
        isMapLoading: true,
        refereeList: [],
        fieldList: [],
        latitude: latitude,
        longitude: longitude,
        selectedState: ''));
    _applyFilter();
  }

  Future<void> _applyFilter() async {
    final matchDateM = state.selectedDate == null
        ? null
        : DateTime(
            state.selectedDate?.year ?? DateTime.now().year,
            state.selectedDate?.month ?? DateTime.now().month,
            state.selectedDate?.day ?? DateTime.now().day,
          );
    final matchHourM = state.selectedHour == null
        ? null
        : DateTime(
            2000,
            1,
            1,
            state.selectedHour?.hour ?? 08,
            state.selectedHour?.minute ?? 00,
          );
    /*final filter = AddressFilter(
        state: state.selectedState,
        matchDate: matchDateM,
        matchHour: matchHourM,
        latitude: state.latitude == 0 ? null : state.latitude?.toString(),
        leagueId: state.leagueId,
        status: state.selectedRefereeValue == 0 ? 0 : 1,
        //leagueId: state.leagueId == 0 ? null : state.leagueId,
        longitude: state.longitude == 0 ? null : state.longitude?.toString());*/
    if (_match.requestFieldId == null) {
      _fieldList.clear();
      final fieldRequest =
          await _fieldService.searchFieldByFilters(AddressFilter(
        state: state.selectedState,
        matchDate: matchDateM,
        matchHour: matchHourM,
        latitude: state.latitude == 0 ? null : state.latitude?.toString(),
        longitude: state.longitude == 0 ? null : state.longitude?.toString(),
        leagueId: state.leagueId,
        status: state.selectedFieldValue,
      ));
      _fieldList.addAll(fieldRequest);
    }
    if (_match.requestRefereeId == null) {
      _refereeList.clear();
      final refereeRequest = await _refereeService.searchByFiltersReferee(
          AddressFilter(
              state: state.selectedState,
              matchDate: matchDateM,
              matchHour: matchHourM,
              latitude: state.latitude == 0 ? null : state.latitude?.toString(),
              leagueId: state.leagueId,
              status: state.selectedRefereeValue,
              longitude:
                  state.longitude == 0 ? null : state.longitude?.toString()));
      _refereeList.addAll(refereeRequest);
    }
    _buildMixedList();
    emit(state.copyWith(
        refereeList: _refereeList.toSet().toList(),
        fieldList: _fieldList.toSet().toList(),
        mixedElementsList: _mixedElements.toSet().toList(),
        selectedDate: matchDateM,
        selectedHour: matchHourM,
        selectedReferee:
            _match.requestRefereeId == null ? RefereeByAddress.empty : null,
        selectedField: _match.requestFieldId == null ? Field.empty : null,
        screenState: BasicCubitScreenState.loaded,
        isMapLoading: false));
  }

  void onClearFilters() {
    if (_match.dateMatch != null) {
      if (_match.requestRefereeId != null ||
          _match.refereeAssigmentId != null && _match.requestFieldId != null) {
        return;
      }
      if (_match.requestRefereeId != null ||
          _match.fieldMatchId != null && _match.requestRefereeId != null) {
        return;
      }
    }
    emit(state.copyWith(
        selectedState: '',
        selectedDate: DateTime(0),
        selectedHour: DateTime(0),
        longitude: 0,
        latitude: 0));
  }

  void onSelectReferee(RefereeByAddress value) {
    if (state.screenState == BasicCubitScreenState.sending) return;
    if (_match.requestRefereeId != null || _match.refereeAssigmentId != null) {
      return;
    }
    emit(state.copyWith(
      selectedReferee:
          value == state.selectedReferee ? RefereeByAddress.empty : value,
    ));
  }

  void onSelectField(Field value) {
    if (_match.requestFieldId != null) return;
    if (state.screenState == BasicCubitScreenState.sending) return;
    emit(state.copyWith(
      selectedField: value == state.selectedField ? Field.empty : value,
    ));
  }

  Future<void> onSubmit(int leagueId) async {
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
        matchId: _match.matchId ?? 0,
        dateMatch: dateM,
        hourMatch: dateM,
        leagueId: leagueId));
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
    //final dateFormat = DateFormat('dd-MM-yyyy HH:mm');
    for (final e in availability) {
      final initialHur = DateTime(time.year, time.month, time.day,
          e.openingDate?.hour ?? 0, e.openingDate?.minute ?? 0);
      final endHour = DateTime(time.year, time.month, time.day,
          e.expirationDate?.hour ?? 0, e.expirationDate?.minute ?? 0);
      if (time.isAfter(e.openingDate!.subtract(const Duration(minutes: 1))) &&
          time.isBefore(e.expirationDate!.add(const Duration(minutes: 1)))) {
        if (time.isAfter(initialHur.subtract(const Duration(minutes: 1))) &&
            time.isBefore(endHour.add(const Duration(minutes: 1)))) {
          flag = true;
        }
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
      final initialHur = DateTime(time.year, time.month, time.day,
          e.openingDate?.hour ?? 0, e.openingDate?.minute ?? 0);
      final endHour = DateTime(time.year, time.month, time.day,
          e.expirationDate?.hour ?? 0, e.expirationDate?.minute ?? 0);
      if (time.isAfter(e.openingDate!.subtract(const Duration(minutes: 1))) &&
          time.isBefore(e.expirationDate!.add(const Duration(minutes: 1)))) {
        if (time.isAfter(initialHur.subtract(const Duration(minutes: 1))) &&
            time.isBefore(endHour.add(const Duration(minutes: 1)))) {
          flag = true;
        }
      }
    }
    return flag;
  }

  void onChangeDate(DateTime dateTime) {
    if (_match.dateMatch != null &&
        (_match.requestRefereeId != null ||
            _match.requestFieldId != null ||
            _match.refereeAssigmentId != null ||
            _match.fieldMatchId != null)) return;
    emit(state.copyWith(selectedDate: dateTime));
  }

  void onChangeHour(DateTime dateTime) {
    if (_match.dateMatch != null &&
        (_match.requestRefereeId != null ||
            _match.requestFieldId != null ||
            _match.refereeAssigmentId != null ||
            _match.fieldMatchId != null)) return;
    emit(state.copyWith(selectedHour: dateTime));
  }

  void onChangeState(String? estado) {
    emit(state.copyWith(selectedState: estado));
  }

  Future<void> onSendRefereeRequest() async {
    if (state.screenState == BasicCubitScreenState.sending) return;
    emit(state.copyWith(screenState: BasicCubitScreenState.validating));
    if (state.selectedReferee.isEmpty) {
      emit(state.copyWith(
          screenState: BasicCubitScreenState.emptyData,
          errorMessage: 'Debes seleccionar a un árbitro'));
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
    if (!refereeAvailability) {
      emit(state.copyWith(
          screenState: BasicCubitScreenState.invalidData,
          errorMessage:
              'El árbitro no está disponible para la fecha ${DateFormat('dd-MM-yyyy HH:mm').format(dateM)}'));
      return;
    }
    final request = await _matchService.updateMatchReferee(
        _match.matchId ?? 0, state.selectedReferee.refereeId);
    request.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.errorMessage,
            screenState: BasicCubitScreenState.error)), (r) {
      emit(
          state.copyWith(screenState: BasicCubitScreenState.submissionSuccess));
      emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    });
  }

  Future<void> onSendFieldRequest() async {
    if (state.screenState == BasicCubitScreenState.sending) return;
    emit(state.copyWith(screenState: BasicCubitScreenState.validating));
    if (state.selectedField.isEmpty) {
      emit(state.copyWith(
          screenState: BasicCubitScreenState.emptyData,
          errorMessage: 'Debes seleccionar a un campo'));
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
    final fieldAvailability = await _validateFieldAvailability(dateM);
    if (!fieldAvailability) {
      emit(state.copyWith(
          screenState: BasicCubitScreenState.invalidData,
          errorMessage:
              'El Campo no está disponible para la fecha ${DateFormat('dd-MM-yyyy HH:mm').format(dateM)}'));
      return;
    }
    final request = await _matchService.updateMatchField(
        _match.matchId ?? 0, state.selectedField.fieldId ?? 0);
    request.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.errorMessage,
            screenState: BasicCubitScreenState.error)), (r) {
      emit(state.copyWith(screenState: BasicCubitScreenState.success));
      emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    });
  }

  Future<void> onCancelRequest(final int? requestId) async {
    emit(state.copyWith(
        screenState: BasicCubitScreenState.submissionInProgress));
    final response = await _requestsService.cancelUserRequest(requestId ?? 0);
    response.fold(
        (l) => emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: l.errorMessage)), (r) {
      emit(
          state.copyWith(screenState: BasicCubitScreenState.submissionSuccess));
      emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    });
  }

  void onChangeMapVisibility() => emit(state.copyWith(
      isMapVisible: !state.isMapVisible, longitude: 0, latitude: 0));

  void onSelectRefereeOnMap(final int id) {
    emit(state.copyWith(
        selectedReferee: _refereeList.firstWhere(
            (element) => element.refereeId == id,
            orElse: () => RefereeByAddress.empty)));
  }

  void onSelectFieldOnMap(final int id) {
    emit(state.copyWith(
        selectedField: _fieldList.firstWhere((element) => element.fieldId == id,
            orElse: () => Field.empty)));
  }

  void onSelectAddressFilter(MapFilterList filter) {
    emit(state.copyWith(selectedAddress: filter));
  }

  void _buildMixedList() {
    _mixedElements.clear();
    _mixedElements.addAll(_fieldList
        .map((e) => MapFilterList(
            id: e.fieldId ?? 0,
            address: e.fieldsAddress?.toLowerCase() ?? '',
            desc: e.fieldName ?? '',
            latitude: e.fieldsLatitude ?? '0',
            isReferee: false,
            longitude: e.fieldsLength ?? '0'))
        .toList());
    _mixedElements.addAll(_refereeList
        .map((e) => MapFilterList(
            desc: e.name,
            address: e.address.toLowerCase(),
            id: e.refereeId,
            latitude: e.latitude,
            longitude: e.longitude,
            isReferee: true))
        .toList());
  }

  void _buildMixedListFilter(int type) {
    if (type == 1) {
      _mixedElements.clear();
      _mixedElements.addAll(_fieldList
          .map((e) => MapFilterList(
              id: e.fieldId ?? 0,
              address: e.fieldsAddress?.toLowerCase() ?? '',
              desc: e.fieldName ?? '',
              latitude: e.fieldsLatitude ?? '0',
              isReferee: false,
              longitude: e.fieldsLength ?? '0'))
          .toList());
    } else {
      _mixedElements.addAll(_refereeList
          .map((e) => MapFilterList(
              desc: e.name,
              address: e.address.toLowerCase(),
              id: e.refereeId,
              latitude: e.latitude,
              longitude: e.longitude,
              isReferee: true))
          .toList());
    }
  }
}
