part of 'myrattings_cubit.dart';
enum ScreenStatus {
  initial,
  loading,
  loaded,
  createdSucces,
  updateSucces,
  deleteSucces,
  error,
  addresGeted,
  addresGeting
}

class MyrattingsState extends Equatable {
  final String? errorMessage;
  final ScreenStatus screenStatus;
  final List<Qualification> calificationsList;

  const MyrattingsState({
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
    this.calificationsList = const [],
  });

  MyrattingsState copyWith({
    String? errorMessage,
    ScreenStatus? screenStatus,
    List<Qualification>? calificationsList,
  }) {
    return MyrattingsState(
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
      calificationsList: calificationsList ?? this.calificationsList,
    );
  }

  @override
  List<Object> get props => [
        screenStatus,
        calificationsList,
      ];
}
