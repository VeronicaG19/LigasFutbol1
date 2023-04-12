import 'package:equatable/equatable.dart';

class CardTeamOBJ extends Equatable {
  final String? teamName;
  final String? imageTeam;
  final bool? isSelected;
  final int? teamId;
  const CardTeamOBJ({
    this.teamName,
    this.imageTeam,
    this.isSelected,
    this.teamId
  });

  

  CardTeamOBJ copyWith({
    String? teamName,
    String? imageTeam,
    bool? isSelected,
    int? teamId
  }) {
    return CardTeamOBJ(
      teamName: teamName ?? this.teamName,
      imageTeam: imageTeam ?? this.imageTeam,
      isSelected: isSelected ?? this.isSelected,
      teamId: teamId ?? this.teamId
    );
  }



  @override
  List<Object?> get props => [teamName, imageTeam, isSelected, teamId];
}
