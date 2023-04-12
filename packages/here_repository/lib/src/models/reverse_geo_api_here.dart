import 'package:equatable/equatable.dart';

class ReverseHeoApiHere extends Equatable {
    ReverseHeoApiHere({
        required this.items,
    });

    final List<Item> items;

    ReverseHeoApiHere copyWith({
        List<Item>? items,
    }) {
        return ReverseHeoApiHere(
            items: items ?? this.items,
        );
    }

    factory ReverseHeoApiHere.fromJson(Map<String, dynamic> json){ 
        return ReverseHeoApiHere(
            items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "items": items.map((x) => x?.toJson()).toList(),
    };

    @override
    String toString(){
        return "$items, ";
    }

    @override
    List<Object?> get props => [
    items, ];
}

class Item extends Equatable {
    Item({
        required this.title,
        required this.id,
        required this.resultType,
        required this.houseNumberType,
        required this.address,
        required this.position,
        required this.access,
        required this.distance,
        required this.mapView,
    });

    final String? title;
    final String? id;
    final String? resultType;
    final String? houseNumberType;
    final AddressReverse? address;
    final Position? position;
    final List<Position> access;
    final int? distance;
    final MapViewReverse? mapView;

    Item copyWith({
        String? title,
        String? id,
        String? resultType,
        String? houseNumberType,
        AddressReverse? address,
        Position? position,
        List<Position>? access,
        int? distance,
        MapViewReverse? mapView,
    }) {
        return Item(
            title: title ?? this.title,
            id: id ?? this.id,
            resultType: resultType ?? this.resultType,
            houseNumberType: houseNumberType ?? this.houseNumberType,
            address: address ?? this.address,
            position: position ?? this.position,
            access: access ?? this.access,
            distance: distance ?? this.distance,
            mapView: mapView ?? this.mapView,
        );
    }

    factory Item.fromJson(Map<String, dynamic> json){ 
        return Item(
            title: json["title"],
            id: json["id"],
            resultType: json["resultType"],
            houseNumberType: json["houseNumberType"],
            address: json["address"] == null ? null : AddressReverse.fromJson(json["address"]),
            position: json["position"] == null ? null : Position.fromJson(json["position"]),
            access: json["access"] == null ? [] : List<Position>.from(json["access"]!.map((x) => Position.fromJson(x))),
            distance: json["distance"],
            mapView: json["mapView"] == null ? null : MapViewReverse.fromJson(json["mapView"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "resultType": resultType,
        "houseNumberType": houseNumberType,
        "address": address?.toJson(),
        "position": position?.toJson(),
        "access": access.map((x) => x?.toJson()).toList(),
        "distance": distance,
        "mapView": mapView?.toJson(),
    };

    @override
    String toString(){
        return "$title, $id, $resultType, $houseNumberType, $address, $position, $access, $distance, $mapView, ";
    }

    @override
    List<Object?> get props => [
    title, id, resultType, houseNumberType, address, position, access, distance, mapView, ];
}

class Position extends Equatable {
    Position({
        required this.lat,
        required this.lng,
    });

    final double? lat;
    final double? lng;

    Position copyWith({
        double? lat,
        double? lng,
    }) {
        return Position(
            lat: lat ?? this.lat,
            lng: lng ?? this.lng,
        );
    }

    factory Position.fromJson(Map<String, dynamic> json){ 
        return Position(
            lat: json["lat"],
            lng: json["lng"],
        );
    }

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };

    @override
    String toString(){
        return "$lat, $lng, ";
    }

    @override
    List<Object?> get props => [
    lat, lng, ];
}

class AddressReverse extends Equatable {
    AddressReverse({
        required this.label,
        required this.countryCode,
        required this.countryName,
        required this.stateCode,
        required this.state,
        required this.city,
        required this.district,
        required this.street,
        required this.postalCode,
        required this.houseNumber,
    });

    final String? label;
    final String? countryCode;
    final String? countryName;
    final String? stateCode;
    final String? state;
    final String? city;
    final String? district;
    final String? street;
    final String? postalCode;
    final String? houseNumber;

    AddressReverse copyWith({
        String? label,
        String? countryCode,
        String? countryName,
        String? stateCode,
        String? state,
        String? city,
        String? district,
        String? street,
        String? postalCode,
        String? houseNumber,
    }) {
        return AddressReverse(
            label: label ?? this.label,
            countryCode: countryCode ?? this.countryCode,
            countryName: countryName ?? this.countryName,
            stateCode: stateCode ?? this.stateCode,
            state: state ?? this.state,
            city: city ?? this.city,
            district: district ?? this.district,
            street: street ?? this.street,
            postalCode: postalCode ?? this.postalCode,
            houseNumber: houseNumber ?? this.houseNumber,
        );
    }

    factory AddressReverse.fromJson(Map<String, dynamic> json){ 
        return AddressReverse(
            label: json["label"],
            countryCode: json["countryCode"],
            countryName: json["countryName"],
            stateCode: json["stateCode"],
            state: json["state"],
            city: json["city"],
            district: json["district"],
            street: json["street"],
            postalCode: json["postalCode"],
            houseNumber: json["houseNumber"],
        );
    }

    Map<String, dynamic> toJson() => {
        "label": label,
        "countryCode": countryCode,
        "countryName": countryName,
        "stateCode": stateCode,
        "state": state,
        "city": city,
        "district": district,
        "street": street,
        "postalCode": postalCode,
        "houseNumber": houseNumber,
    };

    @override
    String toString(){
        return "$label, $countryCode, $countryName, $stateCode, $state, $city, $district, $street, $postalCode, $houseNumber, ";
    }

    @override
    List<Object?> get props => [
    label, countryCode, countryName, stateCode, state, city, district, street, postalCode, houseNumber, ];
}

class MapViewReverse extends Equatable {
    MapViewReverse({
        required this.west,
        required this.south,
        required this.east,
        required this.north,
    });

    final double? west;
    final double? south;
    final double? east;
    final double? north;

    MapViewReverse copyWith({
        double? west,
        double? south,
        double? east,
        double? north,
    }) {
        return MapViewReverse(
            west: west ?? this.west,
            south: south ?? this.south,
            east: east ?? this.east,
            north: north ?? this.north,
        );
    }

    factory MapViewReverse.fromJson(Map<String, dynamic> json){ 
        return MapViewReverse(
            west: json["west"],
            south: json["south"],
            east: json["east"],
            north: json["north"],
        );
    }

    Map<String, dynamic> toJson() => {
        "west": west,
        "south": south,
        "east": east,
        "north": north,
    };

    @override
    String toString(){
        return "$west, $south, $east, $north, ";
    }

    @override
    List<Object?> get props => [
    west, south, east, north, ];
}