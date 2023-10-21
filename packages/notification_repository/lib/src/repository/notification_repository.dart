import 'dart:io';

import 'package:datasource_client/datasource_client.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart' hide Notification;

import '../endpoints.dart';
import '../models/device_data.dart';
import '../models/notification_model.dart';
import 'device_data_repository_impl.dart';
import 'i_device_data_repository.dart';

class NotificationRepository {
  final FirebaseMessaging _firebaseMessaging;
  final Stream<RemoteMessage> _onForegroundNotification;
  final BehaviorSubject<NotificationModel> _onNotificationOpenedController;
  final String? _vapidKey;
  String _token = '';
  final ApiClient _apiClient;
  late final DeviceDataRepository _deviceDataRepository =
      DeviceDataRepositoryImpl(_apiClient);

  NotificationRepository({
    FirebaseMessaging? firebaseMessaging,
    required ApiClient apiClient,
    required String baseUrl,
    required String personBaseURL,
    required String notificationBaseURL,
    required String appName,
    required int appId,
    String? vapidKey,
    Stream<RemoteMessage>? onNotificationOpened,
    Stream<RemoteMessage>? onForegroundNotification,
    Stream<RemoteMessage>? onBackgroundNotification,
  })  : _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance,
        _onForegroundNotification =
            onForegroundNotification ?? FirebaseMessaging.onMessage,
        _apiClient = apiClient,
        _vapidKey = vapidKey,
        _onNotificationOpenedController = BehaviorSubject<NotificationModel>() {
    Endpoints.init(baseUrl, personBaseURL, notificationBaseURL, appName, appId);
    _initialize(onNotificationOpened ?? FirebaseMessaging.onMessageOpenedApp);
  }

  Future<void> _initialize(Stream<RemoteMessage> onNotificationOpened) async {
    final response = await _firebaseMessaging.requestPermission();
    final status = response.authorizationStatus;
    if (status == AuthorizationStatus.authorized) {
      _token = await _firebaseMessaging.getToken() ?? '';
      final message = await _firebaseMessaging.getInitialMessage();
      final token = await _firebaseMessaging.getToken(vapidKey: _vapidKey);
      await _sendTokenToServer(token!);
      if (message != null) {
        _onMessageOpened(message);
      }
      onNotificationOpened.listen(_onMessageOpened);
    } else {
      _token = '';
    }
  }

  Future<void> _sendTokenToServer(String token) {
    return Future.sync(() => null);
  }

  Future<void> _onMessageOpened(RemoteMessage message) async {
    final notification = message.notification;
    if (notification != null) {
      _onNotificationOpenedController.sink.add(
        NotificationModel(
            title: notification.title ?? '',
            body: notification.body ?? '',
            data: NotificationData.fromJson(message.data)),
      );
    }
  }

  Stream<NotificationModel> get onNotificationOpened =>
      _onNotificationOpenedController.stream;

  Stream<NotificationModel> get onForegroundNotification {
    return _onForegroundNotification.mapNotNull((message) {
      final notification = message.notification;
      if (notification == null) {
        return null;
      }
      return NotificationModel(
          title: notification.title ?? '',
          body: notification.body ?? '',
          data: NotificationData.fromJson(message.data));
    });
  }

  String? get fcmToken => _token;

  Future<void> postDeviceData(int personId, AppId appId) async {
    final tokenStatus =
        _apiClient.localStorage.getGenericObject<bool>('fcm__token_status');
    if (kIsWeb) return;
    if (tokenStatus != null && tokenStatus || _token.isEmpty) return;
    final String os = Platform.operatingSystem;
    final String version = Platform.version;
    final deviceData = DeviceData(
      osName: os,
      osVersion: version.substring(0, version.indexOf(' ')).trim(),
      partyId: personId,
      pushStatus: 'ON',
      fcmToken: _token,
      appId: appId,
    );
    final response = await _deviceDataRepository.postDeviceData(deviceData);
    response.fold(
        (l) => null,
        (r) =>
            _apiClient.localStorage.setGenericObjet('fcm__token_status', true));
  }

  Future<void> deleteDeviceData(int personId) async {
    if (kIsWeb) return;
    _deviceDataRepository.deleteDeviceData(personId);
  }
}
