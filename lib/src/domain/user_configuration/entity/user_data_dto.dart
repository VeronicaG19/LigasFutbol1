import '../../roles/entity/user_rol.dart';

class UserDataDTO {
  final String email;
  final String personName;
  final String phoneNumber;
  final String userName;
  final List<UserRol> userRoles;

  const UserDataDTO({
    required this.email,
    required this.personName,
    required this.phoneNumber,
    required this.userName,
    required this.userRoles,
  });

  factory UserDataDTO.fromJson(Map<String, dynamic> json) {
    return UserDataDTO(
      email: json['email'] as String,
      personName: json['personName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      userName: json['userName'] as String,
      userRoles: _validateUserRollList(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'personName': personName,
      'phoneNumber': phoneNumber,
      'userName': userName,
      'userRoles': userRoles,
    };
  }

  static List<UserRol> _validateUserRollList(Map<String, dynamic> json) {
    final userRolList =
        json['userRoles'] == null ? <UserRol>[] : json['userRoles'] as List;
    return userRolList.isEmpty
        ? []
        : [
            ...userRolList.map(
              (e) => UserRol.fromJson(e),
            ),
          ];
  }
}
