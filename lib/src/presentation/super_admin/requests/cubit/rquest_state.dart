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
  final SimpleTextValidator description;
  final FormzStatus formzStatus;
  final List<UserRequests> request;

  const RquestState(
      {this.screenStatus = ScreenStatus.initial,
      this.formzStatus = FormzStatus.pure,
      this.description = const SimpleTextValidator.pure(),
      this.errorMessage,
      this.request = const []});

  RquestState copyWith(
      {ScreenStatus? screenStatus,
      String? errorMessage,
      SimpleTextValidator? description,
      FormzStatus? formzStatus,
      List<UserRequests>? request}) {
    return RquestState(
        screenStatus: screenStatus ?? this.screenStatus,
        description: description ?? this.description,
        formzStatus: formzStatus ?? this.formzStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        request: request ?? this.request);
  }

  @override
  List<Object?> get props =>
      [screenStatus, errorMessage, description, formzStatus, request];
}
