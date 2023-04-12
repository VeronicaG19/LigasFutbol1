part of 'referee_search_cubit.dart';


enum ScreenStatus {
  createingReferee,
  selectReferee,
  initial,
  loading,
  loaded,
  error,
  sending,
  success
}

class RefereeSearchState extends Equatable {
  final List<RefereeByLeagueDTO> refereetList;
  final RefereeDetailDTO refereeDetailDTO;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const RefereeSearchState({
    this.refereetList = const [],
    this.refereeDetailDTO = RefereeDetailDTO.empty,
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  RefereeSearchState copyWith({
    List<RefereeByLeagueDTO>? refereetList,
    RefereeDetailDTO? refereeDetailDTO,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return RefereeSearchState(
      refereetList: refereetList ?? this.refereetList,
      refereeDetailDTO: refereeDetailDTO ?? this.refereeDetailDTO,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }



  @override
  List<Object> get props => [
    refereetList,
    screenStatus,
  ];


}
