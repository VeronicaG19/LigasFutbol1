part of 'user_requests_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class UserRequestsState extends Equatable {
  final List<UserRequests> sentRequestsList;
  final List<UserRequests> receivedRequestsList;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const UserRequestsState({
    this.sentRequestsList = const [],
    this.receivedRequestsList = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  }); 

  UserRequestsState copyWith({
    List<UserRequests>? sentRequestsList,
    List<UserRequests>? receivedRequestsList,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return UserRequestsState(
      sentRequestsList: sentRequestsList ?? this.sentRequestsList,
      receivedRequestsList: receivedRequestsList ?? this.receivedRequestsList,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object?> get props => [
        sentRequestsList,
        receivedRequestsList,
        screenStatus,
      ];
}
