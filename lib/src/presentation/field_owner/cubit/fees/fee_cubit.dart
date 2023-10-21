import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/agenda.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_active.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_prices.dart';
import 'package:ligas_futbol_flutter/src/domain/match_event/util/event_util.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/fees_tab/validators/duration_time_validator.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/fees_tab/validators/periot_time_validator.dart';
import 'package:ligas_futbol_flutter/src/presentation/field_owner/fees_tab/validators/price_validator.dart';

part 'fee_state.dart';

@injectable
class FeeCubit extends Cubit<FeeState> {
  final IAgendaService _iAgendaService;

  FeeCubit(this._iAgendaService) : super(const FeeState());

  Future<void> loadFeeList({required activeId}) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final response = await _iAgendaService.getPricesByActive(activeId);

    response.fold((l) {
      emit(state.copyWith(
        screenState: BasicCubitScreenState.error,
        errorMessage: l.errorMessage,
      ));
    }, (r) {
      emit(state.copyWith(
        screenState: BasicCubitScreenState.loaded,
        feeList: r,
      ));
    });
  }

  Future<void> loadTimeTypes() async {
    List<EventUtil> timeTypeList = [];

    emit(state.copyWith(periotTimeLoader: Loaders.loadingTimeTypes));

    /*  timeTypeList.add(const EventUtil(
      code: "0",
      label: "Seleccionar periodo",
    ));*/

    timeTypeList.add(EventUtil(
      code: TimeType.MINUTE.name,
      label: "Minuto(s)",
    ));

    timeTypeList.add(EventUtil(
      code: TimeType.HOURLY.name,
      label: "Hora(s)",
    ));

    timeTypeList.add(EventUtil(
      code: TimeType.DAY.name,
      label: "Día(s)",
    ));

    timeTypeList.add(EventUtil(
      code: TimeType.MONTHLY.name,
      label: "Mese(s)",
    ));

    timeTypeList.add(EventUtil(
      code: TimeType.YEARLY.name,
      label: "Año(s)",
    ));

    timeTypeList.add(EventUtil(
      code: TimeType.FASTFUTBOL.name,
      label: "Futbol rapido",
    ));

    timeTypeList.add(EventUtil(
      code: TimeType.FUTBOL7.name,
      label: "Futbol 7",
    ));

    timeTypeList.add(EventUtil(
      code: TimeType.INDORFUTBOL.name,
      label: "Futbol de sala",
    ));

    timeTypeList.add(EventUtil(
      code: TimeType.SOCCER.name,
      label: "Soccer",
    ));

    emit(state.copyWith(
      periotTimeLoader: Loaders.timeTypesLoaded,
      periotTimeSelected: timeTypeList[0],
      periotTimeValidator: PeriotTime.dirty(timeTypeList[0].code!),
      timeTypeList: timeTypeList,
    ));
  }

// * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
/*  Future<void> onDurationTimeChange({required String duration}) async {
    final xDurationTime = DurationTime.dirty(duration);
    emit(state.copyWith(
      durationTimeValidator: xDurationTime,
    ));
  }*/

  Future<void> onPriceChange({required String price}) async {
    final xPrice = Price.dirty(price);
    emit(state.copyWith(
      priceValidator: xPrice,
    ));
  }

  Future<void> onPeriotTimeChange({required EventUtil periot}) async {
    final xPeriot = PeriotTime.dirty(periot.code ?? '');
    emit(state.copyWith(
      periotTimeSelected: periot,
      periotTimeValidator: xPeriot,
    ));
  }
// * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  Future<void> onPressSaveFee({required activeId}) async {
    emit(state.copyWith(
      priceValidator: Price.dirty(state.priceValidator.value),
      periotTimeValidator: PeriotTime.dirty(state.periotTimeValidator.value),
    ));
    if (state.periotTimeSelected.code == 0) {
      emit(state.copyWith(
        screenState: BasicCubitScreenState.error,
        errorMessage: "Favor de seleccionar periodo",
      ));
    }
    if (state.priceValidator.valid == true &&
        state.periotTimeValidator.valid == true) {
      emit(state.copyWith(
        screenState: BasicCubitScreenState.sending,
      ));

      final response = await _iAgendaService.createPrices(QraPrices(
        activeId: QraActive(
          activeId: activeId,
        ),
        currency: Currency.MXN,
        //durationTime: int.tryParse(state.durationTimeValidator.value),
        durationTime: 1,
        periotTime: TimeType.values
            .firstWhere((elmnt) => elmnt.name == state.periotTimeSelected.code),
        price: double.tryParse(state.priceValidator.value),
      ));

      response.fold((l) {
        emit(state.copyWith(
          screenState: BasicCubitScreenState.error,
          errorMessage: l.errorMessage,
        ));
      }, (r) {
        emit(state.copyWith(
          screenState: BasicCubitScreenState.success,
        ));

        loadFeeList(activeId: activeId);
      });
    }
  }

  Future<void> onPressDeleteFee({
    required int activeId,
    required int priceId,
  }) async {
    final response = await _iAgendaService.deletePrice(priceId);

    response.fold((l) {
      emit(state.copyWith(
        screenState: BasicCubitScreenState.error,
        errorMessage: l.errorMessage,
      ));
    }, (r) {
      print(r.result);
      emit(state.copyWith(
        screenState: BasicCubitScreenState.success,
      ));

      loadFeeList(activeId: activeId);
    });
  }
}
