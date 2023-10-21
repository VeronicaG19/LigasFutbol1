import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO extends Equatable {
  final String? description;
  final String? enabledFlag;
  final String? firstName;
  final String? lastName;
  final String? password;
  final int? personId;
  final String? primaryFlag;
  final int? userId;
  final String? userName;

  const UserDTO({
    this.description,
    this.enabledFlag,
    this.firstName,
    this.lastName,
    this.password,
    this.personId,
    this.primaryFlag,
    this.userId,
    this.userName,
  });

  UserDTO copyWith({
    String? description,
    String? enabledFlag,
    String? firstName,
    String? lastName,
    String? password,
    int? personId,
    String? primaryFlag,
    int? userId,
    String? userName,
  }) {
    return UserDTO(
      description: description ?? this.description,
      enabledFlag: enabledFlag ?? this.enabledFlag,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
      personId: personId ?? this.personId,
      primaryFlag: primaryFlag ?? this.primaryFlag,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
    );
  }

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);

  static const empty = UserDTO();

  bool get isEmpty => this == UserDTO.empty;

  bool get isNotEmpty => this != UserDTO.empty;

  @override
  List<Object?> get props => [
        description,
        enabledFlag,
        firstName,
        lastName,
        password,
        personId,
        primaryFlag,
        userId,
        userName,
      ];
}
