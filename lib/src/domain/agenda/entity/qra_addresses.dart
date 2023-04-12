import 'package:equatable/equatable.dart';
import 'package:ligas_futbol_flutter/src/domain/agenda/entity/qra_asset.dart';

class QraAddresses extends Equatable {
     const QraAddresses({
        required this.activeId,
        required this.addressId,
        this.addressLine1,
        this.addressLine2,
        required this.addressName,
        required this.addressReference,
        required this.addressType,
        required this.city,
        required this.countryCode,
        required this.county,
        required this.enabledFlag,
         this.globalFlag,
        required this.latitude,
        required this.length,
        required this.postalCode,
        required this.state,
        required this.town,
    });

    static const empty = QraAddresses(
      activeId: QraAsset.empty,
      addressId: 0,
      addressLine1: '',
      addressName: '',
      addressReference: '',
      addressType: '',
      city: '',
      countryCode: '',
      county: '',
      enabledFlag: '',
      latitude: '',
      length: '',
      postalCode: '',
      state: '',
      town: '',
    );

  bool get isEmpty => this == QraAddresses.empty;

  bool get isNotEmpty => this != QraAddresses.empty;

    final QraAsset? activeId;
    final int? addressId;
    final String? addressLine1;
    final String? addressLine2;
    final String? addressName;
    final String? addressReference;
    final String? addressType;
    final String? city;
    final String? countryCode;
    final String? county;
    final String? enabledFlag;
    final String? globalFlag;
    final String? latitude;
    final String? length;
    final String? postalCode;
    final String? state;
    final String? town;

    QraAddresses copyWith({
        QraAsset? activeId,
        int? addressId,
        String? addressLine1,
        String? addressLine2,
        String? addressName,
        String? addressReference,
        String? addressType,
        String? city,
        String? countryCode,
        String? county,
        String? enabledFlag,
        String? globalFlag,
        String? latitude,
        String? length,
        String? postalCode,
        String? state,
        String? town,
    }) {
        return QraAddresses(
            activeId: activeId ?? this.activeId,
            addressId: addressId ?? this.addressId,
            addressLine1: addressLine1 ?? this.addressLine1,
            addressLine2: addressLine2 ?? this.addressLine2,
            addressName: addressName ?? this.addressName,
            addressReference: addressReference ?? this.addressReference,
            addressType: addressType ?? this.addressType,
            city: city ?? this.city,
            countryCode: countryCode ?? this.countryCode,
            county: county ?? this.county,
            enabledFlag: enabledFlag ?? this.enabledFlag,
            globalFlag: globalFlag ?? this.globalFlag,
            latitude: latitude ?? this.latitude,
            length: length ?? this.length,
            postalCode: postalCode ?? this.postalCode,
            state: state ?? this.state,
            town: town ?? this.town,
        );
    }

    factory QraAddresses.fromJson(Map<String, dynamic> json){ 
        return QraAddresses(
            activeId: json["activeId"] == null ? null : QraAsset.fromJson(json["activeId"]),
            addressId: json["addressId"],
            addressLine1: json["addressLine1"],
            addressLine2: json["addressLine2"],
            addressName: json["addressName"],
            addressReference: json["addressReference"],
            addressType: json["addressType"],
            city: json["city"],
            countryCode: json["countryCode"],
            county: json["county"],
            enabledFlag: json["enabledFlag"],
            globalFlag: json["globalFlag"],
            latitude: json["latitude"],
            length: json["length"],
            postalCode: json["postalCode"],
            state: json["state"],
            town: json["town"],
        );
    }

    Map<String, dynamic> toJson() => {
        "activeId": activeId?.toJson(),
        "addressId": addressId,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "addressName": addressName,
        "addressReference": addressReference,
        "addressType": addressType,
        "city": city,
        "countryCode": countryCode,
        "county": county,
        "enabledFlag": enabledFlag,
        "globalFlag": globalFlag,
        "latitude": latitude,
        "length": length,
        "postalCode": postalCode,
        "state": state,
        "town": town,
    };

    @override
    String toString(){
        return "$activeId, $addressId, $addressLine1, $addressLine2, $addressName, $addressReference, $addressType, $city, $countryCode, $county, $enabledFlag, $globalFlag, $latitude, $length, $postalCode, $state, $town, ";
    }

    @override
    List<Object?> get props => [
    activeId, addressId, addressLine1, addressLine2, addressName, addressReference, addressType, city, countryCode, county, enabledFlag, globalFlag, latitude, length, postalCode, state, town, ];
}