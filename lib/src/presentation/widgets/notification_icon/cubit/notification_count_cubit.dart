//part 'notification_count_state.dart';

// @injectable
// class NotificationCountCubit extends Cubit<int> {
//   NotificationCountCubit(this._service) : super(0);
//
//   final IUserRequestsService _service;
//
//   Future<void> onLoadNotificationCount(
//       int? requestTo, ApplicationRol rol) async {
//     emit(0);
//     if (rol == ApplicationRol.fieldOwner) {
//       final count = await _service.getRequestCount(requestTo ?? 0,
//           type: RequestType.MATCH_TO_FIELD);
//       emit(count);
//       return;
//     }
//     final count = await _service.getRequestCount(requestTo ?? 0, rol: rol);
//     emit(count);
//   }
// }
