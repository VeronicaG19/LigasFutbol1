import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ligas_futbol_flutter/src/domain/category/category.dart';

part 'seek_player_state.dart';

class SeekPlayerCubit extends Cubit<SeekPlayerState> {
  SeekPlayerCubit() : super(SeekPlayerState());

  void onChangeComment(String value) {
    final comment = Comment.dirty(value);
    emit(state.copyWith(
        status: Formz.validate([
          comment,
        ]),
        comment: comment));
  }

  Future<void> onUpdateNotificationFlag(int? index) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
    final notificationF = index == 1 ? 'N' : 'Y';

    emit(state.copyWith(notificationFlag: notificationF));
  }
}
