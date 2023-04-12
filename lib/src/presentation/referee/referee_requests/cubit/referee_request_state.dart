part of 'referee_request_cubit.dart';

class RefereeRequestState extends Equatable {
  final List<UserRequests> sentRequestsList;
  final List<UserRequests> receivedRequestsList;
  final List<RequestMatchToRefereeDTO> requestMatchRefereeList;
  final String? errorMessage;
  final BasicCubitScreenState screenStatus;

  const RefereeRequestState({
    this.sentRequestsList = const [],
    this.receivedRequestsList = const [],
    this.requestMatchRefereeList = const [],
    this.errorMessage,
    this.screenStatus = BasicCubitScreenState.initial,
  });

  RefereeRequestState copyWith({
    List<UserRequests>? sentRequestsList,
    List<UserRequests>? receivedRequestsList,
    List<RequestMatchToRefereeDTO>? requestMatchRefereeList,
    String? errorMessage,
    BasicCubitScreenState? screenStatus,
  }) {
    return RefereeRequestState(
      sentRequestsList: sentRequestsList ?? this.sentRequestsList,
      receivedRequestsList: receivedRequestsList ?? this.receivedRequestsList,
      requestMatchRefereeList: requestMatchRefereeList ?? this.requestMatchRefereeList,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object?> get props => [
    sentRequestsList,
    receivedRequestsList,
    requestMatchRefereeList,
    screenStatus,
  ];
}
