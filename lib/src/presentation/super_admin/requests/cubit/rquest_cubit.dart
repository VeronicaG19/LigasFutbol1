import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/user_requests/service/i_user_requests_service.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../domain/roles/entity/rol.dart';
import '../../../../domain/roles/entity/user_rol.dart';
import '../../../../domain/roles/service/i_rol_service.dart';
import '../../../../domain/user_configuration/entity/user_configuration.dart';
import '../../../../domain/user_requests/entity/user_requests.dart';

part 'rquest_state.dart';

@injectable
class RquestCubit extends Cubit<RquestState> {
  RquestCubit(this._iUserRequestsService, this._iRolService) : super(const RquestState());
  final IUserRequestsService _iUserRequestsService;
  final IRolService _iRolService;

  Future<void> getPendingRequest() async{
    emit(state.copyWith(
      screenStatus: ScreenStatus.loading
    )); 
    final response = await _iUserRequestsService.getRequestLeagueToAdmin();
    response.fold((l) => emit(state.copyWith(
      screenStatus: ScreenStatus.error,
      errorMessage: l.errorMessage
    )), (r) => {
      emit(state.copyWith(
         screenStatus: ScreenStatus.loaded,
         request: r
      ))
    });
  }


  Future<void> getPendingRequestField() async{
    emit(state.copyWith(
      screenStatus: ScreenStatus.loading
    )); 
    final response = await _iUserRequestsService.getRequestFieldToAdmin();
    response.fold((l) => emit(state.copyWith(
      screenStatus: ScreenStatus.error,
      errorMessage: l.errorMessage
    )), (r) => {
      emit(state.copyWith(
         screenStatus: ScreenStatus.loaded,
         request: r
      ))
    });
  }


  Future<void> onAcceptRequest(int requestId, bool status, int personId) async{
    emit(state.copyWith(
      screenStatus: ScreenStatus.loading
    )); 

    final response = await _iUserRequestsService.updateAdminUserRequest(requestId, status);
    response.fold((l) => emit(state.copyWith(
      screenStatus: ScreenStatus.error,
      errorMessage: l.errorMessage
    )), (r) => {
      
      emit(state.copyWith(
         screenStatus: ScreenStatus.loaded,
      )),
      updateRole(Rolesnm.LEAGUE_MANAGER, personId)
      //getPendingRequest()
    });
  }


  Future<void> onAcceptRequestField(int requestId, bool status) async{
    emit(state.copyWith(
      screenStatus: ScreenStatus.loading
    )); 

    final response = await _iUserRequestsService.updateAdminUserRequest(requestId, status);
    response.fold((l) => emit(state.copyWith(
      screenStatus: ScreenStatus.error,
      errorMessage: l.errorMessage
    )), (r) => {
      
      emit(state.copyWith(
         screenStatus: ScreenStatus.loaded,
      )),
      getPendingRequestField()
    });
  }


  Future<void> updateRole(Rolesnm role, int personId) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final response = await _iRolService.createUserRolAndUpdateByNames(personId, role.name);

    response.fold(
        (l) => {
              emit(state.copyWith(
                  screenStatus: ScreenStatus.error,
                  errorMessage: l.errorMessage))
            },
        (r) => {
              emit(state.copyWith(
                screenStatus: ScreenStatus.loaded,
              )),getPendingRequest()
            });
  }
}
