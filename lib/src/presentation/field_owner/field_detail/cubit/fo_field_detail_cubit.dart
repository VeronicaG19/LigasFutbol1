import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_active.dart';

import '../../../../core/enums.dart';
import '../../../../domain/agenda/agenda.dart';
import '../../../../domain/agenda/entity/availability.dart';
import '../../../../domain/field/entity/field.dart';

part 'fo_field_detail_state.dart';

@injectable
class FoFieldDetailCubit extends Cubit<FoFieldDetailState> {
  FoFieldDetailCubit(this._agendaService) : super(const FoFieldDetailState());

  final IAgendaService _agendaService;
  late Field selectedField;

  void onChangeInitialDate(DateTime dateTime) {
    emit(state.copyWith(initialDate: dateTime));
  }

  void onChangeInitialHour(DateTime dateTime) {
    emit(state.copyWith(initialHour: dateTime));
  }

  void onChangeEndHour(DateTime dateTime) {
    emit(state.copyWith(endHour: dateTime));
  }

  void onChangeFinalDate(DateTime dateTime) {
    emit(state.copyWith(
        endDate: DateTime(dateTime.year, dateTime.month, dateTime.day, 1)));
  }

  void onLoadFieldData(Field field) {
    selectedField = field;
  }

  Future<void> onCreateNewAvailability(final int partyId) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    if (state.initialDate != null &&
        state.endDate != null &&
        state.initialHour != null &&
        state.endHour != null) {
      bool valDate = state.initialDate!.isBefore(state.endDate!);
      bool valHour = state.initialHour!.isBefore(state.endHour!);
      if (!valDate) {
        emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage:
                'La fecha fin debe de ser mayor que la fecha inicio'));
        return;
      }
      if (!valHour) {
        emit(state.copyWith(
            screenState: BasicCubitScreenState.error,
            errorMessage: 'La hora fin debe de ser mayor que la hora inicio'));
        return;
      }
      Availability availabilityData = Availability(
        partyId: partyId,
        hourClose: state.endHour,
        hourOpen: state.initialHour,
        status: 0,
        activeId: QraActive(activeId: selectedField.activeId ?? 0),
        availabilityId: 0,
        openingDate: state.initialDate,
        expirationDate: state.endDate,
      );
      //emit(state.copyWith(screenState: BasicCubitScreenState.emptyData));
      final request = await _agendaService.createAvailability(availabilityData);
      request.fold(
          (l) => emit(state.copyWith(
              errorMessage: _getAvailabilityErrorResponse(
                  jsonDecode(l.data ?? '')['status']),
              screenState: BasicCubitScreenState.error)), (r) {
        emit(state.copyWith(
          screenState: BasicCubitScreenState.success,
        ));
      });
    } else {
      emit(state.copyWith(screenState: BasicCubitScreenState.emptyData));
    }
  }

  String _getAvailabilityErrorResponse(final int? status) {
    switch (status) {
      case -1:
        return 'Error al guardar';
      case -2:
        return 'Este rango de fecha ya está ocupado';
      case -3:
        return 'El activo no existe';
      case -4:
        return 'Hay datos faltantes';
      default:
        return 'Ha ocurrido un error';
    }
  }

  Future<void> getFieldsAvailability(int activeId) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final request = await _agendaService.getFieldsAvailability(activeId);
    request.fold((l) {
      emit(state.copyWith(
        screenState: BasicCubitScreenState.error,
        errorMessage: l.errorMessage,
      ));
    }, (r) {
      emit(state.copyWith(
        availability: r,
        screenState: BasicCubitScreenState.loaded,
      ));
    });
  }
}
