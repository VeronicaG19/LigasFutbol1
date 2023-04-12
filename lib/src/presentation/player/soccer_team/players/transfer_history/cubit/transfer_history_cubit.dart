import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/team/entity/team.dart';
import 'package:ligas_futbol_flutter/src/domain/team/service/i_team_service.dart';

part 'transfer_history_state.dart';

@injectable
class TransferHistoryCubit extends Cubit<TransferHistoryState> {
  TransferHistoryCubit(this._teamService) : super(const TransferHistoryState());

  final ITeamService _teamService;

  Future<void> getTransferHistoryPlayer({required int partyId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _teamService.getTransferHistoryPlayer(partyId);
    response.fold(
        (l) => emit(state.copyWith(
            screenStatus: ScreenStatus.error,
            errorMessage: l.errorMessage)), (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, teamList: r));
    });
  }
}
