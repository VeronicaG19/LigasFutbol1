import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums.dart';
import '../../../../domain/matches/dto/referee_match.dart';
import '../../../../domain/matches/service/i_matches_service.dart';

part 'report_history_state.dart';

@Injectable()
class ReportHistoryCubit extends Cubit<ReportHistoryState> {
  ReportHistoryCubit(this._matchesService) : super(const ReportHistoryState());

  final IMatchesService _matchesService;

  Future<void> onLoadInitialData(int refereeId) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final request =
        await _matchesService.getHistoricRefereeMatches(refereeId: refereeId);
    emit(state.copyWith(
        reportList: request, screenState: BasicCubitScreenState.loaded));
  }
}
