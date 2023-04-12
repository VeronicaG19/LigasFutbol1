part of 'fee_cubit.dart';

enum Loaders { loadingTimeTypes, timeTypesLoaded, error }

class FeeState extends Equatable {
  // ? -- Data
  final List<QraPrices> feeList;
  final List<EventUtil> timeTypeList;
  final EventUtil periotTimeSelected;
  // ? -- Loaders
  final Loaders periotTimeLoader;
  // ? -- Validators
  final Price priceValidator;
  final DurationTime durationTimeValidator;
  final PeriotTime periotTimeValidator;
  // ? -- Basic
  final BasicCubitScreenState screenState;
  final String? errorMessage;

  const FeeState({
    this.feeList = const [],
    this.timeTypeList = const [],
    this.periotTimeSelected = EventUtil.empty,
    this.periotTimeLoader = Loaders.loadingTimeTypes,
    this.priceValidator = const Price.pure(),
    this.durationTimeValidator = const DurationTime.pure(),
    this.periotTimeValidator = const PeriotTime.pure(),
    this.screenState = BasicCubitScreenState.initial,
    this.errorMessage,
  });

  FeeState copyWith({
    List<QraPrices>? feeList,
    List<EventUtil>? timeTypeList,
    EventUtil? periotTimeSelected,
    Loaders? periotTimeLoader,
    Price? priceValidator,
    DurationTime? durationTimeValidator,
    PeriotTime? periotTimeValidator,
    BasicCubitScreenState? screenState,
    String? errorMessage,
  }) {
    return FeeState(
      feeList: feeList ?? this.feeList,
      timeTypeList: timeTypeList ?? this.timeTypeList,
      periotTimeSelected: periotTimeSelected ?? this.periotTimeSelected,
      periotTimeLoader: periotTimeLoader ?? this.periotTimeLoader,
      priceValidator: priceValidator ?? this.priceValidator,
      durationTimeValidator:
          durationTimeValidator ?? this.durationTimeValidator,
      periotTimeValidator: periotTimeValidator ?? this.periotTimeValidator,
      screenState: screenState ?? this.screenState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        feeList,
        timeTypeList,
        periotTimeLoader,
        priceValidator,
        durationTimeValidator,
        periotTimeValidator,
        screenState,
      ];
}
