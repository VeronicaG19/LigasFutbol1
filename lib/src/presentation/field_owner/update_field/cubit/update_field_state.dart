part of 'update_field_cubit.dart';

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

class UpdateFieldState extends Equatable {
  final String? errorMessage;
  final Field detailField;
  final ScreenStatus screenStatus;
  final List<LookUpValue> lookUpValues;
  final LookUpValue lookupSelect;
  final ApiHereResponseAddresses apiHereResponseAddresses;
  final List<Result> addreses;
  final double lat;
  final double leng;
  final List<Marker> allMarkers;
  final QraAddresses qraAddresses;

  const UpdateFieldState(
      {this.errorMessage,
      this.detailField = Field.empty,
      this.screenStatus = ScreenStatus.initial,
      this.lookUpValues = const [],
      this.lookupSelect = LookUpValue.empty,
      this.apiHereResponseAddresses = ApiHereResponseAddresses.empty,
      this.addreses = const [],
      this.lat = 19.4260138,
      this.leng = -99.6389653,
      this.allMarkers = const [],
      this.qraAddresses = QraAddresses.empty});

  UpdateFieldState copyWith(
      {String? errorMessage,
      Field? detailField,
      ScreenStatus? screenStatus,
      List<LookUpValue>? lookUpValues,
      LookUpValue? lookupSelect,
      ApiHereResponseAddresses? apiHereResponseAddresses,
      List<Result>? addreses,
      double? lat,
      double? leng,
      List<Marker>? allMarkers,
      QraAddresses? qraAddresses}) {
    return UpdateFieldState(
        errorMessage: errorMessage ?? this.errorMessage,
        detailField: detailField ?? this.detailField,
        screenStatus: screenStatus ?? this.screenStatus,
        lookUpValues: lookUpValues ?? this.lookUpValues,
        lookupSelect: lookupSelect ?? this.lookupSelect,
        apiHereResponseAddresses:
            apiHereResponseAddresses ?? this.apiHereResponseAddresses,
        addreses: addreses ?? this.addreses,
        lat: lat ?? this.lat,
        leng: leng ?? this.leng,
        allMarkers: allMarkers ?? this.allMarkers,
        qraAddresses: qraAddresses ?? this.qraAddresses);
  }

  @override
  List<Object> get props => [
        screenStatus,
        lookUpValues,
        detailField,
        apiHereResponseAddresses,
        addreses,
        lat,
        leng,
        allMarkers,
        qraAddresses
      ];
}
