part of 'request_remove_player_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
  success,
}

class RequestRemovePlayerState extends Equatable {
  final List<UserRequests> userRequest;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const RequestRemovePlayerState({
    this.userRequest = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  RequestRemovePlayerState copyWith({
    List<UserRequests>? userRequest,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return RequestRemovePlayerState(
      userRequest: userRequest ?? this.userRequest,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props => [
        userRequest,
        screenStatus,
      ];
}
