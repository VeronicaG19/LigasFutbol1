import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/experiences/entity/experiences.dart';
import 'package:ligas_futbol_flutter/src/domain/experiences/service/i_esperiences_service.dart';

part 'experiences_state.dart';

@injectable
class ExperiencesCubit extends Cubit<ExperiencesState> {
  ExperiencesCubit(this._experiencesService) : super(const ExperiencesState());

  final IExperiencesService _experiencesService;
  Future<void> getExperiencesByPlayer(int partyId) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response =
        await _experiencesService.getAllExperiencesByPlayer(partyId);
    response.fold(
        (l) => {
              emit(state.copyWith(
                  screenStatus: ScreenStatus.error,
                  errorMessage: l.errorMessage)),
              print("Error ${l.errorMessage}")
            }, (r) {
      print("Experiencias --> ${r.length}");
      emit(state.copyWith(
          screenStatus: ScreenStatus.loaded, experiencesList: r));
    });
  }
}
