import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

part 'invitation_state.dart';

@injectable
class InvitationCubit extends Cubit<InvitationState> {
  InvitationCubit() : super(InvitationState());

  Future<void> onSendInvitation() async {}
  void onSelectFromContacts(String value, String name) {}
}
