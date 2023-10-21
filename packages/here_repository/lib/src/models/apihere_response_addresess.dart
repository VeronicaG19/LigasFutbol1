import 'package:equatable/equatable.dart';

class ApiHereResponseAddresses extends Equatable {
  const ApiHereResponseAddresses({
    this.type,
    this.viewId,
    required this.result,
  });

  static const empty =
      ApiHereResponseAddresses(result: [], type: null, viewId: null);

  final String? type;
  final int? viewId;
  final List<Result> result;

  ApiHereResponseAddresses copyWith({
    String? type,
    int? viewId,
    List<Result>? result,
  }) {
    return ApiHereResponseAddresses(
      type: type ?? this.type,
      viewId: viewId ?? this.viewId,
      result: result ?? this.result,
    );
  }

  factory ApiHereResponseAddresses.fromJson(Map<String, dynamic> json) {
    return ApiHereResponseAddresses(
      type: json["_type"],
      viewId: json["ViewId"],
      result: json["Result"] == null
          ? []
          : List<Result>.from(json["Result"]!.map((x) => Result.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "_type": type,
        "ViewId": viewId,
        "Result": result.map((x) => x.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        type,
        viewId,
        result,
      ];
}

class Result extends Equatable {
  Result({
    required this.relevance,
    required this.matchLevel,
    required this.matchQuality,
    required this.matchType,
    required this.location,
  });

  final double? relevance;
  final String? matchLevel;
  final MatchQuality? matchQuality;
  final String? matchType;
  final Location? location;

  Result copyWith({
    double? relevance,
    String? matchLevel,
    MatchQuality? matchQuality,
    String? matchType,
    Location? location,
  }) {
    return Result(
      relevance: relevance ?? this.relevance,
      matchLevel: matchLevel ?? this.matchLevel,
      matchQuality: matchQuality ?? this.matchQuality,
      matchType: matchType ?? this.matchType,
      location: location ?? this.location,
    );
  }

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      relevance: json["Relevance"],
      matchLevel: json["MatchLevel"],
      matchQuality: json["MatchQuality"] == null
          ? null
          : MatchQuality.fromJson(json["MatchQuality"]),
      matchType: json["MatchType"],
      location:
          json["Location"] == null ? null : Location.fromJson(json["Location"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "Relevance": relevance,
        "MatchLevel": matchLevel,
        "MatchQuality": matchQuality?.toJson(),
        "MatchType": matchType,
        "Location": location?.toJson(),
      };

  @override
  List<Object?> get props => [
        relevance,
        matchLevel,
        matchQuality,
        matchType,
        location,
      ];
}

class Location extends Equatable {
  Location({
    required this.locationId,
    required this.locationType,
    required this.displayPosition,
    required this.navigationPosition,
    required this.mapView,
    required this.address,
  });

  final String? locationId;
  final String? locationType;
  final DisplayPosition? displayPosition;
  final List<DisplayPosition> navigationPosition;
  final MapView? mapView;
  final Address? address;

  Location copyWith({
    String? locationId,
    String? locationType,
    DisplayPosition? displayPosition,
    List<DisplayPosition>? navigationPosition,
    MapView? mapView,
    Address? address,
  }) {
    return Location(
      locationId: locationId ?? this.locationId,
      locationType: locationType ?? this.locationType,
      displayPosition: displayPosition ?? this.displayPosition,
      navigationPosition: navigationPosition ?? this.navigationPosition,
      mapView: mapView ?? this.mapView,
      address: address ?? this.address,
    );
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      locationId: json["LocationId"],
      locationType: json["LocationType"],
      displayPosition: json["DisplayPosition"] == null
          ? null
          : DisplayPosition.fromJson(json["DisplayPosition"]),
      navigationPosition: json["NavigationPosition"] == null
          ? []
          : List<DisplayPosition>.from(json["NavigationPosition"]!
              .map((x) => DisplayPosition.fromJson(x))),
      mapView:
          json["MapView"] == null ? null : MapView.fromJson(json["MapView"]),
      address:
          json["Address"] == null ? null : Address.fromJson(json["Address"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "LocationId": locationId,
        "LocationType": locationType,
        "DisplayPosition": displayPosition?.toJson(),
        "NavigationPosition":
            navigationPosition.map((x) => x.toJson()).toList(),
        "MapView": mapView?.toJson(),
        "Address": address?.toJson(),
      };

  @override
  List<Object?> get props => [
        locationId,
        locationType,
        displayPosition,
        navigationPosition,
        mapView,
        address,
      ];
}

class Address extends Equatable {
  Address({
    required this.label,
    required this.country,
    required this.state,
    required this.city,
    required this.district,
    required this.street,
    required this.houseNumber,
    required this.postalCode,
    required this.additionalData,
  });

  final String? label;
  final String? country;
  final String? state;
  final String? city;
  final String? district;
  final String? street;
  final String? houseNumber;
  final String? postalCode;
  final List<AdditionalDatum> additionalData;

  Address copyWith({
    String? label,
    String? country,
    String? state,
    String? city,
    String? district,
    String? street,
    String? houseNumber,
    String? postalCode,
    List<AdditionalDatum>? additionalData,
  }) {
    return Address(
      label: label ?? this.label,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      district: district ?? this.district,
      street: street ?? this.street,
      houseNumber: houseNumber ?? this.houseNumber,
      postalCode: postalCode ?? this.postalCode,
      additionalData: additionalData ?? this.additionalData,
    );
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      label: json["Label"],
      country: json["Country"],
      state: json["State"],
      city: json["City"],
      district: json["District"],
      street: json["Street"],
      houseNumber: json["HouseNumber"],
      postalCode: json["PostalCode"],
      additionalData: json["AdditionalData"] == null
          ? []
          : List<AdditionalDatum>.from(
              json["AdditionalData"]!.map((x) => AdditionalDatum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "Label": label,
        "Country": country,
        "State": state,
        "City": city,
        "District": district,
        "Street": street,
        "HouseNumber": houseNumber,
        "PostalCode": postalCode,
        "AdditionalData": additionalData.map((x) => x.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        label,
        country,
        state,
        city,
        district,
        street,
        houseNumber,
        postalCode,
        additionalData,
      ];
}

class AdditionalDatum extends Equatable {
  AdditionalDatum({
    required this.value,
    required this.key,
  });

  final String? value;
  final String? key;

  AdditionalDatum copyWith({
    String? value,
    String? key,
  }) {
    return AdditionalDatum(
      value: value ?? this.value,
      key: key ?? this.key,
    );
  }

  factory AdditionalDatum.fromJson(Map<String, dynamic> json) {
    return AdditionalDatum(
      value: json["value"],
      key: json["key"],
    );
  }

  Map<String, dynamic> toJson() => {
        "value": value,
        "key": key,
      };

  @override
  List<Object?> get props => [
        value,
        key,
      ];
}

class DisplayPosition extends Equatable {
  DisplayPosition({
    required this.latitude,
    required this.longitude,
  });

  final double? latitude;
  final double? longitude;

  DisplayPosition copyWith({
    double? latitude,
    double? longitude,
  }) {
    return DisplayPosition(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  factory DisplayPosition.fromJson(Map<String, dynamic> json) {
    return DisplayPosition(
      latitude: json["Latitude"],
      longitude: json["Longitude"],
    );
  }

  Map<String, dynamic> toJson() => {
        "Latitude": latitude,
        "Longitude": longitude,
      };

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}

class MapView extends Equatable {
  MapView({
    required this.topLeft,
    required this.bottomRight,
  });

  final DisplayPosition? topLeft;
  final DisplayPosition? bottomRight;

  MapView copyWith({
    DisplayPosition? topLeft,
    DisplayPosition? bottomRight,
  }) {
    return MapView(
      topLeft: topLeft ?? this.topLeft,
      bottomRight: bottomRight ?? this.bottomRight,
    );
  }

  factory MapView.fromJson(Map<String, dynamic> json) {
    return MapView(
      topLeft: json["TopLeft"] == null
          ? null
          : DisplayPosition.fromJson(json["TopLeft"]),
      bottomRight: json["BottomRight"] == null
          ? null
          : DisplayPosition.fromJson(json["BottomRight"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "TopLeft": topLeft?.toJson(),
        "BottomRight": bottomRight?.toJson(),
      };

  @override
  List<Object?> get props => [
        topLeft,
        bottomRight,
      ];
}

class MatchQuality extends Equatable {
  MatchQuality({
    required this.street,
    required this.houseNumber,
  });

  final List<double> street;
  final double? houseNumber;

  MatchQuality copyWith({
    List<double>? street,
    double? houseNumber,
  }) {
    return MatchQuality(
      street: street ?? this.street,
      houseNumber: houseNumber ?? this.houseNumber,
    );
  }

  factory MatchQuality.fromJson(Map<String, dynamic> json) {
    return MatchQuality(
      street: json["Street"] == null
          ? []
          : List<double>.from(json["Street"]!.map((x) => x)),
      houseNumber: json["HouseNumber"],
    );
  }

  Map<String, dynamic> toJson() => {
        "Street": street.map((x) => x).toList(),
        "HouseNumber": houseNumber,
      };

  @override
  List<Object?> get props => [
        street,
        houseNumber,
      ];
}
