part of 'role_cubit.dart';

class RoleState extends Equatable {
  final UserRol currentRol;
  final ApplicationRol rolChanged;
  final List<UserRol> associatedRoles;
  final List<Rol> availableRoles;
  final BasicCubitScreenState screenState;
  final String? errorMessage;

  const RoleState({
    this.currentRol = UserRol.empty,
    this.rolChanged = ApplicationRol.player,
    this.associatedRoles = const [],
    this.availableRoles = const [],
    this.screenState = BasicCubitScreenState.initial,
    this.errorMessage,
  });

  RoleState copyWith({
    UserRol? currentRol,
    ApplicationRol? rolChanged,
    List<UserRol>? associatedRoles,
    List<Rol>? availableRoles,
    BasicCubitScreenState? screenState,
    String? errorMessage,
  }) {
    return RoleState(
      currentRol: currentRol ?? this.currentRol,
      rolChanged: rolChanged ?? this.rolChanged,
      associatedRoles: associatedRoles ?? this.associatedRoles,
      availableRoles: availableRoles ?? this.availableRoles,
      screenState: screenState ?? this.screenState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        currentRol,
        rolChanged,
        associatedRoles,
        availableRoles,
        screenState,
      ];
}
