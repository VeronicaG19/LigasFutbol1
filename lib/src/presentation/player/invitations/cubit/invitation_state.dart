part of 'invitation_cubit.dart';

class InvitationState extends Equatable {
  const InvitationState(
      { //this.invitation ,
      this.status = FormzStatus.pure,
      this.errorMessage});

  InvitationState copyWith({
    //  Invitation? invitation,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return InvitationState(
      //  invitation: invitation ?? this.invitation,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  // final Invitation invitation;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        // invitation,
        status
      ];
}
