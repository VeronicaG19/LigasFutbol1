part of 'rattingfield_cubit.dart';
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


 class RattingfieldState extends Equatable {
   final String? errorMessage;
  final ScreenStatus screenStatus;
  final List<Qualification> calificationsList;

  const RattingfieldState({
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
    this.calificationsList = const [],
  });

  RattingfieldState copyWith({
    String? errorMessage,
    ScreenStatus? screenStatus,
    List<Qualification>? calificationsList,
  }) {
    return RattingfieldState(
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
