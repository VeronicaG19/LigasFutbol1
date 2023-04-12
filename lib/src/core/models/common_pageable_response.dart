import 'package:datasource_client/datasource_client.dart';
import 'package:equatable/equatable.dart';

class CommonPageableResponse<T> extends Equatable {
  final List<T> content;
  final int size;
  final int totalElements;
  final int totalPages;
  final int number;

  const CommonPageableResponse({
    this.content = const [],
    this.size = 0,
    this.totalElements = 0,
    this.totalPages = 0,
    this.number = 0,
  });

  CommonPageableResponse<T> copyWith({
    List<T>? content,
    int? size,
    int? totalElements,
    int? totalPages,
    int? number,
  }) {
    return CommonPageableResponse<T>(
      content: content ?? this.content,
      size: size ?? this.size,
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
      number: number ?? this.number,
    );
  }

  factory CommonPageableResponse.fromJson(
      {required JSON json,
      required T Function(JSON responseBody) converter,
      required String item}) {
    final list =
        json['_embedded'][item] == null ? [] : json['_embedded'][item] as List;
    return CommonPageableResponse(
      content: list.map((e) => converter(e! as JSON)).toList(),
      size: json['page']['size'] as int,
      totalElements: json['page']['totalElements'] as int,
      totalPages: json['page']['totalPages'] as int,
      number: json['page']['number'] as int,
    );
  }

  @override
  List<Object> get props => [
        content,
        size,
        totalElements,
        totalPages,
        number,
      ];
}
