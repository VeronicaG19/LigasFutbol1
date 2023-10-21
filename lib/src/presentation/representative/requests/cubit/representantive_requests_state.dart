part of 'representantive_requests_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class RepresentantiveRequestsState extends Equatable {
  final List<UserRequests> receivedRequestsList;
  final List<UserRequests> sentRequestsList;
  final List<UserRequests> adminRequestList;
  final String? errorMessage;
  final ScreenStatus screenStatus;
  //final List<TeamPlayer> teamPlayer;
  final ValidateRequestDTO validationrequet;

  const RepresentantiveRequestsState({
    this.receivedRequestsList = const [],
    this.sentRequestsList = const [],
    this.adminRequestList = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
    //this.teamPlayer = const [],
    this.validationrequet = ValidateRequestDTO.empty,
  });

  RepresentantiveRequestsState copyWith({
    List<UserRequests>? receivedRequestsList,
    List<UserRequests>? sentRequestsList,
    List<UserRequests>? adminRequestList,
    String? errorMessage,
    ScreenStatus? screenStatus,
    List<TeamPlayer>? teamPlayer,
    ValidateRequestDTO? validationrequet,
  }) {
    return RepresentantiveRequestsState(
      receivedRequestsList: receivedRequestsList ?? this.receivedRequestsList,
      sentRequestsList: sentRequestsList ?? this.sentRequestsList,
      adminRequestList: adminRequestList ?? this.adminRequestList,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
      //teamPlayer: teamPlayer ?? this.teamPlayer,
      validationrequet: validationrequet ?? this.validationrequet,
    );
  }

  @override
  List<Object?> get props => [
        receivedRequestsList,
        sentRequestsList,
        adminRequestList,
        screenStatus,
        //teamPlayer,
        validationrequet,
      ];
}
