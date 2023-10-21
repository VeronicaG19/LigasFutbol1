import 'package:equatable/equatable.dart';

class DeviceData extends Equatable {
  final int? deviceDataId;
  final String? fcmToken;
  final String osName;
  final String osVersion;
  final int partyId;
  final String pushStatus;
  final AppId? appId;

  const DeviceData({
    this.deviceDataId,
    this.fcmToken,
    required this.osName,
    required this.osVersion,
    required this.partyId,
    required this.pushStatus,
    this.appId,
  });

  DeviceData copyWith({
    int? deviceDataId,
    String? fcmToken,
    String? osName,
    String? osVersion,
    int? partyId,
    String? pushStatus,
    AppId? appId,
  }) {
    return DeviceData(
      deviceDataId: deviceDataId ?? this.deviceDataId,
      fcmToken: fcmToken ?? this.fcmToken,
      osName: osName ?? this.osName,
      osVersion: osVersion ?? this.osVersion,
      partyId: partyId ?? this.partyId,
      pushStatus: pushStatus ?? this.pushStatus,
      appId: appId ?? this.appId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceDataId': deviceDataId,
      'fcmToken': fcmToken,
      'osName': osName,
      'osVersion': osVersion,
      'partyId': partyId,
      'pushStatus': pushStatus,
      'appId': appId?.toJson(),
    };
  }

  factory DeviceData.fromJson(Map<String, dynamic> map) {
    return DeviceData(
      deviceDataId: map['deviceDataId'] as int,
      fcmToken: map['fcmToken'] as String,
      osName: map['osName'] as String,
      osVersion: map['osVersion'] as String,
      partyId: map['partyId'] as int,
      pushStatus: map['pushStatus'] as String,
      appId: AppId.fromJson(map['appId']),
    );
  }

  @override
  List<Object?> get props => [
        deviceDataId,
        fcmToken,
        osName,
        osVersion,
        partyId,
        pushStatus,
        appId,
      ];
}

class AppId extends Equatable {
  final String? appCode;
  final int appId;
  final String? appMobile;
  final String? appName;
  final String? appWeb;
  final String? versionMobile;
  final String? versionWeb;

  const AppId({
    this.appCode,
    required this.appId,
    this.appMobile,
    this.appName,
    this.appWeb,
    this.versionMobile,
    this.versionWeb,
  });

  AppId copyWith({
    String? appCode,
    int? appId,
    String? appMobile,
    String? appName,
    String? appWeb,
    String? versionMobile,
    String? versionWeb,
  }) {
    return AppId(
      appCode: appCode ?? this.appCode,
      appId: appId ?? this.appId,
      appMobile: appMobile ?? this.appMobile,
      appName: appName ?? this.appName,
      appWeb: appWeb ?? this.appWeb,
      versionMobile: versionMobile ?? this.versionMobile,
      versionWeb: versionWeb ?? this.versionWeb,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appCode': appCode,
      'appId': appId,
      'appMobile': appMobile,
      'appName': appName,
      'appWeb': appWeb,
      'versionMobile': versionMobile,
      'versionWeb': versionWeb,
    };
  }

  factory AppId.fromJson(Map<String, dynamic> map) {
    return AppId(
      appCode: map['appCode'],
      appId: map['appId'] ?? 3,
      appMobile: map['appMobile'],
      appName: map['appName'],
      appWeb: map['appWeb'],
      versionMobile: map['versionMobile'],
      versionWeb: map['versionWeb'],
    );
  }

  @override
  List<Object?> get props => [
        appCode,
        appId,
        appMobile,
        appName,
        appWeb,
        versionMobile,
        versionWeb,
      ];
}
