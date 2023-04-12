part of 'rquest_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

 class RquestState extends Equatable {
  final String? errorMessage; 
  final ScreenStatus screenStatus;
  final List<UserRequests> request;

  const RquestState(
    {
      this.screenStatus = ScreenStatus.initial,
      this.errorMessage,
      this.request = const []
    }
    );

    RquestState copyWith({
      ScreenStatus? screenStatus,
      String? errorMessage,
      List<UserRequests>? request
    }){
      return RquestState(
        screenStatus: screenStatus ?? this.screenStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        request: request ?? this.request
      );
    }

  @override
  List<Object?> get props => [screenStatus, errorMessage,request];
}
