part of 'create_new_player_cubit.dart';

enum ScreenStatus { initial, loading, loaded, error, }
enum VerificationType { unknown, email, phone }

class CreateNewPlayerState extends Equatable{
  final User infoUser;
  final Player infoPlayer;
  //final int playerId;
  final Team teamInfo;
  final RefereeName playerName;
  final RefereeLastName playerLastName;
  final FormzStatus status;
  final VerificationSender verificationSender;
  final VerificationType verificationType;
  final BasicCubitScreenState screenStatus;
  final List<TeamPlayer> teamPlayer;
  final String? errorMessage;

  const CreateNewPlayerState({
    this.infoUser = User.empty,
    this.infoPlayer = Player.empty,
    this.teamInfo = Team.empty,
    this.playerName = const RefereeName.pure(),
    this.playerLastName = const RefereeLastName.pure(),
    this.status = FormzStatus.pure,
    this.verificationSender = const VerificationSender.pure(),
    this.verificationType = VerificationType.unknown,
    this.screenStatus = BasicCubitScreenState.initial,
    this.teamPlayer = const [],
    this.errorMessage,
  });

  String? getErrorCode() {
    try {
      final response = jsonDecode(errorMessage ?? '');
      return response['code'].toString();
    } catch (_) {
      return errorMessage;
    }
  }

  String getResetTime() {
    try {
      final response = jsonDecode(errorMessage ?? '');
      return response['time'].toString();
    } catch (_) {
      return errorMessage ?? '';
    }
  }
  VerificationType getVerificationType() {
    final phoneRegExp = RegExp(r'^[0-9]{10}');
    if (phoneRegExp.hasMatch(verificationSender.value) &&
        verificationSender.value.length == 10) {
      return VerificationType.phone;
    }
    return VerificationType.email;
  }

  CreateNewPlayerState copyWith({
    User? infoUser,
    Player? infoPlayer,
    Team? teamInfo,
    RefereeName? playerName,
    RefereeLastName? playerLastName,
    FormzStatus? status,
    VerificationSender? verificationSender,
    VerificationType? verificationType,
    BasicCubitScreenState? screenStatus,
    List<TeamPlayer>? teamPlayer,
    String? errorMessage,
  }) {
    return CreateNewPlayerState(
      infoUser: infoUser ?? this.infoUser,
      infoPlayer: infoPlayer ?? this.infoPlayer,
      teamInfo: teamInfo ?? this.teamInfo,
      playerName: playerName ?? this.playerName,
      playerLastName: playerLastName ?? this.playerLastName,
      status: status ?? this.status,
      verificationSender: verificationSender ?? this.verificationSender,
      verificationType: verificationType ?? this.verificationType,
      screenStatus: screenStatus ?? this.screenStatus,
      teamPlayer: teamPlayer ?? this.teamPlayer,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }


  @override
  List<Object?> get props => [
    infoUser,
    infoPlayer,
    teamInfo,
    playerName,
    playerLastName,
    status,
    verificationSender,
    verificationType,
    screenStatus,
    teamPlayer,
  ];

}