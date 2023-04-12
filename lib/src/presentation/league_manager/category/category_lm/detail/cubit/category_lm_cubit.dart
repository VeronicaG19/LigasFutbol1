import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/category/category.dart';
import 'package:ligas_futbol_flutter/src/domain/leagues/entity/league.dart';
import 'package:ligas_futbol_flutter/src/domain/lookupvalue/entity/lookupvalue.dart';
import 'package:ligas_futbol_flutter/src/domain/lookupvalue/service/i_lookupvalue_service.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/goals_by_tournament/goals_tournament_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/dto/scoring_by_tournament/scoring_tournament_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/service/i_tournament_service.dart';

import '../../../../../app/bloc/authentication_bloc.dart';

part 'category_lm_state.dart';

@injectable
class CategoryLmCubit extends Cubit<CategoryLmState> {
  CategoryLmCubit(
    this._categoryService,
    this._lookUpValueService,
    this._tournamentService,
    this.authenticationBloc,
  ) : super(const CategoryLmState());

  final ICategoryService _categoryService;
  final ILookUpValueService _lookUpValueService;
  final ITournamentService _tournamentService;
  final AuthenticationBloc authenticationBloc;

  int? type;

  Future<void> getCategoryByTournamentByAndLeagueId(
      {required int legueId}) async {
    print("Valor de la liga---->$legueId");
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _categoryService.getCategoriesByLeagueId(legueId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, categoryList: r, status: FormzStatus.pure));
    });
  }

  Future<void> getInfoCategoryId({required int categoryId}) async {
    
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _categoryService.getCategoryById(categoryId);
    

    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) async {
      emit(state.copyWith(categoryInfo: r, categoryId: categoryId));
      getCourrenTountament(r.categoryId!);
    });
   
  }

  Future<void> getCourrenTountament(int categryId) async{
    //state.categoryId == categryId;
    final getTournament = await _tournamentService.getCurrentTournament(categryId);
    final lookUpValueResponse =
        await _lookUpValueService.getLookUpValueByType("SOCCER_CAT_GENDER");

    getTournament.fold((l) {
        print("error ----->${l.errorMessage}");
        emit(state.copyWith(
            screenStatus: ScreenStatus.error, errorMessage: l.errorMessage));
      }, (r) async {
        print("se creo correctamente todo -------------------");
        LookUpValue lookUpValue = LookUpValue.empty;
        for (final e in lookUpValueResponse) {
          if (e.lookupValue.toString() == state.categoryInfo.sportType) {
            lookUpValue = e;
          }
        }
        final categoryName =
            CategoryName.dirty(state.categoryInfo.categoryName ?? '');
        final comment = Comment.dirty(state.categoryInfo.categoryComment ?? '');
        final maxAge = MaxAge.dirty(state.categoryInfo.ageMax.toString() ?? '');
        final minAge = MinAge.dirty(state.categoryInfo.ageMin.toString() ?? '');
        final redForPunishment = RedForPunishment.dirty(
            state.categoryInfo.redForPunishment.toString() ?? '');
        final yellowForPunishment = YellowForPunishment.dirty(
            state.categoryInfo.yellowForPunishment.toString() ?? '');
        emit(state.copyWith(
            tournamentInfo: r,
            status: Formz.validate([
              categoryName,
              comment,
              maxAge,
              minAge,
              redForPunishment,
              yellowForPunishment
            ]),
            screenStatus: ScreenStatus.infoLoading,
            categoryName: categoryName,
            comment: comment,
            maxAge: maxAge,
            minAge: minAge,
            categoryId: categryId,
            redForPunishment: redForPunishment,
            yellowForPunishment: yellowForPunishment,
            lookupValueList: lookUpValueResponse,
            selectedLookupValue: lookUpValue));
        //
      });
        getGoalsTournamentId();
     getHistoricTournamentByCategoryId();
  }

  Future<void> getLookUpValueByTypeLM() async {
    final lookUpValueResponse =
        await _lookUpValueService.getLookUpValueByType("SOCCER_CAT_GENDER");

    LookUpValue lookUpValue = LookUpValue.empty;
    for (final e in lookUpValueResponse) {
      lookUpValue = e;
    }
    emit(state.copyWith(
        lookupValueList: lookUpValueResponse,
        selectedLookupValue: lookUpValue));
  }

  Future<void> deleteCategoryId(int? categoryId, int leagueId) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _categoryService.deleteCategoryById(categoryId!);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      getCategoryByTournamentByAndLeagueId(legueId: leagueId);
    });
  }

  void onChangeCategoryName(String value) {
    final categoryName = CategoryName.dirty(value);
    emit(state.copyWith(
        status: Formz.validate([
          categoryName,
          state.comment,
          state.maxAge,
          state.minAge,
          state.redForPunishment,
          state.yellowForPunishment
        ]),
        categoryName: categoryName));
  }

  void onChangeComment(String value) {
    final comment = Comment.dirty(value);
    emit(state.copyWith(
        status: Formz.validate([
          comment,
          state.maxAge,
          state.minAge,
          state.redForPunishment,
          state.yellowForPunishment,
          state.categoryName
        ]),
        comment: comment));
  }

  void onTypeChange(LookUpValue lookUpValue) {
    emit(state.copyWith(selectedLookupValue: lookUpValue));
  }

  void onCategoryIdChange(int categoryId) {
    emit(state.copyWith(categoryId: categoryId));
    print("valor guardado --->$categoryId");
  }

  void onChangeMaxAge(String value) {
    final maxAge = MaxAge.dirty(value);
    emit(state.copyWith(
        status: Formz.validate([
          maxAge,
          state.minAge,
          state.redForPunishment,
          state.yellowForPunishment,
          state.categoryName,
          state.comment
        ]),
        maxAge: maxAge));
  }

  void onChangeMinAge(String value) {
    final minAge = MinAge.dirty(value);
    emit(state.copyWith(
        status: Formz.validate([
          minAge,
          state.redForPunishment,
          state.yellowForPunishment,
          state.categoryName,
          state.comment,
          state.maxAge
        ]),
        minAge: minAge));
  }

  void onChangeRedForPunishment(String value) {
    final redForPunishment = RedForPunishment.dirty(value);
    emit(state.copyWith(
        status: Formz.validate([
          redForPunishment,
          state.yellowForPunishment,
          state.categoryName,
          state.comment,
          state.maxAge,
          state.minAge
        ]),
        redForPunishment: redForPunishment));
  }

  void onChangeYellowForPunishment(String value) {
    final yellowForPunishment = YellowForPunishment.dirty(value);
    emit(state.copyWith(
        status: Formz.validate([
          yellowForPunishment,
          state.categoryName,
          state.comment,
          state.maxAge,
          state.minAge,
          state.redForPunishment
        ]),
        yellowForPunishment: yellowForPunishment));
  }

  Future<void> updateCategoryId() async {
    print("Valor1");
    //valida el formulario
    if (!state.status.isValidated) return;
    print("Valor2");
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    print("Valor--->${state.yellowForPunishment.value}");
    print("Valor--->${state.redForPunishment.value}");
    print("Valor--->${state.comment.value}");
    print("Valor--->${state.maxAge.value}");
    print("Valor--->${state.minAge.value}");
    print("Valor--->${state.selectedLookupValue.lookupValue}");
    print("Valor--->${state.categoryName.value}");
    final response =
        await _categoryService.editCategory(state.categoryInfo.copyWith(
      yellowForPunishment: int.parse(state.yellowForPunishment.value),
      categoryName: state.categoryName.value,
      ageMax: int.parse(state.maxAge.value),
      ageMin: int.parse(state.minAge.value),
      gender: state.selectedLookupValue.lookupValue,
      categoryComment: state.comment.value,
      sportType: state.selectedLookupValue.lookupValue.toString(),
      redForPunishment: int.parse(state.redForPunishment.value),
    ));

    response.fold(
        (l) => emit(
              state.copyWith(
                  status: FormzStatus.submissionFailure,
                  errorMessage: l.errorMessage),
            ), (r) {
            final catL =  state.categoryList;
            int index = catL.indexWhere((element) => element.categoryId == r.categoryId);
            catL.removeWhere((element) => element.categoryId == r.categoryId );
            catL.insert(index, r);

      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        categoryInfo: r,
        categoryList: catL
      ));
    });
    // getCategoryByTournamentByAndLeagueId(
    //   legueId: authenticationBloc.state.leagueManager.leagueId);
  }

  Future<void> createCategoryId(League league) async {
    print("Valor1");
    //valida el formulario
    if (!state.status.isValidated) return;
    print("Valor2");
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    print("Valor--->${state.yellowForPunishment.value}");
    print("Valor--->${state.redForPunishment.value}");
    print("Valor--->${state.comment.value}");
    print("Valor--->${state.maxAge.value}");
    print("Valor--->${state.minAge.value}");
    print("Valor--->${state.selectedLookupValue.lookupValue}");
    print("Valor--->${state.categoryName.value}");
    final response = await _categoryService.createCategory(state.categoryInfo
        .copyWith(
            yellowForPunishment: int.parse(state.yellowForPunishment.value),
            categoryName: state.categoryName.value,
            ageMax: int.parse(state.maxAge.value),
            ageMin: int.parse(state.minAge.value),
            categoryComment: state.comment.value,
            gender: state.selectedLookupValue.lookupValue,
            sportType: state.selectedLookupValue.lookupValue.toString(),
            redForPunishment: int.parse(state.redForPunishment.value),
            leagueId: league));

    response.fold(
        (l) => emit(
              state.copyWith(
                  status: FormzStatus.submissionFailure,
                  errorMessage: l.errorMessage),
            ), (r) async {
      await getCategoryByTournamentByAndLeagueId(legueId: league.leagueId);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, categoryInfo: r));
    });
  }

  Future<void> getHistoricTournamentByCategoryId() async {
    print("categoria seleccionada ----->${state.categoryId}");
    emit(state.copyWith(screenStatus: ScreenStatus.tournamentloading));
    if (state.categoryId == 0) {
      print("valor vacio----->");
      emit(state.copyWith(
        screenStatus: ScreenStatus.inSelectCategory,
      ));
    } else {
      emit(state.copyWith(screenStatus: ScreenStatus.tournamentloading));
      final response =
          await _tournamentService.getHistoricTournaments(state.categoryId);
      response.fold(
          (l) => emit(state.copyWith(
              screenStatus: ScreenStatus.error,
              errorMessage: l.errorMessage)), (r) {
        print("Datos ${r.length}");

        emit(state.copyWith(
            screenStatus: ScreenStatus.tournamentloaded, tournamentList: r));
      });
    }
  }

  Future<void> getGoalsTournamentId() async {
    if (state.tournamentInfo.tournamentId == 0) {
      emit(state.copyWith(screenStatus: ScreenStatus.inSelectCategory));
      print(
          "valor vacio el torneo 1 ----->${state.tournamentInfo.tournamentId}");
      emit(state.copyWith(
        screenStatus: ScreenStatus.inSelectCategory,
      ));
    } else {
      emit(state.copyWith(screenStatus: ScreenStatus.tournamentloading));
      print(
          "valor lleno el torneo 2 ----->${state.tournamentInfo.tournamentId}");
      final response = await _tournamentService
          .getScoringTournamentId(state.tournamentInfo.tournamentId!);
      //1141
      response.fold((l) async{
        print("error torneo 1 ----->${l.errorMessage}");
        final response = await _tournamentService
            .getGoalsTournamentId(state.tournamentInfo.tournamentId!);
        response.fold((l) {
          print("error torneo 2 ----->${l.errorMessage}");
          emit(state.copyWith(
              screenStatus: ScreenStatus.error, errorMessage: l.errorMessage));
        }, (r) async {
          print("respuesta correcta ----->");
          emit(state.copyWith(
              screenStatus: ScreenStatus.tournamentloaded, goalsTournament: r));
        });
       /* emit(state.copyWith(
            screenStatus: ScreenStatus.error, errorMessage: l.errorMessage));*/
      }, (r) async {
        emit(state.copyWith(scoringTournamentDTO: r));
        final response = await _tournamentService
            .getGoalsTournamentId(state.tournamentInfo.tournamentId!);
        response.fold((l) {
          print("error torneo 2 ----->${l.errorMessage}");
          emit(state.copyWith(
              screenStatus: ScreenStatus.error, errorMessage: l.errorMessage));
        }, (r) async {
          print("respuesta correcta ----->");
          emit(state.copyWith(
              screenStatus: ScreenStatus.tournamentloaded, goalsTournament: r));
        });
      });
    }
  }
}
