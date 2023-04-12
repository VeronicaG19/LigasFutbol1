import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config_league_interface_dto.g.dart';

@JsonSerializable()
class ConfigLeagueInterfaceDTO extends Equatable {
  final String? matchFinal;
  final String? ronda;
  final String? roundTrip;
  final String? tieBreakType;

  const ConfigLeagueInterfaceDTO({
    this.matchFinal,
    this.ronda,
    this.roundTrip,
    this.tieBreakType,
  });

  factory ConfigLeagueInterfaceDTO.fromJson(Map<String, dynamic> json) =>
      _$ConfigLeagueInterfaceDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigLeagueInterfaceDTOToJson(this);

  static const empty = ConfigLeagueInterfaceDTO(
    matchFinal: '',
    ronda: '',
    roundTrip: '',
    tieBreakType: '',
  );

  ConfigLeagueInterfaceDTO copyWith({
    String? matchFinal,
    String? ronda,
    String? roundTrip,
    String? tieBreakType,
  }) {
    return ConfigLeagueInterfaceDTO(
      matchFinal: matchFinal ?? this.matchFinal,
      ronda: ronda ?? this.ronda,
      roundTrip: roundTrip ?? this.roundTrip,
      tieBreakType: tieBreakType ?? this.tieBreakType,
    );
  }

  @override
  List<Object?> get props => [
        matchFinal,
        ronda,
        roundTrip,
        tieBreakType,
      ];
}
