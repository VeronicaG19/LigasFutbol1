part of 'lm_request_cubit.dart';

class LmRequestState extends Equatable {
  const LmRequestState({
    this.adminRequestList = const [],
    this.refereeRequestList = const [],
    this.tournamentList = const [],
    this.categoryList = const [],
    this.notificationCounterRL = 0,
    this.notificationCounterRTS = 0,
    this.notificationCounterRTR = 0,
    this.notificationCounterRRS = 0,
    this.notificationCounterRRR = 0,
    this.currentRequestType = LMRequestType.league,
    this.screenState = BasicCubitScreenState.initial,
    this.requestStatus = 0,
    this.comment = '',
    this.selectedTeam = Team.empty,
    this.representative = Person.empty,
    this.errorMessage,
  });

  final List<UserRequests> adminRequestList;
  final List<UserRequests> refereeRequestList;
  final List<UserRequests> tournamentList;
  final List<Category> categoryList;
  final int notificationCounterRL;
  final int notificationCounterRTS;
  final int notificationCounterRTR;
  final int notificationCounterRRS;
  final int notificationCounterRRR;
  final BasicCubitScreenState screenState;
  final LMRequestType currentRequestType;
  final int requestStatus;
  final String comment;
  final Person representative;
  final Team selectedTeam;
  final String? errorMessage;

  LmRequestState copyWith({
    List<UserRequests>? adminRequestList,
    List<UserRequests>? refereeRequestList,
    List<UserRequests>? tournamentList,
    List<Category>? categoryList,
    int? notificationCounterRL,
    int? notificationCounterRTS,
    int? notificationCounterRTR,
    int? notificationCounterRRS,
    int? notificationCounterRRR,
    BasicCubitScreenState? screenState,
    LMRequestType? currentRequestType,
    int? requestStatus,
    String? comment,
    Team? selectedTeam,
    Person? representative,
    String? errorMessage,
  }) {
    return LmRequestState(
      adminRequestList: adminRequestList ?? this.adminRequestList,
      refereeRequestList: refereeRequestList ?? this.refereeRequestList,
      tournamentList: tournamentList ?? this.tournamentList,
      categoryList: categoryList ?? this.categoryList,
      notificationCounterRL:
          notificationCounterRL ?? this.notificationCounterRL,
      notificationCounterRTS:
          notificationCounterRTS ?? this.notificationCounterRTS,
      notificationCounterRTR:
          notificationCounterRTR ?? this.notificationCounterRTR,
      notificationCounterRRS:
          notificationCounterRRS ?? this.notificationCounterRRS,
      notificationCounterRRR:
          notificationCounterRRR ?? this.notificationCounterRRR,
      screenState: screenState ?? this.screenState,
      currentRequestType: currentRequestType ?? this.currentRequestType,
      representative: representative ?? this.representative,
      comment: comment ?? this.comment,
      selectedTeam: selectedTeam ?? this.selectedTeam,
      requestStatus: requestStatus ?? this.requestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        adminRequestList,
        refereeRequestList,
        tournamentList,
        screenState,
        comment,
        categoryList,
        currentRequestType,
        representative,
        requestStatus,
        selectedTeam,
        notificationCounterRL,
        notificationCounterRTS,
        notificationCounterRTR,
        notificationCounterRRS,
        notificationCounterRRR,
      ];
}
