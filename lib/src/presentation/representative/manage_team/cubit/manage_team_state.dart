part of 'manage_team_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  savingInformation,
  savedInformation,
  loadingUniforms,
  uniformsLoaded,
  uniformSaved,
  error,
}

class ManageTeamState extends Equatable {
  final Team teamInfo;
  final CreateTeamDTO saveTeamInfo;
  final String? teamlogoImageSelected;
  final XFile? showTeamLogo;
  final List<UniformDto> uniformsList;
  final UniformDto uniformDto;
  final String? uniformLocalImageSelected;
  final String? uniformVisitImageSelected;
  final XFile? showUniformL;
  final XFile? showUniformV;
  final bool? imageIsLarge;
  final ScreenStatus screenStatus;
  final String? errorMessage;

  const ManageTeamState({
    this.teamInfo = Team.empty,
    this.saveTeamInfo = CreateTeamDTO.empty,
    this.teamlogoImageSelected = '',
    this.showTeamLogo,
    this.uniformsList = const [],
    this.uniformDto = UniformDto.empty,
    this.uniformLocalImageSelected = '',
    this.uniformVisitImageSelected = '',
    this.showUniformL,
    this.showUniformV,
    this.imageIsLarge = false,
    this.screenStatus = ScreenStatus.initial,
    this.errorMessage,
  });

  ManageTeamState copyWith({
    Team? teamInfo,
    CreateTeamDTO? saveTeamInfo,
    String? teamlogoImageSelected,
    XFile? showTeamLogo,
    List<UniformDto>? uniformsList,
    UniformDto? uniformDto,
    String? uniformLocalImageSelected,
    String? uniformVisitImageSelected,
    XFile? showUniformL,
    XFile? showUniformV,
    bool? imageIsLarge,
    ScreenStatus? screenStatus,
    String? errorMessage,
  }) {
    return ManageTeamState(
      teamInfo: teamInfo ?? this.teamInfo,
      saveTeamInfo: saveTeamInfo ?? this.saveTeamInfo,
      teamlogoImageSelected:
          teamlogoImageSelected ?? this.teamlogoImageSelected,
      showTeamLogo: showTeamLogo ?? this.showTeamLogo,
      uniformsList: uniformsList ?? this.uniformsList,
      uniformDto: uniformDto ?? this.uniformDto,
      uniformLocalImageSelected:
          uniformLocalImageSelected ?? this.uniformLocalImageSelected,
      uniformVisitImageSelected:
          uniformVisitImageSelected ?? this.uniformVisitImageSelected,
      showUniformL: showUniformL ?? this.showUniformL,
      showUniformV: showUniformV ?? this.showUniformV,
      imageIsLarge: imageIsLarge ?? this.imageIsLarge,
      screenStatus: screenStatus ?? this.screenStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        teamInfo,
        saveTeamInfo,
        teamlogoImageSelected,
        showTeamLogo,
        uniformsList,
        uniformDto,
        uniformLocalImageSelected,
        uniformVisitImageSelected,
        showUniformL,
        showUniformV,
        imageIsLarge,
        screenStatus
      ];
}
