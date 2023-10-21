part of 'category_lm_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  inSelectCategory,
  nullCategory,
  tournamentloading,
  tournamentloaded,
  infoLoading,
  lookupsLoaded,
  successfullyCreated,
  updatedSuccessful,
  succes,
  loaded,
  error,
}

class CategoryLmState extends Equatable {
  final List<Category> categoryList;
  final List<LookUpValue> lookupValueList;
  final List<Tournament> tournamentList;
  final LookUpValue selectedLookupValue;
  final List<ScoringTournamentDTO> scoringTournamentDTO;
  final List<GoalsTournamentDTO> goalsTournament;
  final int categoryId;
  final Category categoryInfo;
  final Tournament tournamentInfo;
  final ScreenStatus screenStatus;
  final String? errorMessage;
  final CategoryName categoryName;
  final Comment comment;
  final MaxAge maxAge;
  final MinAge minAge;
  final RedForPunishment redForPunishment;
  final YellowForPunishment yellowForPunishment;
  final bool validAge;
  final FormzStatus status;
  final bool allFormIsValid;

  const CategoryLmState({
    this.categoryList = const [],
    this.lookupValueList = const [],
    this.tournamentList = const [],
    this.selectedLookupValue = LookUpValue.empty,
    this.scoringTournamentDTO = const [],
    this.goalsTournament = const [],
    this.categoryId = 0,
    this.categoryInfo = Category.empty,
    this.tournamentInfo = Tournament.empty,
    this.screenStatus = ScreenStatus.initial,
    this.errorMessage,
    this.categoryName = const CategoryName.pure(),
    this.comment = const Comment.pure(),
    this.maxAge = const MaxAge.pure(),
    this.minAge = const MinAge.pure(),
    this.redForPunishment = const RedForPunishment.pure(),
    this.yellowForPunishment = const YellowForPunishment.pure(),
    this.validAge = false,
    this.status = FormzStatus.pure,
    this.allFormIsValid = false,
  });

  CategoryLmState copyWith({
    List<Category>? categoryList,
    List<LookUpValue>? lookupValueList,
    List<Tournament>? tournamentList,
    LookUpValue? selectedLookupValue,
    List<ScoringTournamentDTO>? scoringTournamentDTO,
    List<GoalsTournamentDTO>? goalsTournament,
    int? categoryId,
    Category? categoryInfo,
    Tournament? tournamentInfo,
    ScreenStatus? screenStatus,
    String? errorMessage,
    CategoryName? categoryName,
    Comment? comment,
    MaxAge? maxAge,
    MinAge? minAge,
    RedForPunishment? redForPunishment,
    YellowForPunishment? yellowForPunishment,
    bool? validAge,
    FormzStatus? status,
    bool? allFormIsValid,
  }) {
    return CategoryLmState(
      tournamentList: tournamentList ?? this.tournamentList,
      categoryList: categoryList ?? this.categoryList,
      lookupValueList: lookupValueList ?? this.lookupValueList,
      selectedLookupValue: selectedLookupValue ?? this.selectedLookupValue,
      scoringTournamentDTO: scoringTournamentDTO ?? this.scoringTournamentDTO,
      goalsTournament: goalsTournament ?? this.goalsTournament,
      categoryId: categoryId ?? this.categoryId,
      categoryInfo: categoryInfo ?? this.categoryInfo,
      tournamentInfo: tournamentInfo ?? this.tournamentInfo,
      screenStatus: screenStatus ?? this.screenStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      categoryName: categoryName ?? this.categoryName,
      comment: comment ?? this.comment,
      maxAge: maxAge ?? this.maxAge,
      minAge: minAge ?? this.minAge,
      redForPunishment: redForPunishment ?? this.redForPunishment,
      yellowForPunishment: yellowForPunishment ?? this.yellowForPunishment,
      validAge: validAge ?? this.validAge,
      status: status ?? this.status,
      allFormIsValid: allFormIsValid ?? this.allFormIsValid,
    );
  }

  @override
  List<Object?> get props => [
        categoryList,
        lookupValueList,
        selectedLookupValue,
        scoringTournamentDTO,
        goalsTournament,
        categoryInfo,
        screenStatus,
        categoryName,
        comment,
        maxAge,
        minAge,
        redForPunishment,
        yellowForPunishment,
        validAge,
        status,
        allFormIsValid,
      ];
}
