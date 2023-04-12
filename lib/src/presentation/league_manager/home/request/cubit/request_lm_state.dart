part of 'request_lm_cubit.dart';

class RequestLmState extends Equatable {
  final String? errorMessage;
  final BasicCubitScreenState screenStatus;
  final LeagueDescription leagueDescription;
  final List<League> leagues;
  final LeagueName leagueName;
  final FormzStatus formzStatus;
  final ResponseRequestDTO responseRequestDTO;
  final League leageSlct;
  final List<Category> categoriesList;
  final Category catSelect;
  final int requestCount;

  const RequestLmState(
      {this.leagueDescription = const LeagueDescription.pure(),
      this.leagueName = const LeagueName.pure(),
      this.errorMessage,
      this.formzStatus = FormzStatus.pure,
      this.leagues = const [],
      this.screenStatus = BasicCubitScreenState.initial,
      this.responseRequestDTO = ResponseRequestDTO.empty,
      this.leageSlct = League.empty,
      this.categoriesList = const [],
      this.catSelect = Category.empty,
      this.requestCount = 0});

  RequestLmState copyWith(
      {String? errorMessage,
      BasicCubitScreenState? screenStatus,
      LeagueDescription? leagueDescription,
      LeagueName? leagueName,
      FormzStatus? formzStatus,
      ResponseRequestDTO? responseRequestDTO,
      List<League>? leagues,
      League? leageSlct,
      List<Category>? categoriesList,
      Category? catSelect,
      int? requestCount}) {
    return RequestLmState(
        errorMessage: errorMessage ?? this.errorMessage,
        screenStatus: screenStatus ?? this.screenStatus,
        leagueDescription: leagueDescription ?? this.leagueDescription,
        leagueName: leagueName ?? this.leagueName,
        formzStatus: formzStatus ?? this.formzStatus,
        responseRequestDTO: responseRequestDTO ?? this.responseRequestDTO,
        leagues: leagues ?? this.leagues,
        leageSlct: leageSlct ?? this.leageSlct,
        categoriesList: categoriesList ?? this.categoriesList,
        catSelect: catSelect ?? this.catSelect,
        requestCount: requestCount ?? this.requestCount);
  }

  @override
  List<Object> get props => [
        screenStatus,
        leagueName,
        leagueDescription,
        formzStatus,
        leagues,
        leageSlct,
        categoriesList,
        catSelect,
        requestCount
      ];
}
