part of 'fo_field_detail_cubit.dart';

class FoFieldDetailState extends Equatable {
  final Field field;
  final DateTime? initialDate;
  final DateTime? initialHour;
  final DateTime? endDate;
  final DateTime? endHour;
  final BasicCubitScreenState screenState;
  final String? errorMessage;
  final List<Availability>? availability;

  const FoFieldDetailState(
      {this.screenState = BasicCubitScreenState.initial,
      this.field = Field.empty,
      this.initialDate,
      this.initialHour,
      this.endDate,
      this.endHour,
      this.errorMessage,
      this.availability = const []});

  FoFieldDetailState copyWith({
    List<Field>? fieldList,
    Field? field,
    DateTime? initialDate,
    DateTime? initialHour,
    DateTime? endDate,
    DateTime? endHour,
    BasicCubitScreenState? screenState,
    String? errorMessage,
    List<Availability>? availability,
  }) {
    return FoFieldDetailState(
        field: field ?? this.field,
        initialDate: initialDate ?? this.initialDate,
        initialHour: initialHour ?? this.initialHour,
        endDate: endDate ?? this.endDate,
        endHour: endHour ?? this.endHour,
        screenState: screenState ?? this.screenState,
        errorMessage: errorMessage ?? this.errorMessage,
        availability: availability ?? this.availability);
  }

  @override
  List<Object?> get props => [
        field,
        initialDate,
        initialHour,
        endDate,
        endHour,
        screenState,
        availability
      ];
}
