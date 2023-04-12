part of 'notification_cubit.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationLoading extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationLoaded extends NotificationState {
  final UserConfiguration configuration;
  const NotificationLoaded(this.configuration);

  @override
  List<Object> get props => [configuration];
}

class NotificationError extends NotificationState {
  final String errorMessage;
  const NotificationError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
