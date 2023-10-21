import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/core/enums.dart';
import 'package:ligas_futbol_flutter/src/domain/player/entity/player.dart';
import 'package:ligas_futbol_flutter/src/domain/user/dto/user_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/user/service/i_user_service.dart';
import 'package:user_repository/user_repository.dart';

part 'account_state.dart';

@injectable
class AccountCubit extends Cubit<AccountState> {
  AccountCubit(this._iUserService) : super(const AccountState());

  final IUserService _iUserService;

  Future<void> loadInitialData({required User user}) async {
    emit(state.copyWith(
      screenState: BasicCubitScreenState.loading,
      userDTO: UserDTO(
        description: "Cerrar cuenta",
        enabledFlag: "N",
        firstName: user.person.firstName,
        lastName: user.person.lastName,
        password: user.password,
        personId: user.person.personId,
        primaryFlag: "N",
        userId: user.id,
        userName: user.userName,
      ),
      player: Player(
        playerid: user.person.personId,
        partyId: user.person.personId,
      ),
    ));

    emit(state.copyWith(
      screenState: BasicCubitScreenState.loaded,
    ));
  }

  void onCheckWarning({required bool flag}) {
    emit(state.copyWith(warningReaded: flag));
  }

  void cancelDeactivateAccount() {
    emit(state.copyWith(warningReaded: false));
  }

  Future<void> deactivateAccount() async {
    print('() >>>>> deactivateAccount');
    emit(state.copyWith(
      screenState: BasicCubitScreenState.sending,
    ));
    final response = await _iUserService.deactivateAccount(state.userDTO!);

    response.fold((l) {
      print('(ERROR) >>>>> ${l.errorMessage}');
      emit(state.copyWith(
        screenState: BasicCubitScreenState.error,
      ));
    }, (r) {
      emit(state.copyWith(
        screenState: BasicCubitScreenState.success,
      ));
      print('(SUCCESS) >>>>> ${r.toString()}');

      deleteAccount();
    });
  }

  Future<void> deleteAccount() async {
    print('() >>>>> deleteAccount');
    emit(state.copyWith(
      screenState: BasicCubitScreenState.submissionInProgress,
    ));

    final response = await _iUserService.deleteAccount(state.player!);

    response.fold((l) {
      print('(ERROR) >>>>> ${l.errorMessage}');
      emit(state.copyWith(
        screenState: BasicCubitScreenState.submissionFailure,
      ));
    }, (r) {
      emit(state.copyWith(
        screenState: BasicCubitScreenState.submissionSuccess,
      ));
      print('(SUCCESS) >>>>> ${r.toString()}');
    });
  }
}
