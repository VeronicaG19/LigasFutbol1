part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class _NotificationOpened extends NotificationEvent {
  final NotificationModel notification;

  const _NotificationOpened({
    required this.notification,
  });

  @override
  List<Object> get props => [notification];
}

class _NotificationInForegroundReceived extends NotificationEvent {
  final NotificationModel notification;

  const _NotificationInForegroundReceived({
    required this.notification,
  });

  @override
  List<Object> get props => [notification];
}

class LoadNotificationCount extends NotificationEvent {
  final int? requestTo;
  final ApplicationRol rol;
  const LoadNotificationCount(this.requestTo, this.rol);

  @override
  List<Object?> get props => [requestTo, rol];
}
