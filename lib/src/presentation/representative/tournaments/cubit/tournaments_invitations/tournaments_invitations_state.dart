part of 'tournaments_invitations_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
  sendingResponse,
  responseSended,
  cancelRequest,
  responseError,
}

class TournamentsInvitationsState extends Equatable {
  final List<UserRequests> invitationsList;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const TournamentsInvitationsState({
    this.invitationsList = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  TournamentsInvitationsState copyWith({
    List<UserRequests>? invitationsList,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return TournamentsInvitationsState(
      invitationsList: invitationsList ?? this.invitationsList,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object?> get props => [invitationsList, errorMessage, screenStatus];
}
