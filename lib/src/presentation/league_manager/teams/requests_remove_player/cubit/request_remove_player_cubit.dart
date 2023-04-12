import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/entity/user_requests.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/service/i_user_requests_service.dart';

part 'request_remove_player_state.dart';

@injectable
class RequestRemovePlayerCubit extends Cubit<RequestRemovePlayerState> {
  RequestRemovePlayerCubit(this._userRequestsService)
      : super(RequestRemovePlayerState());

  final IUserRequestsService _userRequestsService;

  Future<void> getUserDeleteRequest({required int teamId}) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _userRequestsService.getUserDeleteRequest(teamId);
    response.fold(
        (l) => {
              emit(state.copyWith(
                  screenStatus: ScreenStatus.loaded,
                  errorMessage: l.errorMessage)),
              print("Error ${l.errorMessage}")
            }, (r) {
      print("Datos ${r.length}");
      emit(state.copyWith(screenStatus: ScreenStatus.loaded, userRequest: r));
    });
  }
}
