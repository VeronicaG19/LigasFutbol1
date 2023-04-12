import 'package:equatable/equatable.dart';

class PlayerStatics extends Equatable {
  final int blueCards;
  final int categoryId;
  final int fouls;
  final int goals;
  final String playerName;
  final int playerId;
  final int redCards;
  final int yellowCart;

  const PlayerStatics({
    required this.blueCards,
    required this.categoryId,
    required this.fouls,
    required this.goals,
    required this.playerName,
    required this.playerId,
    required this.redCards,
    required this.yellowCart,
  });

  Map<String, dynamic> toJson() {
    return {
      'blueCards': blueCards,
      'categoryId': categoryId,
      'fouls': fouls,
      'goals': goals,
      'playerName': playerName,
      'playerId': playerId,
      'redCards': redCards,
      'yellowCart': yellowCart,
    };
  }

  factory PlayerStatics.fromJson(Map<String, dynamic> json) {
    return PlayerStatics(
      blueCards: json['blueCards'] ?? 0,
      categoryId: json['categoryId'] ?? 0,
      fouls: json['fouls'] ?? 0,
      goals: json['goals'] ?? 0,
      playerName: json['namePlayer'] ?? '',
      playerId: json['playerId'] ?? 0,
      redCards: json['redCards'] ?? 0,
      yellowCart: json['yellowCart'] ?? 0,
    );
  }

  PlayerStatics copyWith({
    int? blueCards,
    int? categoryId,
    int? fouls,
    int? goals,
    String? playerName,
    int? playerId,
    int? redCards,
    int? yellowCart,
  }) {
    return PlayerStatics(
      blueCards: blueCards ?? this.blueCards,
      categoryId: categoryId ?? this.categoryId,
      fouls: fouls ?? this.fouls,
      goals: goals ?? this.goals,
      playerName: playerName ?? this.playerName,
      playerId: playerId ?? this.playerId,
      redCards: redCards ?? this.redCards,
      yellowCart: yellowCart ?? this.yellowCart,
    );
  }

  @override
  List<Object> get props => [
        blueCards,
        categoryId,
        fouls,
        goals,
        playerName,
        playerId,
        redCards,
        yellowCart,
      ];
}
