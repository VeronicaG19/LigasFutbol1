part of 'create_game_fee_cubit.dart';

class CreateGameFeeState extends Equatable{
  final List<EventUtil> footballTypeList;
  final EventUtil footballTypeValue;
  final FormzStatus statusForm;
  final SimpleTextValidator feeValue;
  final BasicCubitScreenState screenState;
  final String? errorMessage;

  const CreateGameFeeState({
    this.footballTypeList = const [],
    this.footballTypeValue = EventUtil.empty,
    this.statusForm = FormzStatus.pure,
    this.feeValue = const SimpleTextValidator.pure(),
    this.screenState = BasicCubitScreenState.initial,
    this.errorMessage,
  });

  CreateGameFeeState copyWith({
    List<EventUtil>? footballTypeList,
    EventUtil? footballTypeValue,
    FormzStatus? statusForm,
    SimpleTextValidator? feeValue,
    BasicCubitScreenState? screenState,
    String? errorMessage,
  }) {
    return CreateGameFeeState(
      footballTypeList: footballTypeList ?? this.footballTypeList,
      footballTypeValue: footballTypeValue ?? this.footballTypeValue,
      statusForm : statusForm ?? this.statusForm,
      feeValue: feeValue ?? this.feeValue,
      screenState: screenState ?? this.screenState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }


  @override
  List<Object?> get props => [
    footballTypeList,
    footballTypeValue,
    statusForm,
    feeValue,
    screenState
  ];

}