import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/qualification/service/i_qualification_service.dart';

import '../../../../domain/qualification/entity/qualification.dart';

part 'rattingfield_state.dart';

@injectable
class RattingfieldCubit extends Cubit<RattingfieldState> {
  RattingfieldCubit(this._service)
      : super(RattingfieldState());
      final IQualificationService _service;

      Future<void> onGetCalifications(int fieldId, List<String> typeFilter) async {
    emit(state.copyWith(screenStatus: ScreenStatus.loading));
     List<Qualification> califications = List.from(state.calificationsList);
     for(var filter in typeFilter){
      final response = await _service.getAllQalificationsByEntity(fieldId, filter); 
      response.fold((l) => null, (r) {
        califications.addAll(r);
      });
    }
    
    emit(state.copyWith(screenStatus: ScreenStatus.loaded, calificationsList: califications));

  }

}
