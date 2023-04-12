import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_requests.g.dart';

@JsonSerializable()
class UserRequests extends Equatable {
  @JsonKey(name: 'request_ID')
  final int requestId;

  @JsonKey(name: 'request_MADE_BY_ID')
  final int requestMadeById;

  @JsonKey(name: 'request_TO_ID')
  final int? requestToId;

  @JsonKey(name: 'status_request')
  final String requestStatus;

  @JsonKey(name: 'type_REQUEST')
  final String typeRequest;

  @JsonKey(name: 'request_MADE_BY')
  final String requestMadeBy;

  @JsonKey(name: 'request_TO')
  final String? requestTo;

  final String? content;

  final String? comments;

  const UserRequests({
    required this.requestId,
    required this.requestMadeById,
    this.requestToId,
    required this.requestStatus,
    required this.typeRequest,
    required this.requestMadeBy,
    this.requestTo,
    this.content,
    this.comments,
  });

  factory UserRequests.fromJson(Map<String, dynamic> json) =>
      _$UserRequestsFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestsToJson(this);

  static const empty = UserRequests(
      requestId: 0,
      requestMadeById: 0,
      requestStatus: '',
      typeRequest: '',
      requestMadeBy: '');

  UserRequests copyWith({
    int? requestId,
    int? requestMadeById,
    int? requestToId,
    String? requestStatus,
    String? typeRequest,
    String? requestMadeBy,
    String? requestTo,
    String? content,
    String? comments,
  }) {
    return UserRequests(
      requestId: requestId ?? this.requestId,
      requestMadeById: requestMadeById ?? this.requestMadeById,
      requestToId: requestToId ?? this.requestToId,
      requestStatus: requestStatus ?? this.requestStatus,
      typeRequest: typeRequest ?? this.typeRequest,
      requestMadeBy: requestMadeBy ?? this.requestMadeBy,
      requestTo: requestTo ?? this.requestTo,
      content: content ?? this.content,
      comments: comments ?? this.comments,
    );
  }

  @override
  List<Object?> get props => [
        requestId,
        requestMadeById,
        requestToId,
        requestStatus,
        typeRequest,
        requestMadeBy,
        requestTo,
        content,
        comments,
      ];

  Map<String, dynamic> toJsonForSave() {
    return {
      'requestId': requestId,
      'requestMadeById': requestMadeById,
      'requestToId': requestToId,
      'requestStatus': requestStatus,
      'typeRequest': typeRequest,
      'requestMadeBy': requestMadeBy,
      'requestTo': requestTo,
      'content': content,
      'comments': comments,
    };
  }

  Map<String, dynamic> toJsonForReferee() {
    return {
      'requestId': requestId,
      'requestMadeById': requestMadeById,
      'requestToId': requestToId,
      'requestStatus': requestStatus,
      'typeRequest': typeRequest,
      'enabledFlag': 'Y',
      'content': content,
      'comments': comments,
    };
  }

  factory UserRequests.fromJsonSaveResp(Map<String, dynamic> json) {
    return UserRequests(
      requestId: json['requestId'] ?? 0,
      requestMadeById: json['requestMadeById'] ?? 0,
      requestToId: json['requestToId'] ?? 0,
      requestStatus: json['requestStatus']?.toString() ?? '',
      typeRequest: json['typeRequest']?.toString() ?? '',
      requestMadeBy: json['requestMadeBy']?.toString() ?? '',
      requestTo: json['requestTo'] ?? '',
      content: json['content'] ?? '',
      comments: json['comments'] ?? '',
    );
  }
}
