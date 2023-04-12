import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/user_configuration/entity/user_configuration.dart';

import '../../../../../domain/user_configuration/service/i_user_configuration_service.dart';

part 'notification_state.dart';

@Injectable()
class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this._configurationService) : super(NotificationInitial());

  final IUserConfigurationService _configurationService;
  UserConfiguration _currentConfiguration = UserConfiguration.empty;

  Future<void> onGetUserConfiguration(int userId) async {
    emit(NotificationLoading());
    final request = await _configurationService.getUserConfiguration(userId);
    final config = _configurationService.getPrimaryConfiguration(request);
    if (config.configuration.isEmpty) {
      final register = await _configurationService.createUserConfiguration(
        UserConfiguration(
            enabledFlag: 'Y',
            notificationEmail: 'N',
            notificationFlag: 'N',
            notificationPhone: 'N',
            userRolId: config.userRolId),
      );
      _currentConfiguration = register.getOrElse(() => UserConfiguration.empty);
      emit(NotificationLoaded(_currentConfiguration));
    } else {
      _currentConfiguration = config.configuration;
      emit(NotificationLoaded(config.configuration));
    }
  }

  Future<void> onUpdateNotificationFlag(int? index) async {
    emit(NotificationLoading());
    final notificationF = index == 1 ? 'N' : 'Y';

    _onUpdateConfiguration(
        _currentConfiguration.copyWith(notificationFlag: notificationF));
  }

  Future<void> onUpdatePhoneFlag() async {
    emit(NotificationLoading());
    final notificationF =
        _currentConfiguration.notificationPhone == 'Y' ? 'N' : 'Y';
    _onUpdateConfiguration(
        _currentConfiguration.copyWith(notificationPhone: notificationF));
  }

  Future<void> onUpdateEmailFlag() async {
    emit(NotificationLoading());
    final notificationF =
        _currentConfiguration.notificationEmail == 'Y' ? 'N' : 'Y';
    _onUpdateConfiguration(
        _currentConfiguration.copyWith(notificationEmail: notificationF));
  }

  Future<void> _onUpdateConfiguration(UserConfiguration configuration) async {
    final request =
        await _configurationService.updateUserConfiguration(configuration);
    request.fold((l) => emit(NotificationError(l.errorMessage)),
        (r) => emit(NotificationLoaded(r)));
  }
}
