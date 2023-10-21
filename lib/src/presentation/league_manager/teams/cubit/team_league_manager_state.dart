part of 'team_league_manager_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  createdSucces,
  updateSucces,
  deleteSucces,
  error,
}

enum VerificationType { unknown, email, phone }

class TeamLeagueManagerState extends Equatable {
  // final List<Team> teamList;
  // final int totalElements;
  // final int totalPages;
  // final int currentPage;
  final CommonPageableResponse<TeamLeagueManagerDTO> teamPageable;
  final List<Category> categoryList;
  final Category categorySelected;
  final Team teamInfo;
  final Team teamInfo2;
  final ScreenStatus screenStatus;
  final String? errorMessage;
  final FormzStatus status;
  final TeamName teamName;
  final RefereeName refereeName;
  final RefereeLastName refereeLastName;
  final String photoTeamSelected;
  final String uniformLocalImageSelected;
  final String? uniformVisitImageSelected;
  final XFile? showImage1;
  final XFile? showImage2;
  final XFile? showImage3;
  final VerificationSender verificationSender;
  final VerificationType verificationType;
  final User userModel;
  final Person infoManager;
  final CategoryId categoryId;
  final String? uniformL;
  final String? uniformV;
  final bool? imageIsLarge;

  const TeamLeagueManagerState({
    this.teamPageable = const CommonPageableResponse<TeamLeagueManagerDTO>(),
    this.categoryList = const [],
    this.categorySelected = Category.empty,
    this.teamInfo = Team.empty,
    this.teamInfo2 = Team.empty,
    this.teamName = const TeamName.pure(),
    this.refereeName = const RefereeName.pure(),
    this.refereeLastName = const RefereeLastName.pure(),
    this.verificationSender = const VerificationSender.pure(),
    this.verificationType = VerificationType.unknown,
    this.screenStatus = ScreenStatus.initial,
    this.errorMessage,
    this.photoTeamSelected = '',
    this.uniformLocalImageSelected = '',
    this.uniformVisitImageSelected = '',
    this.showImage1,
    this.showImage2,
    this.showImage3,
    this.userModel = User.empty,
    this.status = FormzStatus.pure,
    this.infoManager = Person.empty,
    this.categoryId = const CategoryId.pure(),
    this.uniformL = '',
    this.uniformV = '',
    this.imageIsLarge = false,
  });

  @override
  List<Object?> get props => [
        teamPageable,
        categoryList,
        categorySelected,
        uniformLocalImageSelected,
        uniformVisitImageSelected,
        teamInfo,
        teamInfo2,
        screenStatus,
        status,
        teamName,
        showImage1,
        showImage2,
        showImage3,
        refereeName,
        refereeLastName,
        verificationSender,
        photoTeamSelected,
        verificationType,
        userModel,
        infoManager,
        categoryId,
        uniformL,
        uniformV,
        imageIsLarge,
      ];

  VerificationType getVerificationType() {
    final phoneRegExp = RegExp(r'^[0-9]{10}');
    if (phoneRegExp.hasMatch(verificationSender.value) &&
        verificationSender.value.length == 10) {
      return VerificationType.phone;
    }
    return VerificationType.email;
  }

  TeamLeagueManagerState copyWith({
    CommonPageableResponse<TeamLeagueManagerDTO>? teamPageable,
    List<Category>? categoryList,
    Category? categorySelected,
    Team? teamInfo,
    Team? teamInfo2,
    ScreenStatus? screenStatus,
    String? errorMessage,
    FormzStatus? status,
    TeamName? teamName,
    RefereeName? refereeName,
    RefereeLastName? refereeLastName,
    String? photoTeamSelected,
    String? uniformLocalImageSelected,
    String? uniformVisitImageSelected,
    VerificationSender? verificationSender,
    VerificationType? verificationType,
    User? userModel,
    XFile? showImage1,
    XFile? showImage2,
    XFile? showImage3,
    Person? infoManager,
    CategoryId? categoryId,
    String? uniformL,
    String? uniformV,
    bool? imageIsLarge,
  }) {
    return TeamLeagueManagerState(
      teamPageable: teamPageable ?? this.teamPageable,
      categoryList: categoryList ?? this.categoryList,
      categorySelected: categorySelected ?? this.categorySelected,
      teamInfo: teamInfo ?? this.teamInfo,
      teamInfo2: teamInfo2 ?? this.teamInfo2,
      screenStatus: screenStatus ?? this.screenStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      teamName: teamName ?? this.teamName,
      refereeName: refereeName ?? this.refereeName,
      refereeLastName: refereeLastName ?? this.refereeLastName,
      photoTeamSelected: photoTeamSelected ?? this.photoTeamSelected,
      uniformLocalImageSelected:
          uniformLocalImageSelected ?? this.uniformLocalImageSelected,
      uniformVisitImageSelected:
          uniformVisitImageSelected ?? this.uniformVisitImageSelected,
      verificationSender: verificationSender ?? this.verificationSender,
      verificationType: verificationType ?? this.verificationType,
      showImage1: showImage1 ?? this.showImage1,
      showImage2: showImage2 ?? this.showImage2,
      showImage3: showImage3 ?? this.showImage3,
      userModel: userModel ?? this.userModel,
      infoManager: infoManager ?? this.infoManager,
      categoryId: categoryId ?? this.categoryId,
      uniformL: uniformL ?? this.uniformL,
      uniformV: uniformV ?? this.uniformV,
      imageIsLarge: imageIsLarge ?? this.imageIsLarge,
    );
  }
}
