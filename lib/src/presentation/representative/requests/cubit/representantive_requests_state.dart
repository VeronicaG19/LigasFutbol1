part of 'representantive_requests_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class RepresentantiveRequestsState extends Equatable{
  final List<UserRequests> receivedRequestsList;
  final List<UserRequests> sentRequestsList;
  final List<UserRequests> adminRequestList;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const RepresentantiveRequestsState({
    this.receivedRequestsList = const [],
    this.sentRequestsList = const [],
    this.adminRequestList = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  RepresentantiveRequestsState copyWith({
    List<UserRequests>? receivedRequestsList,
    List<UserRequests>? sentRequestsList,
    List<UserRequests>? adminRequestList,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return RepresentantiveRequestsState(
      receivedRequestsList: receivedRequestsList ?? this.receivedRequestsList,
      sentRequestsList: sentRequestsList ?? this.sentRequestsList,
      adminRequestList: adminRequestList ?? this.adminRequestList,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object?> get props => [
    receivedRequestsList,
    sentRequestsList,
    adminRequestList,
    screenStatus,
  ];
}
