import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_request_dto.g.dart';

@JsonSerializable()
class ResponseRequestDTO extends Equatable {
  final  String? comments;
  final  String? content;
  final  String? enabledFlag;
  final  int? requestId;
  final  int? requestMadeById;
  final  int? requestStatus;
  final  int? requestToId;
  final  int? typeRequest;


  const ResponseRequestDTO({
    this.comments,
    this.content,
    this.enabledFlag,
    this.requestId,
    this.requestMadeById,
    this.requestStatus,
    this.requestToId,
    this.typeRequest,
  });

  ResponseRequestDTO copyWith({
    String? comments,
    String? content,
    String? enabledFlag,
    int? requestId,
    int? requestMadeById,
    int? requestStatus,
    int? requestToId,
    int? typeRequest,
  }) {
    return ResponseRequestDTO(
      comments: comments ?? this.comments,
      content: content ?? this.content,
      enabledFlag: enabledFlag ?? this.enabledFlag,
      requestId: requestId ?? this.requestId,
      requestMadeById: requestMadeById ?? this.requestMadeById,
      requestStatus: requestStatus ?? this.requestStatus,
      requestToId: requestToId ?? this.requestToId,
      typeRequest: typeRequest ?? this.typeRequest,
    );
  }

  static const empty = ResponseRequestDTO();

  /// Connect the generated [_$ResponseRequestDTOFromJson] function to the `fromJson`
  /// factory.
  factory ResponseRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$ResponseRequestDTOFromJson(json);

  /// Connect the generated [_$RequestToAdmonDTOJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ResponseRequestDTOToJson(this);

  @override
  List<Object?> get props => [
    comments ,
    content ,
    enabledFlag ,
    requestId ,
    requestMadeById ,
    requestStatus ,
    requestToId ,
    typeRequest ];
}

