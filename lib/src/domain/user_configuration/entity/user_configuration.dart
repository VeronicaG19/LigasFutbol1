import 'package:equatable/equatable.dart';

class UserConfiguration extends Equatable {
  final String enabledFlag;
  final String notificationEmail;
  final String notificationFlag;
  final String notificationPhone;
  final int? id;
  final int userRolId;

  const UserConfiguration({
    required this.enabledFlag,
    required this.notificationEmail,
    required this.notificationFlag,
    required this.notificationPhone,
    this.id,
    required this.userRolId,
  });

  static const empty = UserConfiguration(
      enabledFlag: 'Y',
      notificationEmail: 'N',
      notificationFlag: 'N',
      notificationPhone: 'N',
      userRolId: 0);

  bool get isEmpty => this == UserConfiguration.empty;

  bool get isNotEmpty => this != UserConfiguration.empty;

  factory UserConfiguration.fromJson(Map<String, dynamic> json) {
    return UserConfiguration(
      enabledFlag: json['enabledFlag'] ?? 'N',
      notificationEmail: json['notificationEmail'] ?? 'N',
      notificationFlag: json['notificationFlag'] ?? 'N',
      notificationPhone: json['notificationPhone'] ?? 'N',
      id: json['userConfigurationId'],
      userRolId: json['userRoleId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabledFlag': enabledFlag,
      'notificationEmail': notificationEmail,
      'notificationFlag': notificationFlag,
      'notificationPhone': notificationPhone,
      'userConfigurationId': id,
      'userRoleId': userRolId,
    };
  }

  UserConfiguration copyWith({
    String? enabledFlag,
    String? notificationEmail,
    String? notificationFlag,
    String? notificationPhone,
    int? id,
    int? userRolId,
  }) {
    return UserConfiguration(
      enabledFlag: enabledFlag ?? this.enabledFlag,
      notificationEmail: notificationEmail ?? this.notificationEmail,
      notificationFlag: notificationFlag ?? this.notificationFlag,
      notificationPhone: notificationPhone ?? this.notificationPhone,
      id: id ?? this.id,
      userRolId: userRolId ?? this.userRolId,
    );
  }

  @override
  List<Object?> get props => [
        enabledFlag,
        notificationEmail,
        notificationFlag,
        notificationPhone,
        id,
        userRolId,
      ];
}
