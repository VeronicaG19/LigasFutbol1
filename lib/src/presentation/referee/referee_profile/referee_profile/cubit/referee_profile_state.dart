part of 'referee_profile_cubit.dart';

enum ScreenStatus { initial, loading, loaded, error, addresGeted, addresGeting }

class RefereeProfileState extends Equatable {
  final SimpleTextValidator address;
  final FormzStatus status;
  final String? errorMessage;
  final Referee referee;
  final ScreenStatus screenStatus;
  final ApiHereResponseAddresses apiHereResponseAddresses;
  final List<Result> addreses;
  final double lat;
  final double leng;
  final List<Marker> allMarkers;
  final QraAddresses qraAddresses;

  const RefereeProfileState(
      {this.address = const SimpleTextValidator.pure(),
      this.status = FormzStatus.pure,
      this.errorMessage,
      this.referee = Referee.empty,
      this.screenStatus = ScreenStatus.initial,
      this.apiHereResponseAddresses = ApiHereResponseAddresses.empty,
      this.addreses = const [],
      this.lat = 0.0,
      this.leng = 0.0,
      this.allMarkers = const [],
      this.qraAddresses = QraAddresses.empty});

  RefereeProfileState copyWith(
      {SimpleTextValidator? address,
      FormzStatus? status,
      String? errorMessage,
      Referee? referee,
      ScreenStatus? screenStatus,
      ApiHereResponseAddresses? apiHereResponseAddresses,
      List<Result>? addreses,
      double? lat,
      double? leng,
      List<Marker>? allMarkers,
      QraAddresses? qraAddresses}) {
    return RefereeProfileState(
        address: address ?? this.address,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        referee: referee ?? this.referee,
        screenStatus: screenStatus ?? this.screenStatus,
        apiHereResponseAddresses:
            apiHereResponseAddresses ?? this.apiHereResponseAddresses,
        addreses: addreses ?? this.addreses,
        lat: lat ?? this.lat,
        leng: leng ?? this.leng,
        allMarkers: allMarkers ?? this.allMarkers,
        qraAddresses: qraAddresses ?? this.qraAddresses);
  }

  @override
  List<Object?> get props => [
        address,
        status,
        errorMessage,
        referee,
        screenStatus,
        apiHereResponseAddresses,
        addreses,
        lat,
        leng,
        allMarkers,
        qraAddresses
      ];
}
