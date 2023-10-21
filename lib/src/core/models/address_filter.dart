import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class AddressFilter extends Equatable {
  final String? county;
  final String? countryCode;
  final String? state;
  final String? city;
  final String? town;
  final String? postalCode;
  final String? addressDescription;
  final DateTime? matchDate;
  final DateTime? matchHour;
  final String? latitude;
  final String? longitude;
  final double? radius;
  final int? leagueId;
  final int? status;

  const AddressFilter(
      {this.county,
      this.countryCode,
      this.state,
      this.city,
      this.town,
      this.postalCode,
      this.addressDescription,
      this.matchDate,
      this.matchHour,
      this.latitude,
      this.longitude,
      this.radius,
      this.leagueId,
      this.status});

  AddressFilter copyWith(
      {String? county,
      String? countryCode,
      String? state,
      String? city,
      String? town,
      String? postalCode,
      String? addressDescription,
      DateTime? matchDate,
      DateTime? matchHour,
      String? latitude,
      String? longitude,
      double? radius,
      int? leagueId,
      int? status}) {
    return AddressFilter(
        county: county ?? this.county,
        countryCode: countryCode ?? this.countryCode,
        state: state ?? this.state,
        city: city ?? this.city,
        town: town ?? this.town,
        postalCode: postalCode ?? this.postalCode,
        addressDescription: addressDescription ?? this.addressDescription,
        matchDate: matchDate ?? this.matchDate,
        matchHour: matchHour ?? this.matchHour,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        radius: radius ?? this.radius,
        leagueId: leagueId ?? this.leagueId,
        status: status ?? this.status);
  }

  Map<String, dynamic> toMap() {
    final params = <String, dynamic>{};
    if (state != null && state!.isNotEmpty) {
      params.addAll({'state': state});
    }
    if (matchDate != null) {
      params.addAll(
          {'matchDate': DateFormat('yyyy/MM/dd HH:mm:ss').format(matchDate!)});
    }
    if (matchHour != null) {
      params.addAll(
          {'matchHour': DateFormat('yyyy/MM/dd HH:mm:ss').format(matchHour!)});
    }
    if (county != null) {
      params.addAll({'county': state});
    }
    if (latitude != null) {
      params.addAll({'latitude': latitude});
    }
    if (longitude != null) {
      params.addAll({'longitude': longitude});
    }
    if (radius != null) {
      params.addAll({'radius': radius});
    }
    if (leagueId != null) {
      params.addAll({'leagueId': leagueId});
    }
    if (status != null) {
      params.addAll({'status': status});
    }
    return params;
  }

  @override
  List<Object?> get props => [
        county,
        countryCode,
        state,
        city,
        town,
        postalCode,
        addressDescription,
        matchDate,
        matchHour,
        latitude,
        longitude,
        radius,
        leagueId,
        status
      ];
}
