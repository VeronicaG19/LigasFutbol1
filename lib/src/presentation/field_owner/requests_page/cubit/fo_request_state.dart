part of 'fo_request_cubit.dart';

class FoRequestState extends Equatable {
  final List<FieldOwnerRequest> requestsList;
  final String? errorMessage;
  final BasicCubitScreenState screenStatus;

  const FoRequestState({
    this.requestsList = const [],
    this.errorMessage,
    this.screenStatus = BasicCubitScreenState.initial,
  });

  FoRequestState copyWith({
    List<FieldOwnerRequest>? requestsList,
    FieldOwnerRequest? selectedRequest,
    String? errorMessage,
    BasicCubitScreenState? screenStatus,
  }) {
    return FoRequestState(
      requestsList: requestsList ?? this.requestsList,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props => [requestsList, screenStatus];
}
