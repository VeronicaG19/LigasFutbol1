import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../core/enums.dart';
import '../../../../domain/user_requests/service/i_user_requests_service.dart';

//part 'notification_count_state.dart';

@injectable
class NotificationCountCubit extends Cubit<int> {
  NotificationCountCubit(this._service) : super(0);

  final IUserRequestsService _service;

  Future<void> onLoadNotificationCount(
      int? requestTo, ApplicationRol rol) async {
    emit(0);
    if (rol == ApplicationRol.fieldOwner) {
      final count = await _service.getRequestCount(requestTo ?? 0,
          type: RequestType.MATCH_TO_FIELD);
      emit(count);
      return;
    }
    final count = await _service.getRequestCount(requestTo ?? 0);
    emit(count);
  }
}
