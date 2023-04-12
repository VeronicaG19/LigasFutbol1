import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_active.dart';
import 'package:ligas_futbol_flutter/src/domain/price/dto/all_my_assets/all_my_assets_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/price/service/i_price_service.dart';
import '../../../../../core/validators/simple_text_validator.dart';
import '../../../../../domain/agenda/entity/qra_event.dart';
import '../../../../../domain/match_event/util/event_util.dart';

part 'create_game_fee_state.dart';

@injectable
class CreateGameFeeCubit extends Cubit<CreateGameFeeState> {
  CreateGameFeeCubit(
      this._priceService,
      ) : super(const CreateGameFeeState());

  final IPriceService _priceService;

  void onFootballTypeChange(EventUtil value) {
    emit(state.copyWith(
        footballTypeValue: value,
    ));
  }

  void onFeeValueChanged(String value) {
    final feeValue = SimpleTextValidator.dirty(value);
    emit(state.copyWith(
      feeValue: feeValue,
      statusForm: Formz.validate([feeValue]),
    ));
  }

  Future<void> loadFootballType() async {
    List<EventUtil> eventsList = [];
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));

    /*eventsList.add(const EventUtil(
      code: "0",
      label: "Seleccionar evento",
    ));*/

    eventsList.add(EventUtil(
      code: TimeType.SOCCER.name,
      label: "Fútbol soccer",
    ));

    eventsList.add(EventUtil(
      code: TimeType.FUTBOL7.name,
      label: "Fútbol 7",
    ));

    eventsList.add(EventUtil(
      code: TimeType.INDORFUTBOL.name,
      label: "Fútbol sala",
    ));

    eventsList.add(EventUtil(
      code: TimeType.FASTFUTBOL.name,
      label: "Fútbol rápido",
    ));

    emit(state.copyWith(
        screenState: BasicCubitScreenState.loaded,
        footballTypeList: eventsList,
        footballTypeValue: eventsList[0]));
  }

  Future<void> createPrice(int activeId) async {
    emit(state.copyWith(statusForm: FormzStatus.submissionInProgress));
    AllMyAssetsDTO price = AllMyAssetsDTO(
      activeId: QraActive(activeId: activeId),
      currency: Currency.MXN.name,
      durationTime: 1,
      enabledFlag: "Y",
      periodEnd: DateTime.now(),
      periodStart: DateTime.now(),
      periotTime: state.footballTypeValue.code,
      price: double.parse(state.feeValue.value) ?? 0.0,
      priceId: 0,
      typePrice: null
    );

    final request = await _priceService.createPrice(price);

    request.fold(
            (l) => emit(state.copyWith(
              statusForm: FormzStatus.submissionFailure,
              errorMessage: l.errorMessage
            )),
            (r){
              //print("Respuesta--> ${r}");
              emit(state.copyWith(statusForm: FormzStatus.submissionSuccess));
            });
  }
}
