part of 'transfer_history_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class TransferHistoryState extends Equatable {
  final List<Team> teamList;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const TransferHistoryState({
    this.teamList = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  TransferHistoryState copyWith({
    List<Team>? teamList,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return TransferHistoryState(
      teamList: teamList ?? this.teamList,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props => [
        teamList,
        screenStatus,
      ];
}
