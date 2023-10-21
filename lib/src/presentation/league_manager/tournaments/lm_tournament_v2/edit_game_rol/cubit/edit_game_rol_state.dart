part of 'edit_game_rol_cubit.dart';

class EditGameRolState extends Equatable {
  final List<Field> fieldList;
  final List<RefereeByAddress> refereeList;
  final List<MapFilterList> mixedElementsList;
  final List<MapFilterList> addressList;
  final MapFilterList selectedAddress;
  final Field selectedField;
  final RefereeByAddress selectedReferee;
  final BasicCubitScreenState screenState;
  final DateTime? selectedDate;
  final DateTime? selectedHour;
  final String selectedState;
  final bool isMapVisible;
  final bool isMapLoading;
  final double? latitude;
  final double? longitude;
  final String? errorMessage;
  final int? typeStatus;
  final int? leagueId;
  final int? selectedFieldValue;
  final int? selectedRefereeValue;
  final int? selectValue;

  const EditGameRolState(
      {this.fieldList = const [],
      this.refereeList = const [],
      this.mixedElementsList = const [],
      this.addressList = const [],
      this.selectedField = Field.empty,
      this.selectedAddress = MapFilterList.empty,
      this.selectedReferee = RefereeByAddress.empty,
      this.screenState = BasicCubitScreenState.initial,
      this.selectedDate,
      this.selectedHour,
      this.selectedState = '',
      this.errorMessage,
      this.isMapVisible = false,
      this.isMapLoading = false,
      this.latitude = 0,
      this.longitude = 0,
      this.typeStatus,
      this.leagueId,
      this.selectedFieldValue = 0,
      this.selectedRefereeValue = 0,
      this.selectValue = 0});

  EditGameRolState copyWith(
      {List<Field>? fieldList,
      List<RefereeByAddress>? refereeList,
      List<MapFilterList>? mixedElementsList,
      List<MapFilterList>? addressList,
      Field? selectedField,
      MapFilterList? selectedAddress,
      RefereeByAddress? selectedReferee,
      BasicCubitScreenState? screenState,
      DateTime? selectedDate,
      DateTime? selectedHour,
      String? selectedState,
      bool? isMapVisible,
      bool? isMapLoading,
      double? latitude,
      double? longitude,
      String? errorMessage,
      int? leagueId,
      int? selectedFieldValue,
      int? selectedRefereeValue,
      int? selectValue}) {
    return EditGameRolState(
        fieldList: fieldList ?? this.fieldList,
        refereeList: refereeList ?? this.refereeList,
        mixedElementsList: mixedElementsList ?? this.mixedElementsList,
        addressList: addressList ?? this.addressList,
        selectedField: selectedField ?? this.selectedField,
        selectedAddress: selectedAddress ?? this.selectedAddress,
        selectedReferee: selectedReferee ?? this.selectedReferee,
        screenState: screenState ?? this.screenState,
        selectedDate: selectedDate == DateTime(0)
            ? null
            : selectedDate ?? this.selectedDate,
        selectedHour: selectedHour == DateTime(0)
            ? null
            : selectedHour ?? this.selectedHour,
        errorMessage: errorMessage ?? this.errorMessage,
        selectedState: selectedState ?? this.selectedState,
        isMapVisible: isMapVisible ?? this.isMapVisible,
        isMapLoading: isMapLoading ?? this.isMapLoading,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        leagueId: leagueId ?? this.leagueId,
        selectedFieldValue: selectedFieldValue ?? this.selectedFieldValue,
        selectedRefereeValue: selectedRefereeValue ?? this.selectedRefereeValue,
        selectValue: selectValue ?? this.selectValue);
  }

  @override
  List<Object?> get props => [
        fieldList,
        refereeList,
        mixedElementsList,
        addressList,
        selectedAddress,
        selectedField,
        selectedReferee,
        screenState,
        selectedDate,
        selectedHour,
        errorMessage,
        isMapVisible,
        isMapLoading,
        selectedState,
        latitude,
        longitude,
        leagueId,
        selectedFieldValue,
        selectedRefereeValue,
        selectValue
      ];
}
