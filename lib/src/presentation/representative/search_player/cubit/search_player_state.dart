part of 'search_player_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
  success,
}

class SearchPlayerState extends Equatable {
  final ScreenStatus screenStatus;
  final List<FullPlayerVsDTO> searchPlayer;
  final String msm;
  final List<FullPlayerVsDTO> listPlayers;
  final CommonPageableResponse<FullPlayerVsDTO> playerPageable;
  final int currentTeamId;
  final bool noMatches;

  const SearchPlayerState({
    this.screenStatus = ScreenStatus.initial,
    this.msm = '',
    this.searchPlayer = const [],
    this.listPlayers = const [],
    this.playerPageable = const CommonPageableResponse<FullPlayerVsDTO>(),
    this.currentTeamId = 0,
    this.noMatches = false,
  });

  SearchPlayerState copyWith({
    ScreenStatus? screenStatus,
    List<FullPlayerVsDTO>? searchPlayer,
    String? msm,
    List<FullPlayerVsDTO>? listPlayers,
    CommonPageableResponse<FullPlayerVsDTO>? playerPageable,
    int? currentTeamId,
    bool? noMatches,
  }) {
    return SearchPlayerState(
      screenStatus: screenStatus ?? this.screenStatus,
      searchPlayer: searchPlayer ?? this.searchPlayer,
      msm: msm ?? this.msm,
      listPlayers: listPlayers ?? this.listPlayers,
      playerPageable: playerPageable ?? this.playerPageable,
      currentTeamId: currentTeamId ?? this.currentTeamId,
      noMatches: noMatches ?? this.noMatches,
    );
  }

  @override
  List<Object?> get props => [
        screenStatus,
        searchPlayer,
        msm,
        listPlayers,
        playerPageable,
        currentTeamId,
        noMatches,
      ];
}
