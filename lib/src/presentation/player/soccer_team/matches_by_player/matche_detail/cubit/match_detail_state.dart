part of 'match_detail_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class MatcheDetailState extends Equatable {
  final List<DetailMatchDTO> detailMatchDTO;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const MatcheDetailState({
    this.detailMatchDTO = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  MatcheDetailState copyWith({
    List<DetailMatchDTO>? detailMatchDTO,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return MatcheDetailState(
      detailMatchDTO: detailMatchDTO ?? this.detailMatchDTO,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props => [detailMatchDTO, screenStatus];
}
