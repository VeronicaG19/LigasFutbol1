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
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded,
          categoryList: r,
          categoryInfo: Category.empty,
          categoryId: 0,
          status: FormzStatus.pure));
      getSoccerGender();
    });
  }

  Future<void> getInfoCategoryId({required int categoryId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _categoryService.getCategoryById(categoryId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(
        categoryInfo: r,
        categoryId: categoryId,
        screenStatus: ScreenStatus.infoLoading,
      ));
      getHistoricTournamentByCategoryId();
      //getCourrenTountament(r.categoryId!);
    });
  }

  /*UPDATE*/
  Future<void> onChangeNameCategoryUpdate(
      {required String categoryName}) async {
    emit(state.copyWith(
      categoryInfo: state.categoryInfo.copyWith(categoryName: categoryName),
    ));
  }

  Future<void> onChangeMinAgeUpdate({required String ageMin}) async {
    emit(state.copyWith(
      categoryInfo: state.categoryInfo.copyWith(
        ageMin: int.parse(ageMin),
      ),
    ));
  }

  Future<void> onChangeMaxAgeUpdate({required String ageMax}) async {
    emit(state.copyWith(
      categoryInfo: state.categoryInfo.copyWith(
        ageMax: int.parse(ageMax),
      ),
    ));
  }

  Future<void> onChangeTypeGenderUpdate(
      {required LookUpValue typeGender}) async {
    emit(state.copyWith(
      categoryInfo: state.categoryInfo.copyWith(
        gender: typeGender.lookupValue,
      ),
    ));
  }

  Future<void> onChangeCommentUpdate({required String categoryComment}) async {
    emit(state.copyWith(
      categoryInfo: state.categoryInfo.copyWith(
        categoryComment: categoryComment,
      ),
    ));
  }

  Future<void> onChangeYellowCardUpdate(
      {required String yellowForPunishment}) async {
    emit(state.copyWith(
      categoryInfo: state.categoryInfo.copyWith(
        yellowForPunishment: int.parse(yellowForPunishment),
      ),
    ));
  }

  Future<void> onChangeRedCardUpdate({required String redForPunishment}) async {
    emit(state.copyWith(
      categoryInfo: state.categoryInfo.copyWith(
        redForPunishment: int.parse(redForPunishment),
      ),
    ));
  }
  /*UPDATE*/

  Future<void> getCourrenTountament(int categryId) async {
    //state.categoryId == categryId;
    final getTournament =
        await _tournamentService.getCurrentTournament(categryId);
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
      final maxAge = MaxAge.dirty(state.categoryInfo.ageMax ?? 0);
      final minAge = MinAge.dirty(state.categoryInfo.ageMin ?? 0);
      final redForPunishment = RedForPunishment.dirty(
          state.categoryInfo.redForPunishment.toString() ?? '');
      final yellowForPunishment = YellowForPunishment.dirty(
          state.categoryInfo.yellowForPunishment.toString() ?? '');
      emit(state.copyWith(
          tournamentInfo: r,
          status: Formz.validate([
            categoryName,
            //comment,
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

  Future<void> getSoccerGender() async {
    //emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response =
        await _lookUpValueService.getLookUpValueByTypeLM('SOCCER_CAT_GENDER');

    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(
        screenStatus: ScreenStatus.lookupsLoaded,
        lookupValueList: r,
        selectedLookupValue: r[0],
      ));
    });
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
      status: Formz.validate([categoryName, state.categoryName]),
      categoryName: categoryName,
    ));
  }

  void onChangeComment(String value) {
    final comment = Comment.dirty(value);
    emit(state.copyWith(
        status: Formz.validate([
          // comment,
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
    final valMax = int.parse((value.isNotEmpty) ? value : '0');
    final valMin = state.minAge.value;

    print('>>> ---------------------------------------------------------');
    print('>>> onChangeMaxAge');
    print('>>> ---------------------------------------------------------');
    print('>>> state.maxAge.value : ${state.maxAge.value}');
    print('>>> state.minAge.value : ${state.minAge.value}');
    print('>>> ---------------------------------------------------------');
    print('>>> valMax : $valMax');
    print('>>> valMin : $valMin');
    print('>>> ---------------------------------------------------------');

    emit(state.copyWith(validAge: (valMax > valMin)));

    final maxAge = MaxAge.dirty(valMax);

    print('${maxAge.value}');
    print('>>> ---------------------------------------------------------');

    emit(state.copyWith(
        status: Formz.validate([
          maxAge,
          state.minAge,
          state.redForPunishment,
          state.yellowForPunishment,
          state.categoryName,
          //   state.comment
        ]),
        maxAge: maxAge));
  }

  void onChangeMinAge(String value) {
    final valMax = state.maxAge.value;
    final valMin = int.parse((value.isNotEmpty) ? value : '0');

    print('>>> ---------------------------------------------------------');
    print('>>> onChangeMinAge');
    print('>>> ---------------------------------------------------------');
    print('>>> state.maxAge.value : ${state.maxAge.value}');
    print('>>> state.minAge.value : ${state.minAge.value}');
    print('>>> ---------------------------------------------------------');
    print('>>> valMax : $valMax');
    print('>>> valMin : $valMin');
    print('>>> ---------------------------------------------------------');

    emit(state.copyWith(validAge: (valMin < valMax)));

    final minAge = MinAge.dirty(valMin);

    print('${minAge.value}');
    print('>>> ---------------------------------------------------------');

    emit(state.copyWith(
        status: Formz.validate([
          minAge,
          state.redForPunishment,
          state.yellowForPunishment,
          state.categoryName,
          //state.comment,
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
          //state.comment,
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
          //state.comment,
          state.maxAge,
          state.minAge,
          state.redForPunishment
        ]),
        yellowForPunishment: yellowForPunishment));
  }

  Future<void> updateCategoryId() async {
    Category category = state.categoryInfo;
    //valida el formulario
    //if (!state.status.isValidated) return;

    final response = await _categoryService.editCategory(category);

    response.fold(
        (l) => emit(
              state.copyWith(
                  status: FormzStatus.submissionFailure,
                  errorMessage: l.errorMessage),
            ), (r) {
      final catL = state.categoryList;
      int index =
          catL.indexWhere((element) => element.categoryId == r.categoryId);
      catL.removeWhere((element) => element.categoryId == r.categoryId);
      catL.insert(index, r);

      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          screenStatus: ScreenStatus.updatedSuccessful,
          categoryInfo: r,
          categoryList: catL));
    });
    // getCategoryByTournamentByAndLeagueId(
    //   legueId: authenticationBloc.state.leagueManager.leagueId);
  }

  Future<void> createCategoryId(League league) async {
    //valida el formulario
    //if (!state.status.isValidated) return;
    validateForm();

    if (state.allFormIsValid && state.validAge) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final response = await _categoryService.createCategory(
        state.categoryInfo.copyWith(
          yellowForPunishment: int.parse(state.yellowForPunishment.value),
          categoryName: state.categoryName.value,
          ageMax: state.maxAge.value,
          ageMin: state.minAge.value,
          categoryComment: state.comment.value,
          gender: state.selectedLookupValue.lookupValue,
          sportType: state.selectedLookupValue.lookupValue.toString(),
          redForPunishment: int.parse(state.redForPunishment.value),
          leagueId: league,
        ),
      );

      response.fold((l) {
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: l.errorMessage,
        ));
      }, (r) async {
        await getCategoryByTournamentByAndLeagueId(legueId: league.leagueId);

        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          screenStatus: ScreenStatus.successfullyCreated,
          categoryInfo: r,
        ));

        resetInputsAndForm();
      });

      emit(state.copyWith(
        status: FormzStatus.pure,
      ));
    }
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
              errorMessage: '>>> ${l.errorMessage}')), (r) {
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
      response.fold((l) async {
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

  void resetInputsAndForm() {
    emit(state.copyWith(
      categoryName: const CategoryName.pure(),
      minAge: const MinAge.pure(),
      maxAge: const MaxAge.pure(),
      comment: const Comment.pure(),
      yellowForPunishment: const YellowForPunishment.pure(),
      redForPunishment: const RedForPunishment.pure(),
      status: FormzStatus.pure,
    ));
  }

  void validateForm() {
    bool allFormIsValid;

    if (state.categoryName.valid &&
        state.minAge.valid &&
        state.maxAge.valid &&
        // state.comment.valid &&
        state.yellowForPunishment.valid &&
        state.redForPunishment.valid) {
      allFormIsValid = true;
    } else {
      allFormIsValid = false;
    }

    emit(state.copyWith(
      status: Formz.validate([
        CategoryName.dirty(state.categoryName.value),
        MinAge.dirty(state.minAge.value),
        MaxAge.dirty(state.maxAge.value),
        //Comment.dirty(state.comment.value),
        YellowForPunishment.dirty(state.yellowForPunishment.value),
        RedForPunishment.dirty(state.redForPunishment.value),
      ]),
      allFormIsValid: allFormIsValid,
      validAge: ((state.minAge.value < state.maxAge.value) &&
          (state.maxAge.value > state.minAge.value)),
    ));
  }

  String? genderType(int value) {
    if (value == 1) {
      return "Varonil";
    } else if (value == 2) {
      return "Femenil";
    } else if (value == 3) {
      return "Mixto";
    } else {
      return "Otro";
    }
  }
}
