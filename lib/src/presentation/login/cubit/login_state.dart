part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.token,
    this.isPasswordVisible = true,
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Username username;
  final Password password;
  final String? token;
  final bool isPasswordVisible;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props =>
      [username, password, token, isPasswordVisible, status];

  LoginState copyWith({
    Username? username,
    Password? password,
    String? token,
    bool? isPasswordVisible,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      token: token ?? this.token,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
