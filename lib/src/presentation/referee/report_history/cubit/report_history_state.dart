part of 'report_history_cubit.dart';

class ReportHistoryState extends Equatable {
  final List<RefereeMatchDTO> reportList;
  final RefereeMatchDTO selectedReport;
  final String? errorMessage;
  final BasicCubitScreenState screenState;

  const ReportHistoryState({
    this.reportList = const [],
    this.selectedReport = RefereeMatchDTO.empty,
    this.errorMessage,
    this.screenState = BasicCubitScreenState.initial,
  });

  ReportHistoryState copyWith({
    List<RefereeMatchDTO>? reportList,
    RefereeMatchDTO? selectedReport,
    String? errorMessage,
    BasicCubitScreenState? screenState,
  }) {
    return ReportHistoryState(
      reportList: reportList ?? this.reportList,
      selectedReport: selectedReport ?? this.selectedReport,
      errorMessage: errorMessage ?? this.errorMessage,
      screenState: screenState ?? this.screenState,
    );
  }

  @override
  List<Object?> get props => [
        reportList,
        selectedReport,
        screenState,
      ];
}
