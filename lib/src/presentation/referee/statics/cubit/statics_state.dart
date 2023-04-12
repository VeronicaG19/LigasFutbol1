part of 'statics_cubit.dart';

class StaticsState extends Equatable {
  final List<RefereeStatics> refereeStatics;
  final List<CountEventTournament> events;
  final List<Category> categories;
  final List<Tournament> tournaments;
  final Category selectedCategory;
  final Tournament selectedTournament;
  final BasicCubitScreenState screenState;
  final String? errorMessage;

  const StaticsState({
    this.refereeStatics = const [],
    this.categories = const [],
    this.tournaments = const [],
    this.events = const [],
    this.selectedCategory = Category.empty,
    this.selectedTournament = Tournament.empty,
    this.screenState = BasicCubitScreenState.initial,
    this.errorMessage,
  });

  StaticsState copyWith({
    List<RefereeStatics>? refereeStatics,
    List<Category>? categories,
    List<Tournament>? tournaments,
    List<CountEventTournament>? events,
    Category? selectedCategory,
    Tournament? selectedTournament,
    BasicCubitScreenState? screenState,
    String? errorMessage,
  }) {
    return StaticsState(
      refereeStatics: refereeStatics ?? this.refereeStatics,
      categories: categories ?? this.categories,
      tournaments: tournaments ?? this.tournaments,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedTournament: selectedTournament ?? this.selectedTournament,
      events: events ?? this.events,
      screenState: screenState ?? this.screenState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        refereeStatics,
        categories,
        tournaments,
        selectedCategory,
        events,
        selectedTournament,
        screenState,
      ];
}
