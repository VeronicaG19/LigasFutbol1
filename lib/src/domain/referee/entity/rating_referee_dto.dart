import 'package:equatable/equatable.dart';

class RatingRefereeDTO extends Equatable {
  final String fullName;
  final int generalQualify;
  final int healthFactor;
  final int impartiality;
  final int partyId;
  final int punctuality;
  final int refereeId;
  final int tactical;
  final int technicalKnw;

  const RatingRefereeDTO({
    required this.fullName,
    required this.generalQualify,
    required this.healthFactor,
    required this.impartiality,
    required this.partyId,
    required this.punctuality,
    required this.refereeId,
    required this.tactical,
    required this.technicalKnw,
  });

  static const empty = RatingRefereeDTO(
      fullName: '',
      generalQualify: 0,
      healthFactor: 0,
      impartiality: 0,
      partyId: 0,
      punctuality: 0,
      refereeId: 0,
      tactical: 0,
      technicalKnw: 0);

  bool get isEmpty => this == RatingRefereeDTO.empty;

  bool get isNotEmpty => this != RatingRefereeDTO.empty;

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'generalqualyfi': generalQualify,
      'healthFactor': healthFactor,
      'impartiality': impartiality,
      'partyId': partyId,
      'puntuality': punctuality,
      'refereeId': refereeId,
      'tactical': tactical,
      'technicalKnw': technicalKnw,
    };
  }

  factory RatingRefereeDTO.fromJson(Map<String, dynamic> json) {
    return RatingRefereeDTO(
      fullName: json['fullName'] ?? '',
      generalQualify: json['generalqualyfi'] ?? 0,
      healthFactor: json['healthFactor'] ?? 0,
      impartiality: json['impartiality'] ?? 0,
      partyId: json['partyId'] ?? 0,
      punctuality: json['puntuality'] ?? 0,
      refereeId: json['refereeId'] ?? 0,
      tactical: json['tactical'] ?? 0,
      technicalKnw: json['technicalKnw'] ?? 0,
    );
  }

  RatingRefereeDTO copyWith({
    String? fullName,
    int? generalQualify,
    int? healthFactor,
    int? impartiality,
    int? partyId,
    int? punctuality,
    int? refereeId,
    int? tactical,
    int? technicalKnw,
  }) {
    return RatingRefereeDTO(
      fullName: fullName ?? this.fullName,
      generalQualify: generalQualify ?? this.generalQualify,
      healthFactor: healthFactor ?? this.healthFactor,
      impartiality: impartiality ?? this.impartiality,
      partyId: partyId ?? this.partyId,
      punctuality: punctuality ?? this.punctuality,
      refereeId: refereeId ?? this.refereeId,
      tactical: tactical ?? this.tactical,
      technicalKnw: technicalKnw ?? this.technicalKnw,
    );
  }

  @override
  List<Object> get props => [
        fullName,
        generalQualify,
        healthFactor,
        impartiality,
        partyId,
        punctuality,
        refereeId,
        tactical,
        technicalKnw,
      ];
}
