import 'package:equatable/equatable.dart';

class Recommendations extends Equatable {
  final String? enabledFlag;
  final int? recommendationId;
  final int? recommendationStatus;
  final int? recommendedBy;
  final int? recommendedId;
  final int? recommendedToId;
  final int? typeOfRecommended;

  const Recommendations({
    this.enabledFlag,
    this.recommendationId,
    this.recommendationStatus,
    this.recommendedBy,
    this.recommendedId,
    this.recommendedToId,
    this.typeOfRecommended,
  });

  static const empty = Recommendations(
      enabledFlag: 'Y',
      recommendationId: 0,
      recommendationStatus: 0,
      recommendedBy: 0,
      recommendedId: 0,
      recommendedToId: 0,
      typeOfRecommended: 0);

  factory Recommendations.fromJson(Map<String, dynamic> json) {
    return Recommendations(
      enabledFlag: json['enabledFlag'] ?? 'Y',
      recommendationId: json['recommendationId'] ?? 0,
      recommendationStatus: json['recommendationStatus'] ?? 0,
      recommendedBy: json['recommendedBy'] ?? 0,
      recommendedId: json['recommendedId'] ?? 0,
      recommendedToId: json['recommendedToId'] ?? 0,
      typeOfRecommended: json['typeOfRecommended'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabledFlag': enabledFlag,
      'recommendationId': recommendationId,
      'recommendationStatus': recommendationStatus,
      'recommendedBy': recommendedBy,
      'recommendedId': recommendedId,
      'recommendedToId': recommendedToId,
      'typeOfRecommended': typeOfRecommended
    };
  }

  Recommendations copyWith({
    String? enabledFlag,
    int? recommendationId,
    int? recommendationStatus,
    int? recommendedBy,
    int? recommendedId,
    int? recommendedToId,
    int? typeOfRecommended,
  }) {
    return Recommendations(
        recommendedToId: recommendedToId ?? this.recommendedToId,
        recommendedId: recommendedId ?? this.recommendedId,
        recommendationId: recommendationId ?? this.recommendationId,
        enabledFlag: enabledFlag ?? this.enabledFlag,
        recommendationStatus: recommendationStatus ?? this.recommendationStatus,
        recommendedBy: recommendedBy ?? this.recommendedBy,
        typeOfRecommended: typeOfRecommended ?? this.typeOfRecommended);
  }

  @override
  List<Object?> get props => [
        enabledFlag,
        recommendationId,
        recommendationStatus,
        recommendedBy,
        recommendedId,
        recommendedToId,
        typeOfRecommended,
      ];
}
