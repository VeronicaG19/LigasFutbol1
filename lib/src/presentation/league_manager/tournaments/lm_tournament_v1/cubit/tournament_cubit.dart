import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/category/entity/category.dart';
import 'package:ligas_futbol_flutter/src/domain/category/service/i_category_service.dart';
import 'package:ligas_futbol_flutter/src/domain/lookupvalue/entity/lookupvalue.dart';
import 'package:ligas_futbol_flutter/src/domain/lookupvalue/service/i_lookupvalue_service.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';

import '../../../../../domain/tournament/service/i_tournament_service.dart';
import '../tournaments_widgets/widgets/days.dart';

part 'tournament_state.dart';

@injectable
class TournamentCubit extends Cubit<TournamentState> {
  final ITournamentService _service;
  final ICategoryService _categoryService;
  final ILookUpValueService _lookUpValueService;

  TournamentCubit(
      this._service, this._categoryService, this._lookUpValueService)
      : super(TournamentState());

  Future<void> getCategoriesByLeage(List<Category> cat) async {
    //print("Valor del torneo---->$leagueId");
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    //final response = await _categoryService.getCategoriesByLeagueId(leagueId);
    await getLookUpValues();
    await getTypeOfgames();
    // response.fold(
    //     (l) => emit(state.copyWith(
    //         screenStatus: ScreenStatus.error,
    //         errorMessage: l.errorMessage)), (r) {
    //   emit(state.copyWith(screenStatus: ScreenStatus.loaded, categories: r));
    // });
    emit(state.copyWith(screenStatus: ScreenStatus.loaded, categories: cat));
  }

  Future<void> getTournamentsByCategory({required Category category}) async {
    print("Valor del torneo---->${category.categoryId}");
    emit(state.copyWith(screenStatus: ScreenStatus.tournamentLoading));
    final response =
        await _service.getTournamentsListPresidnt(category.categoryId!);
    int index = state.categories
        .indexWhere((element) => element.categoryId! == category.categoryId!);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(
          screenStatus: ScreenStatus.tournamentLoaded,
          tournaments: r,
          indexCatSelec: index));
    });
  }

  Future<void> getLookUpValues() async {
    final response =
        await _lookUpValueService.getLookUpValueByType("TYPE_OF_TOURNAMENT");
    //int index = state.categories.indexWhere((element) => element.categoryId! == category.categoryId! );
    emit(state.copyWith(lookUpValues: response));
  }

  Future<void> getTypeOfgames() async {
    final response =
        await _lookUpValueService.getLookUpValueByTypeLM("FOOTBALL_TYPE");
    //int index = state.categories.indexWhere((element) => element.categoryId! == category.categoryId! );
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(typeOfGames: r));
    });
  }

  Future<void> getTournamentDetail({required int tournamentId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.changeTournament));
    final response = await _service.detailTournamentPresident(tournamentId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      loadDays(r.daysMatchesOrder ?? '');
      emit(state.copyWith(
          screenStatus: ScreenStatus.changedTournament, tournamentSelected: r));
    });
  }

  void onChangeTournament(Tournament tournament) {
    emit(state.copyWith(
        screenStatus: ScreenStatus.changedTournament,
        tournamentSelected: tournament));
  }

  Future<void> loadDays(String listDaysSelected) async {
    List<int> daySelected = [];
    List<Days> days = [
      const Days(daysEnum: DaysEnum.lunes, isSelected: false),
      const Days(daysEnum: DaysEnum.martes, isSelected: false),
      const Days(daysEnum: DaysEnum.miercoles, isSelected: false),
      const Days(daysEnum: DaysEnum.jueves, isSelected: false),
      const Days(daysEnum: DaysEnum.viernes, isSelected: false),
      const Days(daysEnum: DaysEnum.sabado, isSelected: false),
      const Days(daysEnum: DaysEnum.domingo, isSelected: false),
    ];
    if (listDaysSelected != '') {
      if (listDaysSelected.isNotEmpty) {
        
        listDaysSelected.split(':').forEach((day) {
         
          daySelected.add(int.parse(day));
        });
      } else {
        daySelected.add(int.parse(listDaysSelected));
      }
    }

    if (daySelected.length >= 7) {
      for (var dayslcts in daySelected) {
         int ds = days
            .indexWhere((day) => day.daysEnum == day.getDaySelected(dayslcts));
        days[ds] = days[ds].copyWith(isSelected: true);
      }
    } else if (daySelected.isNotEmpty && daySelected.length < 7) {
      for (var dayslct in daySelected) {
        int ds = days
            .indexWhere((day) => day.daysEnum == day.getDaySelected(dayslct));
        days[ds] = days[ds].copyWith(isSelected: true);
      }
    }

    emit(state.copyWith(daysList: days));
  }

  Future<void> onchangePrivacity(bool privacity) async {
    emit(state.copyWith(
        tournamentSelected: state.tournamentSelected
            .copyWith(tournamentPrivacy: (privacity) ? 'Y' : 'N')));
  }

  Future<void> onchangeBegin(bool privacity) async {
    emit(state.copyWith(
        tournamentSelected: state.tournamentSelected.copyWith(
      statusBegin: (privacity) ? 'Y' : 'N',
    )));
  }

  Future<void> onchangeBlueCards(bool blueCrads) async {
    emit(state.copyWith(
        tournamentSelected: state.tournamentSelected
            .copyWith(activateBlueCard: (blueCrads) ? 'Y' : 'N')));
  }

  Future<void> ontTournamentChange({required LookUpValue tyTournamnet}) async {
    emit(state.copyWith(
        tournamentSelected: state.tournamentSelected
            .copyWith(typeTournament: tyTournamnet.lookupValue.toString())));
  }

  Future<void> onChangeName({required String tournamentName}) async {
    print(tournamentName);
    emit(state.copyWith(
        tournamentSelected:
            state.tournamentSelected.copyWith(tournamentName: tournamentName)));
  }

  Future<void> onchangeUnlimitedChanges(bool unlmited) async {
    emit(state.copyWith(
        tournamentSelected: state.tournamentSelected
            .copyWith(unlimitedChanges: (unlmited) ? 'Y' : 'N')));
  }

  Future<void> onchangePermitedTeams(String cal) async {
    emit(state.copyWith(
        tournamentSelected:
            state.tournamentSelected.copyWith(maxTeams: int.parse(cal))));
  }

  Future<void> onchangePermitedPlayers(String cal) async {
    emit(state.copyWith(
        tournamentSelected:
            state.tournamentSelected.copyWith(maxPlayers: int.parse(cal))));
  }

  Future<void> onchangeBycards(bool temporaryReprimands) async {
    emit(state.copyWith(
        tournamentSelected: state.tournamentSelected
            .copyWith(temporaryReprimands: (temporaryReprimands) ? 'Y' : 'N')));
  }

  Future<void> onchangeMatchTime(String natchTime) async {
    emit(state.copyWith(
        tournamentSelected: state.tournamentSelected
            .copyWith(gameTimes: int.parse(natchTime))));
  }

  Future<void> onchangeTournamentDate(DateTime tournamentDate) async {
    emit(state.copyWith(
        tournamentSelected: state.tournamentSelected
            .copyWith(inscriptionDate: tournamentDate)));
  }

  Future<void> onchangeredCardFine(String redCardFine) async {
    emit(state.copyWith(
        tournamentSelected: state.tournamentSelected
            .copyWith(redCardFine: int.parse(redCardFine))));
  }

  Future<void> onchangeyellowCardFine(String yellowCardFine) async {
    emit(state.copyWith(
        tournamentSelected: state.tournamentSelected
            .copyWith(yellowCardFine: int.parse(yellowCardFine))));
  }

  Future<void> onchangegameChanges(String gameChanges) async {
    emit(state.copyWith(
        tournamentSelected: state.tournamentSelected
            .copyWith(gameChanges: int.parse(gameChanges))));
  }

  Future<void> onchangebreaksNumber(String breaksNumber) async {
    emit(state.copyWith(
        tournamentSelected: state.tournamentSelected
            .copyWith(breaksNumber: int.parse(breaksNumber))));
  }

  Future<void> onchangebreaksDuration(String breaksDuration) async {
    emit(state.copyWith(
        tournamentSelected: state.tournamentSelected
            .copyWith(breaksDuration: int.parse(breaksDuration))));
  }

  Future<void> onchangeDuratitonTime(String durationTime) async {
    emit(state.copyWith(
        tournamentSelected: state.tournamentSelected
            .copyWith(durationByTime: int.parse(durationTime))));
  }

  Future<void> inchangeDays(bool val, Days day) async {
    final days = state.daysList;
    emit(state.copyWith(daysList: []));
    days.forEach((element) {
      if (element.daysEnum == day.daysEnum) {
        final index = days.indexOf(element);
        days.removeAt(index);
        days.insert(index, element.copyWith(isSelected: val));
      }
    });

    emit(state.copyWith(daysList: days));
  }

  Future<void> updateTournament() async {
    emit(state.copyWith(screenStatus: ScreenStatus.changeTournament));
    Tournament tournamnet = state.tournamentSelected;
    String dayLst = getDaysSelected();
    print(dayLst);
    tournamnet = tournamnet.copyWith(daysMatchesOrder: dayLst);
    final response = await _service.updateTournamentPresiden(tournamnet);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      loadDays(r.daysMatchesOrder ?? '');
      emit(state.copyWith(
          screenStatus: ScreenStatus.changedTournament, tournamentSelected: r));
    });
  }

  Future<void> deleteTournamnet() async {
    emit(state.copyWith(screenStatus: ScreenStatus.changeTournament));
    final response = await _service
        .deleteTournamentPresident(state.tournamentSelected.tournamentId!);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      Category cat = state.categories.elementAt(state.indexCatSelec!);
      getTournamentsByCategory(category: cat);
      emit(state.copyWith(
          screenStatus: ScreenStatus.tournamentDeleted,
          tournamentSelected: Tournament.empty));
    });
  }

  String getDaysSelected() {
    List<int> daysSelctd = [];

    state.daysList.forEach((element) {
      if (element.isSelected == true) {
        daysSelctd.add(element.getNUmberDay(element.daysEnum!));
      }
    });

    if (daysSelctd.length == 1) {
      return '${daysSelctd[0]}';
    } else if (daysSelctd.length > 1) {
      String day = daysSelctd.join(':');
      return day;
    } else {
      return '';
    }
  }
}
