part of 'notification_bloc.dart';

enum AppState {
  background,
  foreground;

  bool get isBackground => this == AppState.background;

  bool get isForeground => this == AppState.foreground;
}

class NotificationState extends Equatable {
  final NotificationModel notification;
  final AppState? appState;
  final int notificationCount;

  const NotificationState({
    this.notification = NotificationModel.empty,
    this.appState,
    this.notificationCount = 0,
  });

  const NotificationState.initial() : this();

  NotificationState copyWith({
    NotificationModel? notification,
    AppState? appState,
    int? notificationCount,
  }) {
    return NotificationState(
      notification: notification ?? this.notification,
      appState: appState ?? this.appState,
      notificationCount: notificationCount ?? this.notificationCount,
    );
  }

  @override
  List<Object?> get props => [notification, appState, notificationCount];
}
