part of 'search_player_cubit.dart';

enum ScreenStatus{
  initial,
  loading,
  loaded,
  error,
  success,
}
class SearchPlayerState extends Equatable{

  final ScreenStatus screenStatus;
  final List<SearchPlayerDTO> searchPlayer;

  const SearchPlayerState({
    this.screenStatus = ScreenStatus.initial,
    this.searchPlayer = const []
});

  SearchPlayerState copyWith({
    ScreenStatus? screenStatus,
    List<SearchPlayerDTO>? searchPlayer,
}){
    return SearchPlayerState(
      screenStatus: screenStatus ?? this.screenStatus,
      searchPlayer: searchPlayer ?? this.searchPlayer
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [screenStatus,searchPlayer];

}