import 'package:equatable/equatable.dart';

const String _kHost = 'smtp.gmail.com';
const int _kPort = 587;
const String _kEmail = 'info.noreply.express@gmail.com';
const String _kPassword = 'ejngwxemkebajdei';

class NotificationEmail extends Equatable {
  final String host;
  final int port;
  final String email;
  final String password;
  final List<String> recipients;
  final String subject;
  final String message;

  const NotificationEmail(
      {required this.host,
      required this.port,
      required this.email,
      required this.password,
      required this.recipients,
      required this.subject,
      required this.message});

  @override
  List<Object> get props =>
      [host, port, email, password, recipients, subject, message];

  factory NotificationEmail.build(
      List<String> recipients, String subject, String message) {
    return NotificationEmail(
      host: _kHost,
      port: _kPort,
      email: _kEmail,
      password: _kPassword,
      recipients: recipients,
      subject: subject,
      message: message,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'host': host,
      'port': port,
      'email': email,
      'password': password,
      'to': recipients,
      'subject': subject,
      'message': message,
    };
  }
}
