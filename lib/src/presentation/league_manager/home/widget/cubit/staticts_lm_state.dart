part of 'staticts_lm_cubit.dart';

  enum ScreenStatusA {
    initial,
    loading,
    loaded,
    error,
    sending,
    success
  }

class StatictsLmState extends Equatable {
  final String? errorMessage;
  final ScreenStatusA screenStatus;
  final ResgisterCountInterface detailTournament;
  final ResgisterCountInterface detailCategory;
  final ResgisterCountInterface detailTeam;

  const StatictsLmState({
    this.errorMessage,
    this.screenStatus = ScreenStatusA.initial,
    this.detailTournament = ResgisterCountInterface.empty,
    this.detailCategory = ResgisterCountInterface.empty,
    this.detailTeam = ResgisterCountInterface.empty
  });

StatictsLmState copyWith({
    String? errorMessage,
    ScreenStatusA? screenStatus,
    ResgisterCountInterface? detailTournament,
    ResgisterCountInterface? detailCategory,
    ResgisterCountInterface? detailTeam
  }) {
    return StatictsLmState(
        errorMessage: errorMessage ?? this.errorMessage,
        screenStatus: screenStatus ?? this.screenStatus,
        detailTournament: detailTournament ?? this.detailTournament,
        detailCategory: detailCategory ?? this.detailCategory,
        detailTeam: detailTeam ?? this.detailTeam
    );
  }

  @override
  List<Object> get props => [
    screenStatus,
    detailTournament,
    detailCategory,
    detailTeam
  ];
}