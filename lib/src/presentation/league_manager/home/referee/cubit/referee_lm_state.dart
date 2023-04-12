part of 'referee_lm_cubit.dart';

enum ScreenStatus {
  createingReferee,
  selectReferee,
  initial,
  loading,
  loaded,
  error,
  sending,
  success
}

class RefereeLmState extends Equatable {
  final List<RefereeByLeagueDTO> refereetList;
  final RefereeDetailDTO refereeDetailDTO;
  final RatingRefereeDTO ratingRefereeDTO;
  final String? errorMessage;
  final ScreenStatus screenStatus;
  final RefereeName refereeName;
  final RefereeLastName refereeLastName;
  final RefereeEmail refereeEmail;
  final RefereePhone refereePhone;
  final Referee referee;
  final FormzStatus status;
  final VerificationSender verificationSender;
  final VerificationType? verificationType;

  const RefereeLmState({
    this.refereetList = const [],
    this.refereeDetailDTO = RefereeDetailDTO.empty,
    this.ratingRefereeDTO = RatingRefereeDTO.empty,
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
    this.refereeName  = const RefereeName.pure(),
    this.refereeLastName  = const RefereeLastName.pure(),
    this.refereeEmail  = const RefereeEmail.pure(),
    this.refereePhone  = const RefereePhone.pure(),
    this.referee  = Referee.empty,
    this.status = FormzStatus.pure,
    this.verificationSender = const VerificationSender.pure(),
    this.verificationType,
  });

  RefereeLmState copyWith({
    List<RefereeByLeagueDTO>? refereetList,
    RefereeDetailDTO? refereeDetailDTO,
    RatingRefereeDTO? ratingRefereeDTO,
    String? errorMessage,
    ScreenStatus? screenStatus,
    RefereeName? refereeName,
    RefereeLastName? refereeLastName,
    RefereeEmail? refereeEmail,
    RefereePhone? refereePhone,
    Referee? referee,
    FormzStatus? status,
    VerificationSender? verificationSender,
    VerificationType? verificationType,
  }) {
    return RefereeLmState(
      refereetList: refereetList ?? this.refereetList,
      refereeDetailDTO: refereeDetailDTO ?? this.refereeDetailDTO,
      ratingRefereeDTO: ratingRefereeDTO ?? this.ratingRefereeDTO,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
      refereeName : refereeName ?? this.refereeName,
      refereeLastName : refereeLastName ?? this.refereeLastName,
      refereeEmail : refereeEmail ?? this.refereeEmail,
      refereePhone : refereePhone ?? this.refereePhone,
      referee : referee ?? this.referee,
      status : status ?? this.status,
      verificationSender: verificationSender ?? this.verificationSender,
      verificationType: verificationType ?? this.verificationType,
    );
  }



  @override
  List<Object> get props => [
    refereetList,
    screenStatus,
    refereeName,
    refereeLastName,
    refereeEmail,
    refereePhone,
    referee,
    status,
    verificationSender,
  ];

  VerificationType getVerificationType() {
    final phoneRegExp = RegExp(r'^[0-9]{10}');
    if (phoneRegExp.hasMatch(verificationSender.value) &&
        verificationSender.value.length == 10) {
      return VerificationType.phone;
    }
    return VerificationType.email;
  }
}
