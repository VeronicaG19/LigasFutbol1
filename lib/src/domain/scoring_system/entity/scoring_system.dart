import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scoring_system.g.dart';

@JsonSerializable()
class ScoringSystem extends Equatable {
  final int scoringSystemId;
  final int? pointsPerWin;
  final int? pointPerTie;
  final int? pointPerLoss;
  final int? pointsPerWinShootOut;
  final int? pointPerLossShootOut;

  const ScoringSystem({
    required this.scoringSystemId,
    this.pointsPerWin,
    this.pointPerTie,
    this.pointPerLoss,
    this.pointsPerWinShootOut,
    this.pointPerLossShootOut,
  });

  static const empty = ScoringSystem(scoringSystemId: 0);
  
  /// Connect the generated [_$DocumentFromJson] function to the `fromJson`
  /// factory.
  factory ScoringSystem.fromJson(Map<String, dynamic> json) =>
      _$ScoringSystemFromJson(json);

  /// Connect the generated [_$ScoringSystemToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ScoringSystemToJson(this);

  ScoringSystem copyWith({
    int? scoringSystemId,
    int? pointsPerWin,
    int? pointPerTie,
    int? pointPerLoss,
    int? pointsPerWinShootOut,
    int? pointPerLossShootOut,
  }) {
    return ScoringSystem(
      scoringSystemId: scoringSystemId ?? this.scoringSystemId,
      pointsPerWin: pointsPerWin ?? this.pointsPerWin,
      pointPerTie: pointPerTie ?? this.pointPerTie,
      pointPerLoss: pointPerLoss ?? this.pointPerLoss,
      pointsPerWinShootOut: pointsPerWinShootOut ?? this.pointsPerWinShootOut,
      pointPerLossShootOut: pointPerLossShootOut ?? this.pointPerLossShootOut,
    );
  }

  @override
  List<Object?> get props => [
        scoringSystemId,
        pointsPerWin,
        pointPerTie,
        pointPerLoss,
        pointsPerWinShootOut,
        pointPerLossShootOut,
      ];
}
