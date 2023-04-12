import '../../typedefs/typedefs.dart';

class ResponseModel<T> {
  final T body;

  const ResponseModel({
    required this.body,
  });

  factory ResponseModel.fromJson(JSON json) {
    return ResponseModel(
      body: json as T,
    );
  }

  factory ResponseModel.fromList(List<dynamic> list) {
    return ResponseModel(
      body: list as T,
    );
  }
}
