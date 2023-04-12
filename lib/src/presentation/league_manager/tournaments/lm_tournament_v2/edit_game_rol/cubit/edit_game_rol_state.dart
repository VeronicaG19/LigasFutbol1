part of 'edit_game_rol_cubit.dart';

class EditGameRolState extends Equatable {
  final List<Field> fieldList;
  final List<RefereeByAddress> refereeList;
  final Field selectedField;
  final RefereeByAddress selectedReferee;
  final BasicCubitScreenState screenState;
  final DateTime? selectedDate;
  final DateTime? selectedHour;
  final String? selectedState;
  final String? errorMessage;

  const EditGameRolState({
    this.fieldList = const [],
    this.refereeList = const [],
    this.selectedField = Field.empty,
    this.selectedReferee = RefereeByAddress.empty,
    this.screenState = BasicCubitScreenState.initial,
    this.selectedDate,
    this.selectedHour,
    this.selectedState,
    this.errorMessage,
  });

  EditGameRolState copyWith({
    List<Field>? fieldList,
    List<RefereeByAddress>? refereeList,
    Field? selectedField,
    RefereeByAddress? selectedReferee,
    BasicCubitScreenState? screenState,
    DateTime? selectedDate,
    DateTime? selectedHour,
    String? selectedState,
    String? errorMessage,
  }) {
    return EditGameRolState(
      fieldList: fieldList ?? this.fieldList,
      refereeList: refereeList ?? this.refereeList,
      selectedField: selectedField ?? this.selectedField,
      selectedReferee: selectedReferee ?? this.selectedReferee,
      screenState: screenState ?? this.screenState,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedHour: selectedHour ?? this.selectedHour,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedState: selectedState ?? this.selectedState,
    );
  }

  @override
  List<Object?> get props => [
        fieldList,
        refereeList,
        selectedField,
        selectedReferee,
        screenState,
        selectedDate,
        selectedHour,
        errorMessage,
        selectedState
      ];
}
