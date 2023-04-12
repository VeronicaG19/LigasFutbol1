part of 'experiences_cubit.dart';

enum ScreenStatus {
  initial,
  loading,
  loaded,
  error,
}

class ExperiencesState extends Equatable {
  final List<Experiences> experiencesList;
  final String? errorMessage;
  final ScreenStatus screenStatus;

  const ExperiencesState({
    this.experiencesList = const [],
    this.errorMessage,
    this.screenStatus = ScreenStatus.initial,
  });

  ExperiencesState copyWith({
    List<Experiences>? experiencesList,
    String? errorMessage,
    ScreenStatus? screenStatus,
  }) {
    return ExperiencesState(
      experiencesList: experiencesList ?? this.experiencesList,
      errorMessage: errorMessage ?? this.errorMessage,
      screenStatus: screenStatus ?? this.screenStatus,
    );
  }

  @override
  List<Object> get props => [
        experiencesList,
        screenStatus,
      ];
}
