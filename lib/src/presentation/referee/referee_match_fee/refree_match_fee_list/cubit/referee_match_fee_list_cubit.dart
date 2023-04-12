import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ligas_futbol_flutter/src/domain/price/dto/all_my_assets/all_my_assets_dto.dart';
import 'package:ligas_futbol_flutter/src/domain/price/service/i_price_service.dart';
import '../../../../../core/enums.dart';

part 'referee_match_fee_list_state.dart';

@injectable
class RefereeMatchFeeListCubit extends Cubit<RefereeMatchFeeListState> {
  RefereeMatchFeeListCubit(this._priceService) 
      : super(const RefereeMatchFeeListState());
  
  final IPriceService _priceService;

  Future<void> loadFeeList({required activeId}) async{
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));
    final response = await _priceService.getAllMyAssets(activeId);

    response.fold(
            (l) => emit(
                state.copyWith(
                    screenState: BasicCubitScreenState.error,
                    errorMessage: l.errorMessage,
                )
            ),
            (r){
              emit(state.copyWith(screenState: BasicCubitScreenState.loaded, feeList: r));
            });
  }

  Future<void> deletePrice({required int priceId, required int activeId}) async {
    emit(state.copyWith(screenState: BasicCubitScreenState.loading));

    final response = await _priceService.deletePrice(priceId);
    response.fold(
            (l) => emit(state.copyWith(
                screenState: BasicCubitScreenState.error,
                errorMessage: l.errorMessage),
            ),
            (r) {
              emit(state.copyWith(
                screenState: BasicCubitScreenState.loaded,
              ));
              loadFeeList(activeId: activeId);
    });
  }
}
