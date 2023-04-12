part of 'field_lm_cubit.dart';

enum ScreenStatus {
  createField,
  selectField,
  initial,
  loading,
  loaded,
  error,
  addresGeted,
  addresGeting,
  succes
}

class FieldLmState extends Equatable {
  final List<Field> fieldtList;
  final String? errorMessage;
  final Field detailField;
  final ScreenStatus screenStatus;
  final FieldName fieldName;
  final FieldAddres fieldAddres;
  final FieldImage fieldImage;
  final FieldLength fieldLength;
  final FieldLatitude fieldLatitude;
  final FormzStatus formzStatus;
  final List<LookUpValue> lookUpValues;
  final LookUpValue lookupSelect;
  final Field cteField;

  final bool allFormIsValid;
  final ApiHereResponseAddresses apiHereResponseAddresses;
  final List<Result> addreses;
  final double lat;
  final double leng;
  final List<Marker> allMarkers;

  const FieldLmState({
    this.fieldtList = const [],
    this.errorMessage,
    this.detailField = Field.empty,
    this.screenStatus = ScreenStatus.initial,
    this.fieldName = const FieldName.pure(),
    this.fieldAddres = const FieldAddres.pure(),
    this.fieldImage = const FieldImage.pure(),
    this.fieldLength = const FieldLength.pure(),
    this.fieldLatitude = const FieldLatitude.pure(),
    this.formzStatus = FormzStatus.pure,
    this.lookUpValues = const [],
    this.lookupSelect = LookUpValue.empty,
    this.cteField = Field.empty,
    this.allFormIsValid = false,
    this.apiHereResponseAddresses = ApiHereResponseAddresses.empty,
    this.addreses = const [],
    this.lat = 19.4260138,
    this.leng = -99.6389653,
    this.allMarkers = const [],
  });

  FieldLmState copyWith({
    List<Field>? fieldtList,
    String? errorMessage,
    Field? detailField,
    ScreenStatus? screenStatus,
    FieldName? fieldName,
    FieldAddres? fieldAddres,
    FieldType? fieldType,
    FieldImage? fieldImage,
    FieldLength? fieldLength,
    FieldLatitude? fieldLatitude,
    FormzStatus? formzStatus,
    List<LookUpValue>? lookUpValues,
    LookUpValue? lookupSelect,
    Field? cteField,
    bool? allFormIsValid,
    ApiHereResponseAddresses? apiHereResponseAddresses,
    List<Result>? addreses,
    double? lat,
    double? leng,
    List<Marker>? allMarkers,
  }) {
    return FieldLmState(
      fieldtList: fieldtList ?? this.fieldtList,
      errorMessage: errorMessage ?? this.errorMessage,
      detailField: detailField ?? this.detailField,
      screenStatus: screenStatus ?? this.screenStatus,
      fieldName: fieldName ?? this.fieldName,
      fieldAddres: fieldAddres ?? this.fieldAddres,
      fieldImage: fieldImage ?? this.fieldImage,
      fieldLength: fieldLength ?? this.fieldLength,
      fieldLatitude: fieldLatitude ?? this.fieldLatitude,
      formzStatus: formzStatus ?? this.formzStatus,
      lookUpValues: lookUpValues ?? this.lookUpValues,
      lookupSelect: lookupSelect ?? this.lookupSelect,
      cteField: cteField ?? this.cteField,
      allFormIsValid: allFormIsValid ?? this.allFormIsValid,
      apiHereResponseAddresses:
          apiHereResponseAddresses ?? this.apiHereResponseAddresses,
      addreses: addreses ?? this.addreses,
      lat: lat ?? this.lat,
      leng: leng ?? this.leng,
      allMarkers: allMarkers ?? this.allMarkers,
    );
  }

  @override
  List<Object> get props => [
        fieldtList,
        screenStatus,
        fieldName,
        fieldAddres,
        fieldImage,
        fieldLength,
        fieldLatitude,
        formzStatus,
        lookUpValues,
        cteField,
        allFormIsValid,
        apiHereResponseAddresses,
        addreses,
        lat,
        leng,
        allMarkers,
      ];
}
