part of 'seek_player_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  inSelectCategory,
  nullCategory,
  tournamentloading,
  tournamentloaded,
  infoLoading,
  lookupsLoaded,
  successfullyCreated,
  updatedSuccessful,
  succes,
  loaded,
  error,
}

class SeekPlayerState extends Equatable {
  final ScreenStatus screenStatus;
  final String? errorMessage;
  final Comment comment;
  final String notificationFlag;
  final FormzStatus status;

  const SeekPlayerState({
    this.screenStatus = ScreenStatus.initial,
    this.notificationFlag = 'N',
    this.errorMessage,
    this.comment = const Comment.pure(),
    this.status = FormzStatus.pure,
  });

  SeekPlayerState copyWith({
    ScreenStatus? screenStatus,
    String? errorMessage,
    Comment? comment,
    String? notificationFlag,
    FormzStatus? status,
  }) {
    return SeekPlayerState(
      screenStatus: screenStatus ?? this.screenStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      notificationFlag: notificationFlag ?? this.notificationFlag,
      comment: comment ?? this.comment,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props =>
      [screenStatus, errorMessage, comment, status, notificationFlag];
}
