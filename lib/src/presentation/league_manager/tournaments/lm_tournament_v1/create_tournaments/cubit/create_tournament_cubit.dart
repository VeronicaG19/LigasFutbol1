import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:ligas_futbol_flutter/src/domain/category/category.dart';
import 'package:ligas_futbol_flutter/src/domain/leagues/leagues.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/service/i_tournament_service.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/validator/breakes_duration.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/validator/red_card_fine.dart';

import '../../../../../../domain/lookupvalue/entity/lookupvalue.dart';
import '../../../../../../domain/lookupvalue/service/i_lookupvalue_service.dart';
import '../../../../../../domain/scoring_system/entity/scoring_system.dart';
import '../../../../../../domain/scoring_system/validator/poin_per_loss.dart';
import '../../../../../../domain/scoring_system/validator/point_per_tie.dart';
import '../../../../../../domain/scoring_system/validator/point_per_win.dart';
import '../../../../../../domain/scoring_system/validator/points_per_loss_shootOut.dart';
import '../../../../../../domain/scoring_system/validator/points_per_win_shootOut.dart';
import '../../../../../../domain/tournament/validator/breaks_numbers.dart';
import '../../../../../../domain/tournament/validator/duration_by_time.dart';
import '../../../../../../domain/tournament/validator/games_changes.dart';
import '../../../../../../domain/tournament/validator/games_times.dart';
import '../../../../../../domain/tournament/validator/inscription_date.dart';
import '../../../../../../domain/tournament/validator/max_player.dart';
import '../../../../../../domain/tournament/validator/max_teams.dart';
import '../../../../../../domain/tournament/validator/temporary_reprimands.dart';
import '../../../../../../domain/tournament/validator/tournament_name.dart';
import '../../../../../../domain/tournament/validator/yellow_card_fine.dart';
import '../category_select.dart';

part 'create_tournament_state.dart';

@Injectable()
class CreateTournamentCubit extends Cubit<CreateTournamentState> {
  CreateTournamentCubit(
      this._service, this._lookUpValueService, this._categoryService)
      : super(const CreateTournamentState());

  final ITournamentService _service;
  final ILookUpValueService _lookUpValueService;
  final ICategoryService _categoryService;

  Future<void> getTypeTournaments(int leagueId) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    getCategories(leagueId);
    final response =
        await _lookUpValueService.getLookUpValueByTypeLM("TYPE_OF_TOURNAMENT");
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded,
          lookUpValues: r,
          typeTournament: r[0]));
      getTypeFutbol();

      emit(state.copyWith(
          createTournament:
              state.createTournament.copyWith(unlimitedChanges: 'Y')));
    });
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(DateTime.now());
    onInscriptionDateChange(formatted);
    validateCategoriesSelected();
  }

  Future<void> getTypeFutbol() async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response =
        await _lookUpValueService.getLookUpValueByTypeLM("FOOTBALL_TYPE");
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded,
          typeFotbolValues: r,
          typeFotbol: r[0]));
    });
  }

  Future<void> getCategories(int leagueId) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _categoryService.getCategoriesByLeagueId(leagueId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      print(r);
      List<CategorySelect> categoryselect = [];
      r.forEach((element) {
        CategorySelect cat =
            new CategorySelect(category: element, isSelect: false);
        categoryselect.add(cat);
      });
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded,
          categoriesList: r,
          categorySelect: categoryselect
          // categorySelect: r,
          ));
    });
  }

  Future<void> onchangePrivacityChange(bool privacity) async {
    emit(state.copyWith(
        createTournament: state.createTournament
            .copyWith(tournamentPrivacy: (privacity) ? 'Y' : 'N')));
  }

  Future<void> onchangeBeginChange(bool beginstatus) async {
    emit(state.copyWith(
        createTournament: state.createTournament
            .copyWith(statusBegin: (beginstatus) ? 'Y' : 'N')));
  }

  void onTournamentNameChange(String value) {
    final tournamentName = TournamentName.dirty(value);
    emit(state.copyWith(
        tournamentName: tournamentName,
        formzStatus: Formz.validate([tournamentName, state.tournamentName])));
  }

  void onInscriptionDateChange(String value) {
    emit(state.copyWith(inscriptionDate: InscriptionDate.dirty(value)));
  }

  void onTournamentTypeChange(LookUpValue value) {
    emit(state.copyWith(
        typeTournament: value,
        createTournament: state.createTournament
            .copyWith(typeTournament: value.lookupValue.toString())));
  }

  void onFutbolTypeChange(LookUpValue value) {
    emit(state.copyWith(
        typeFotbol: value,
        createTournament: state.createTournament
            .copyWith(typeOfGame: value.lookupValue.toString())));
    //getValuesFutbolType();
  }

  void getValuesFutbolType() {
    if (state.typeFotbol.lookupName == 'Soccer') {
      emit(state.copyWith(
        gamesTimes: const GamesTimes.dirty("2"),
      ));
    } else if (state.typeFotbol.lookupName == 'Futbol Rapido') {
      emit(state.copyWith(
        gamesTimes: const GamesTimes.dirty("4"),
      ));
    } else {
      emit(state.copyWith(
        gamesTimes: const GamesTimes.dirty("0"),
      ));
    }
  }

  void onMaxTeamsChange(String value) {
    final maxTeams = MaxTeams.dirty(value);
    emit(state.copyWith(
      maxTeams: maxTeams,
    ));
  }

  void onMaxPlayerChange(String value) {
    final maxPlayer = MaxPlayer.dirty(value);
    emit(state.copyWith(
        maxPlayer: maxPlayer,
        formzStatus: Formz.validate([maxPlayer, state.maxPlayer])));
  }

  Future<void> onTemporaryReprimandsChange(bool value) async {
    print(value);
    emit(state.copyWith(
        createTournament: state.createTournament
            .copyWith(temporaryReprimands: (value) ? 'Y' : 'N')));
    print(state.createTournament.temporaryReprimands);
  }

  void onGamesTimesChange(String value) {
    final gamesTimes = GamesTimes.dirty(value);
    emit(state.copyWith(
      gamesTimes: gamesTimes,
      formzStatus: Formz.validate([
        gamesTimes,
        state.gamesTimes,
      ]),
    ));
  }

  void onDurationTimesChange(String value) {
    final durationByTime = DurationByTime.dirty(value);
    emit(state.copyWith(
        durationByTime: durationByTime,
        formzStatus: Formz.validate([durationByTime, state.durationByTime])));
  }

  void onBreakNumbersChange(String value) {
    final breakNumbers = BreakNumbers.dirty(value);
    emit(state.copyWith(
        breakNumbers: breakNumbers,
        formzStatus: Formz.validate([breakNumbers, state.breakNumbers])));
  }

  void onBreakDurationChange(String value) {
    final breakDuration = BreakDuration.dirty(value);
    emit(state.copyWith(
        breakDuration: breakDuration,
        formzStatus: Formz.validate([breakDuration, state.breakDuration])));
  }

  void onYellowCardFineChange(String value) {
    final yellowCardFine = YellowCardFine.dirty(value);
    if (state.cardsflag) {
      emit(state.copyWith(
          yellowCardFine: yellowCardFine,
          formzStatus: Formz.validate([yellowCardFine, state.yellowCardFine])));
    } else {
      emit(state.copyWith(yellowCardFine: yellowCardFine));
    }
  }

  void onRedCardFineChange(String value) {
    final redCardFine = RedCardFine.dirty(value);
    if (state.cardsflag) {
      emit(state.copyWith(
          redCardFine: redCardFine,
          formzStatus: Formz.validate([redCardFine, state.redCardFine])));
    } else {
      emit(state.copyWith(
        redCardFine: redCardFine,
      ));
    }
  }

  void onGamesChangesChange(String value) {
    final gamesChanges = GamesChanges.dirty(value);
    if (state.createTournament.unlimitedChanges != "Y") {
      emit(state.copyWith(
          gamesChanges: gamesChanges,
          formzStatus: Formz.validate([gamesChanges, state.gamesChanges])));
    } else {
      emit(state.copyWith(gamesChanges: gamesChanges));
    }
  }

  void onPointPerTieChange(String value) {
    final pointPerTie = PointPerTie.dirty(value);
    emit(state.copyWith(
        pointPerTie: pointPerTie,
        formzStatus: Formz.validate([pointPerTie, state.pointPerTie])));
  }

  void onPointPerLossChange(String value) {
    final pointPerLoss = PointPerLoss.dirty(value);
    emit(state.copyWith(
        pointPerLoss: pointPerLoss,
        formzStatus: Formz.validate([pointPerLoss, state.pointPerLoss])));
  }

  void onPotinPerWinChange(String value) {
    final pointPerWin = PointPerWin.dirty(value);
    emit(state.copyWith(
        pointPerWin: pointPerWin,
        formzStatus: Formz.validate([pointPerWin, state.pointPerWin])));
  }

  void onPointsPerLossShootOutChange(String value) {
    final pointsPerLossShootOut = PointsPerLossShootOut.dirty(value);
    if (state.shooutOutFlag) {
      emit(state.copyWith(
          pointsPerLossShootOut: pointsPerLossShootOut,
          formzStatus: Formz.validate(
              [pointsPerLossShootOut, state.pointsPerLossShootOut])));
    } else {
      emit(state.copyWith(pointsPerLossShootOut: pointsPerLossShootOut));
    }
  }

  void onPointsPerWinShootOutChange(String value) {
    final pointsPerWinShootOut = PointsPerWinShootOut.dirty(value);
    if (state.shooutOutFlag) {
      emit(state.copyWith(
          pointsPerWinShootOut: pointsPerWinShootOut,
          formzStatus: Formz.validate(
              [pointsPerWinShootOut, state.pointsPerWinShootOut])));
    } else {
      emit(state.copyWith(
        pointsPerWinShootOut: pointsPerWinShootOut,
      ));
    }
  }

  Future<void> inCategoryChange(CategorySelect value1, bool select) async {
    final category = state.categorySelect;

    emit(state.copyWith(categorySelect: []));
    int index = category.indexOf(value1);
    category.remove(value1);

    value1 = value1.copyWith(isSelect: select);
    category.insert(index, value1);

    emit(state.copyWith(categorySelect: category));

    validateCategoriesSelected();
  }

  void validateCategoriesSelected() {
    print('>>> ------------------------------------------------------------');
    print('>>> validateCategoriesSelected');
    print('>>> ------------------------------------------------------------');
    print(
        '>>> categorySelect : ${state.categorySelect.any((e) => e.isSelect!)}');
    print('>>> ------------------------------------------------------------');
    emit(state.copyWith(
      flagCategorySelect: state.categorySelect.any((e) => e.isSelect!),
    ));
  }

  Future<void> onUnlimitedChangesChange(bool value) async {
    const gamesChanges = GamesChanges.dirty("6");
    if (value) {
      emit(state.copyWith(
        createTournament: state.createTournament.copyWith(
          unlimitedChanges: (value) ? 'Y' : 'N',
        ),
        gamesChanges: const GamesChanges.pure(),
      ));
    } else {
      emit(state.copyWith(
        createTournament: state.createTournament.copyWith(
          unlimitedChanges: (value) ? 'Y' : 'N',
        ),
        gamesChanges: gamesChanges,
      ));
    }
  }

  Future<void> onshooutOutFlagChange(bool value) async {
    const pointsPerWinShootOut = PointsPerWinShootOut.dirty('2');
    const pointsPerLossShootOut = PointsPerLossShootOut.dirty('1');
    const gamesTimes = GamesTimes.dirty('2');
    if (value) {
      emit(state.copyWith(
          shooutOutFlag: value,
          pointsPerWinShootOut: pointsPerWinShootOut,
          pointsPerLossShootOut: pointsPerLossShootOut,
          gamesTimes: gamesTimes));
    } else {
      emit(state.copyWith(
        shooutOutFlag: value,
        pointsPerWinShootOut: const PointsPerWinShootOut.pure(),
        pointsPerLossShootOut: const PointsPerLossShootOut.pure(),
      ));
    }
    //emit(state.copyWith(shooutOutFlag: value));
  }

  Future<void> oncardsFlagChange(bool value) async {
    const yellowCardFine = YellowCardFine.dirty("3");
    const redCardFine = RedCardFine.dirty("1");
    if (value) {
      emit(state.copyWith(
          cardsflag: value,
          yellowCardFine: yellowCardFine,
          redCardFine: redCardFine));
    } else {
      emit(state.copyWith(
        cardsflag: value,
        yellowCardFine: const YellowCardFine.pure(),
        redCardFine: const RedCardFine.pure(),
      ));
    }
  }

  Tournament validationNewTournament(
      {required League? league, required int? categoryId}) {
    ScoringSystem scoringSystem = ScoringSystem(
        pointPerLoss: int.tryParse(state.pointPerLoss.value),
        pointPerLossShootOut: int.tryParse(state.pointsPerLossShootOut.value),
        pointPerTie: int.tryParse(state.pointPerTie.value),
        pointsPerWin: int.tryParse(state.pointPerWin.value),
        pointsPerWinShootOut: int.tryParse(state.pointsPerWinShootOut.value),
        scoringSystemId: 0);

    Category categoryTournament =
        Category(categoryName: '', categoryId: categoryId);

    Tournament newTournament = Tournament(
      declain: "N",
      tournamentName: state.tournamentName.value,
      yellowCardFine: int.tryParse(state.yellowCardFine.value),
      redCardFine: int.tryParse(state.redCardFine.value),
      typeOfGame: state.typeFotbol.lookupValue.toString(),
      gameTimes: int.tryParse(state.gamesTimes.value),
      durationByTime: int.tryParse(state.durationByTime.value),
      gameChanges: int.tryParse(state.gamesChanges.value),
      unlimitedChanges: state.createTournament.unlimitedChanges,
      typeTournament: state.typeTournament.lookupValue.toString(),
      breaksNumber: int.tryParse(state.breakNumbers.value),
      breaksDuration: int.tryParse(state.breakDuration.value),
      maxPlayers: int.tryParse(state.maxPlayer.value),
      maxTeams: int.tryParse(state.maxTeams.value),
      tournamentPrivacy: state.createTournament.tournamentPrivacy ?? 'N',
      inscriptionDate: DateTime.parse(state.inscriptionDate.value),
      statusBegin: state.createTournament.statusBegin ?? 'N',
      temporaryReprimands: state.createTournament.temporaryReprimands,
      //daysMatches; : ,
      // dormForred : ,
      // typeExpulsion : ,
      // activateBlueCard : ,
      // sanctionTime : ,
      // blueCardsAllowed : ,*/
      categoryId: categoryTournament,
      leagueId: league,
      scoringSystemId: scoringSystem,
    );
    return newTournament;
  }

  Future<void> createTournament({required League? leagueId}) async {
    List<Tournament> lisTournament = [];

    bool cardPenaltiesValid = false;
    bool tiebreakerValid = false;
    bool unlimitedChangesValid = false;
    bool allFormIsValid;

    if (state.cardsflag) {
      emit(state.copyWith(
        yellowCardFine: YellowCardFine.dirty(state.yellowCardFine.value),
        redCardFine: RedCardFine.dirty(state.redCardFine.value),
      ));
    }

    if (state.shooutOutFlag) {
      emit(state.copyWith(
        pointsPerWinShootOut:
            PointsPerWinShootOut.dirty(state.pointsPerWinShootOut.value),
        pointsPerLossShootOut:
            PointsPerLossShootOut.dirty(state.pointsPerLossShootOut.value),
      ));
    }

    if (state.createTournament.unlimitedChanges == 'N') {
      emit(state.copyWith(
        gamesChanges: GamesChanges.dirty(state.gamesChanges.value),
      ));
    }

    emit(state.copyWith(
      tournamentName: TournamentName.dirty(state.tournamentName.value),
      inscriptionDate: InscriptionDate.dirty(state.inscriptionDate.value),
      maxTeams: MaxTeams.dirty(state.maxTeams.value),
      maxPlayer: MaxPlayer.dirty(state.maxPlayer.value),
      temporaryReprimands:
          TemporaryReprimands.dirty(state.temporaryReprimands.value),
      gamesTimes: GamesTimes.dirty(state.gamesTimes.value),
      durationByTime: DurationByTime.dirty(state.durationByTime.value),
      breakNumbers: BreakNumbers.dirty(state.breakNumbers.value),
      breakDuration: BreakDuration.dirty(state.breakDuration.value),
      pointPerLoss: PointPerLoss.dirty(state.pointPerLoss.value),
      pointPerTie: PointPerTie.dirty(state.pointPerTie.value),
      pointPerWin: PointPerWin.dirty(state.pointPerWin.value),
    ));

    if (state.tournamentName.valid == true &&
        state.inscriptionDate.valid == true &&
        state.maxTeams.valid == true &&
        state.maxPlayer.valid == true &&
        //state.temporaryReprimands.valid == true &&
        state.gamesTimes.valid == true &&
        state.durationByTime.valid == true &&
        state.breakNumbers.valid == true &&
        state.breakDuration.valid == true &&
        //state.pointPerLoss.valid == true &&
        state.pointPerTie.valid == true &&
        state.pointPerWin.valid == true) {
      if ((state.cardsflag &&
              (state.yellowCardFine.valid == true &&
                  state.redCardFine.valid == true)) ||
          (!state.cardsflag)) {
        cardPenaltiesValid = true;
      }

      if ((state.shooutOutFlag &&
              (state.pointsPerLossShootOut.valid == true &&
                  state.pointsPerWinShootOut.valid == true)) ||
          (!state.shooutOutFlag)) {
        tiebreakerValid = true;
      }

      if (((state.createTournament.unlimitedChanges == 'N') &&
              state.gamesChanges.valid == true) ||
          (state.createTournament.unlimitedChanges != 'N')) {
        unlimitedChangesValid = true;
      }

      print('cardPenaltiesValid is ${cardPenaltiesValid}');
      print('tiebreakerValid is ${tiebreakerValid}');
      print('unlimitedChangesValid is ${unlimitedChangesValid}');

      if (cardPenaltiesValid == true &&
          tiebreakerValid == true &&
          unlimitedChangesValid == true) {
        allFormIsValid = true;
      } else {
        allFormIsValid = false;
      }
    } else {
      allFormIsValid = false;
    }

    print('antes del emit ${allFormIsValid}');

    emit(state.copyWith(
      formzStatus: Formz.validate([
        TournamentName.dirty(state.tournamentName.value),
        InscriptionDate.dirty(state.inscriptionDate.value),
        MaxTeams.dirty(state.maxTeams.value),
        MaxPlayer.dirty(state.maxPlayer.value),
        TemporaryReprimands.dirty(state.temporaryReprimands.value),
        GamesTimes.dirty(state.gamesTimes.value),
        DurationByTime.dirty(state.durationByTime.value),
        BreakNumbers.dirty(state.breakNumbers.value),
        BreakDuration.dirty(state.breakDuration.value),
        YellowCardFine.dirty(state.yellowCardFine.value),
        RedCardFine.dirty(state.redCardFine.value),
        GamesChanges.dirty(state.gamesChanges.value),
        PointPerLoss.dirty(state.pointPerLoss.value),
        PointPerTie.dirty(state.pointPerTie.value),
        PointPerWin.dirty(state.pointPerWin.value),
        PointsPerLossShootOut.dirty(state.pointsPerLossShootOut.value),
        PointsPerWinShootOut.dirty(state.pointsPerWinShootOut.value),
      ]),
      allFormIsValid: allFormIsValid,
    ));

    validateCategoriesSelected();

    print('fuera del if $allFormIsValid');

    if (state.allFormIsValid && state.flagCategorySelect) {
      print("dentro del if $allFormIsValid");
      emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
      final categories = state.categorySelect;

      categories.forEach((element) {
        if (element.isSelect!) {
          Tournament newTournament = validationNewTournament(
              league: leagueId, categoryId: element.category?.categoryId);
          lisTournament.add(newTournament);
        }
      });

      print(lisTournament);
      final response = await _service.createTournamentPresident(lisTournament);
      emit(state.copyWith(
            formzStatus: FormzStatus.submissionSuccess, allFormIsValid: true));
      /*response.fold((l) {
       print('error desconocido');
        print("Error ${l.errorMessage}");
        print("Error ${l.data}");
        emit(state.copyWith(
            formzStatus: FormzStatus.submissionSuccess,
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage));
      }, (r) {
        print("Datos ${r}");
        emit(state.copyWith(
            formzStatus: FormzStatus.submissionSuccess, allFormIsValid: true));
      });*/
    }
  }
}
