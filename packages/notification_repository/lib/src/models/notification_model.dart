import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String title;
  final String body;
  final NotificationData? data;

  const NotificationModel({
    required this.title,
    required this.body,
    this.data,
  });

  static const empty = NotificationModel(title: '', body: '');

  bool get isEmpty => this == NotificationModel.empty;

  bool get isNotEmpty => this != NotificationModel.empty;

  @override
  List<Object?> get props => [title, body, data];
}

class NotificationData extends Equatable {
  final String actionType;

  const NotificationData({
    required this.actionType,
  });

  Map<String, dynamic> toJson() {
    return {
      'actionCode': actionType,
    };
  }

  factory NotificationData.fromJson(Map<String, dynamic> map) {
    return NotificationData(
      actionType: map['actionCode'] ?? '',
    );
  }

  @override
  List<Object> get props => [actionType];
}
