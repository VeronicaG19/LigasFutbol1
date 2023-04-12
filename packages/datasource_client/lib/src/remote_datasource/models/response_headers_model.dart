import '../../typedefs/typedefs.dart';

class ResponseHeadersModel {
  final bool error;
  final String message;
  final String? code;

  const ResponseHeadersModel({
    required this.error,
    required this.message,
    this.code,
  });

  factory ResponseHeadersModel.fromJson(JSON map) {
    return ResponseHeadersModel(
      error: map['error'] as bool,
      message: map['message'] as String,
      code: map['code'] as String,
    );
  }
}
