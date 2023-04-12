part of 'referee_match_fee_list_cubit.dart';

class RefereeMatchFeeListState extends Equatable{
  final List<AllMyAssetsDTO> feeList;
  final BasicCubitScreenState screenState;
  final String? errorMessage;

  const RefereeMatchFeeListState({
    this.feeList = const [],
    this.screenState = BasicCubitScreenState.initial,
    this.errorMessage,
  });

  RefereeMatchFeeListState copyWith({
    List<AllMyAssetsDTO>? feeList,
    BasicCubitScreenState? screenState,
    String? errorMessage,
}) {
    return RefereeMatchFeeListState(
      feeList: feeList ?? this.feeList,
      screenState: screenState ?? this.screenState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
}


  @override
  List<Object?> get props => [
    feeList,
    screenState,
  ];
}
