import 'package:equatable/equatable.dart';

class MapFilterList extends Equatable {
  final int id;
  final String desc;
  final String latitude;
  final String longitude;
  final bool isReferee;
  final String address;

  const MapFilterList({
    required this.desc,
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.isReferee,
    required this.address,
  });

  static const empty = MapFilterList(
      desc: '',
      id: 0,
      latitude: '',
      longitude: '',
      isReferee: false,
      address: '');

  double get getLatitude => double.parse(latitude);
  double get getLongitude => double.parse(longitude);

  @override
  List<Object> get props => [id, latitude, longitude, isReferee, desc, address];
}
