import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:user_repository/user_repository.dart';

import '../../../core/enums.dart';
import '../../../domain/user_requests/service/i_user_requests_service.dart';

part 'notification_event.dart';
part 'notification_state.dart';

@injectable
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc(this._notificationRepository, this._userRequestService)
      : super(const NotificationState.initial()) {
    on<_NotificationOpened>(_onNotificationOpened);
    on<_NotificationInForegroundReceived>(_onNotificationInForegroundReceived);
    on<LoadNotificationCount>(_onLoadNotificationCount);
    _notificationRepository.onNotificationOpened.listen((event) {
      add(_NotificationOpened(notification: event));
    });
    _notificationRepository.onForegroundNotification.listen((event) {
      add(_NotificationInForegroundReceived(notification: event));
    });
  }

  final NotificationRepository _notificationRepository;
  final IUserRequestsService _userRequestService;
  int _requestTo = 0;
  ApplicationRol _applicationRol = ApplicationRol.player;

  void _onNotificationOpened(
      _NotificationOpened event, Emitter<NotificationState> emit) {
    emit(state.copyWith(notification: NotificationModel.empty));
    emit(state.copyWith(
        notification: event.notification, appState: AppState.background));
    add(LoadNotificationCount(_requestTo, _applicationRol));
  }

  void _onNotificationInForegroundReceived(
      _NotificationInForegroundReceived event,
      Emitter<NotificationState> emit) {
    emit(state.copyWith(notification: NotificationModel.empty));
    emit(state.copyWith(
        notification: event.notification, appState: AppState.foreground));
    add(LoadNotificationCount(_requestTo, _applicationRol));
  }

  void _onLoadNotificationCount(
      LoadNotificationCount event, Emitter<NotificationState> emit) async {
    final count = await _onLoadNotifications(event.requestTo, event.rol);
    emit(state.copyWith(notificationCount: count));
  }

  Future<int> _onLoadNotifications(int? requestTo, ApplicationRol rol) async {
    _requestTo = requestTo ?? 0;
    _applicationRol = rol;
    if (rol == ApplicationRol.fieldOwner) {
      final count = await _userRequestService.getRequestCount(requestTo ?? 0,
          type: RequestType.MATCH_TO_FIELD);
      return count;
    }
    return await _userRequestService.getRequestCount(requestTo ?? 0, rol: rol);
  }
}
