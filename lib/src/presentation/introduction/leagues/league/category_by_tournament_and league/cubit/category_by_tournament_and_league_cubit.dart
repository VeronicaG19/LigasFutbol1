import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/category/entity/category.dart';
import 'package:ligas_futbol_flutter/src/domain/category/service/i_category_service.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/entity/tournament.dart';
import 'package:ligas_futbol_flutter/src/domain/tournament/service/i_tournament_service.dart';

part 'category_by_tournament_and_league_state.dart';

@injectable
class CategoryByTournamentAndLeagueCubit
    extends Cubit<CategoryByTournamentAndLeagueState> {
  CategoryByTournamentAndLeagueCubit(
      this._categoryService, this._tournamentService)
      : super(const CategoryByTournamentAndLeagueState());

  final ICategoryService _categoryService;
  final ITournamentService _tournamentService;
  Future<void> getCategoryByTournamentByAndLeagueId(
      {required String tournamentName, required int legueId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _categoryService
        .getCategoryByTournamentByAndLeagueId(legueId, tournamentName,
            requiresAuthToken: false);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, categoryList: r));
    });
  }

  Future<void> getFindByNameAndCategory(
      int categoryId, String tournamentName) async {
    emit(state.copyWith(
      screenStatus: ScreenStatus.loading,
    ));
    final response = await _tournamentService.getFindByNameAndCategory(
        categoryId, tournamentName,
        requiresAuthToken: false);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(
          state.copyWith(screenStatus: ScreenStatus.loaded, tournamentInfo: r));
    });
  }
}
