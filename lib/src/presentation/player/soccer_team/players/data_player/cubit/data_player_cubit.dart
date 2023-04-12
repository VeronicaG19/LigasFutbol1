import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/player/entity/player.dart';
import 'package:ligas_futbol_flutter/src/domain/player/service/i_player_service.dart';
import 'package:meta/meta.dart';

part 'data_player_state.dart';

@injectable
class DataPlayerCubit extends Cubit<DataPlayerState> {
  DataPlayerCubit(this._service) : super(const DataPlayerState());

  final IPlayerService _service;

  Future<void> loadInfoPlayer({required int personId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final request = await _service.getDataPlayerByPartyId(personId);
    request.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, playerInfo: r));
    });
  }
}
