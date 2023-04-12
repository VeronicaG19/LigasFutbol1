import 'package:equatable/equatable.dart';

class RefereeDetailDTO extends Equatable {
  final String refereeAddress;
  final int refereeId;
  final String refereeLatitude;
  final String refereeName;
  final String refereePhoto;
  final String refereeLength;

  const RefereeDetailDTO({
    required this.refereeAddress,
    required this.refereeId,
    required this.refereeLatitude,
    required this.refereeName,
    required this.refereePhoto,
    required this.refereeLength,
  });

  static const empty = RefereeDetailDTO(
      refereeAddress: '',
      refereeId: 0,
      refereeLatitude: '',
      refereeName: '',
      refereePhoto: '',
      refereeLength: '');

  bool get isEmpty => this == RefereeDetailDTO.empty;

  bool get isNotEmpty => this != RefereeDetailDTO.empty;

  Map<String, dynamic> toJson() {
    return {
      'refereeAddress': refereeAddress,
      'refereeId': refereeId,
      'refereeLatitude': refereeLatitude,
      'refereeName': refereeName,
      'refereePhoto': refereePhoto,
      'refereelength': refereeLength,
    };
  }

  factory RefereeDetailDTO.fromJson(Map<String, dynamic> json) {
    return RefereeDetailDTO(
      refereeAddress: json['refereeAddress'] ?? '',
      refereeId: json['refereeId'] ?? 0,
      refereeLatitude: json['refereeLatitude'] ?? '',
      refereeName: json['refereeName'] ?? '',
      refereePhoto: json['refereePhoto'] ?? '',
      refereeLength: json['refereelength'] ?? '',
    );
  }

  RefereeDetailDTO copyWith({
    String? refereeAddress,
    int? refereeId,
    String? refereeLatitude,
    String? refereeName,
    String? refereePhoto,
    String? refereeLength,
  }) {
    return RefereeDetailDTO(
      refereeAddress: refereeAddress ?? this.refereeAddress,
      refereeId: refereeId ?? this.refereeId,
      refereeLatitude: refereeLatitude ?? this.refereeLatitude,
      refereeName: refereeName ?? this.refereeName,
      refereePhoto: refereePhoto ?? this.refereePhoto,
      refereeLength: refereeLength ?? this.refereeLength,
    );
  }

  @override
  List<Object> get props => [
        refereeAddress,
        refereeId,
        refereeLatitude,
        refereeName,
        refereePhoto,
        refereeLength,
      ];
}
