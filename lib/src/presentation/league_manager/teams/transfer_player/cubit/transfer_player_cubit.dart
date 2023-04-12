import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'transfer_player_state.dart';

class TransferPlayerCubit extends Cubit<TransferPlayerState> {
  TransferPlayerCubit() : super(TransferPlayerInitial());
}
