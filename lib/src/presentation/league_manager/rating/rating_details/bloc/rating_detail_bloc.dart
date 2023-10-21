import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/qualification/entity/qualification.dart';
import '../../../../../domain/qualification/service/i_qualification_service.dart';

part 'rating_detail_bloc.freezed.dart';
part 'rating_detail_event.dart';
part 'rating_detail_state.dart';

@injectable
class RatingDetailBloc extends Bloc<RatingDetailEvent, RatingDetailState> {
  final IQualificationService _service;
  RatingDetailBloc(this._service) : super(const RatingDetailState.initial()) {
    on<RatingDetailEvent>((event, emit) async {
      await event.map(
        started: (value) async => await _onStart(value, emit),
      );
    });
  }

  Future<void> _onStart(_Started event, Emitter<RatingDetailState> emit) async {
    emit(const RatingDetailState.loading());
    final response =
        await _service.getRatingDetailList(event.matchId, event.type);
    response.fold((l) => emit(RatingDetailState.error(l.errorMessage)),
        (r) => emit(RatingDetailState.ratingsLoaded(r)));
  }
}
