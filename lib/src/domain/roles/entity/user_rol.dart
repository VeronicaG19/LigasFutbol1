import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

import '../../user_configuration/entity/user_configuration.dart';
import 'rol.dart';

class UserRol extends Equatable {
  final String primaryFlag;
  final Rol rol;
  final User? user;
  final UserConfiguration configuration;
  final int userRolId;

  const UserRol({
    required this.primaryFlag,
    required this.rol,
    required this.configuration,
    required this.userRolId,
    this.user,
  });

  static const empty = UserRol(
      primaryFlag: 'N',
      rol: Rol.empty,
      configuration: UserConfiguration.empty,
      userRolId: 0);

  factory UserRol.fromJson(Map<String, dynamic> json) {
    return UserRol(
      primaryFlag: json['primaryFlag'] ?? 'N',
      rol: json['rol'] == null ? Rol.empty : Rol.fromJson(json['rol']),
      configuration: json['userConfiguration'] == null
          ? UserConfiguration.empty
          : UserConfiguration.fromJson(json['userConfiguration']),
      userRolId: json['userRolId'] ?? json['userRoleId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'primaryFlag': primaryFlag,
      'rol': rol.toJson(),
      'configuration': configuration.toJson(),
      'userRolId': userRolId,
      'userId': user?.toJson(),
    };
  }

  Map<String, dynamic> toJsonUpRl() {
    return {
      'primaryFlag': primaryFlag,
      'rol': rol.toJson(),
      'userRolId': userRolId,
      'userId': user?.toJson(),
    };
  }

  UserRol copyWith({
    String? primaryFlag,
    Rol? rol,
    UserConfiguration? configuration,
    int? userRolId,
  }) {
    return UserRol(
      primaryFlag: primaryFlag ?? this.primaryFlag,
      rol: rol ?? this.rol,
      configuration: configuration ?? this.configuration,
      userRolId: userRolId ?? this.userRolId,
    );
  }

  @override
  List<Object> get props => [primaryFlag, rol, configuration, userRolId];
}
