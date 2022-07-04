// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ylz_consignor_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class AMapLocationData extends DataClass
    implements Insertable<AMapLocationData> {
  final double? accuracy;
  final String? adCode;
  final String? address;
  final double? altitude;
  final double? bearing;
  final String? callbackTime;
  final String? city;
  final String? cityCode;
  final String? country;
  final String? description;
  final String? district;
  final String? latitude;
  final String? locationTime;
  final int? locationType;
  final String? longitude;
  final String? province;
  final double? speed;
  final String? street;
  final String? streetNumber;
  final int? errorCode;
  final String? errorInfo;
  AMapLocationData(
      {this.accuracy,
      this.adCode,
      this.address,
      this.altitude,
      this.bearing,
      this.callbackTime,
      this.city,
      this.cityCode,
      this.country,
      this.description,
      this.district,
      this.latitude,
      this.locationTime,
      this.locationType,
      this.longitude,
      this.province,
      this.speed,
      this.street,
      this.streetNumber,
      this.errorCode,
      this.errorInfo});
  factory AMapLocationData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return AMapLocationData(
      accuracy: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}accuracy']),
      adCode: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}ad_code']),
      address: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}address']),
      altitude: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}altitude']),
      bearing: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}bearing']),
      callbackTime: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}callback_time']),
      city: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}city']),
      cityCode: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}city_code']),
      country: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}country']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      district: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}district']),
      latitude: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}latitude']),
      locationTime: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}location_time']),
      locationType: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}location_type']),
      longitude: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}longitude']),
      province: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}province']),
      speed: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}speed']),
      street: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}street']),
      streetNumber: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}street_number']),
      errorCode: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}error_code']),
      errorInfo: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}error_info']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || accuracy != null) {
      map['accuracy'] = Variable<double?>(accuracy);
    }
    if (!nullToAbsent || adCode != null) {
      map['ad_code'] = Variable<String?>(adCode);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String?>(address);
    }
    if (!nullToAbsent || altitude != null) {
      map['altitude'] = Variable<double?>(altitude);
    }
    if (!nullToAbsent || bearing != null) {
      map['bearing'] = Variable<double?>(bearing);
    }
    if (!nullToAbsent || callbackTime != null) {
      map['callback_time'] = Variable<String?>(callbackTime);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String?>(city);
    }
    if (!nullToAbsent || cityCode != null) {
      map['city_code'] = Variable<String?>(cityCode);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String?>(country);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String?>(description);
    }
    if (!nullToAbsent || district != null) {
      map['district'] = Variable<String?>(district);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<String?>(latitude);
    }
    if (!nullToAbsent || locationTime != null) {
      map['location_time'] = Variable<String?>(locationTime);
    }
    if (!nullToAbsent || locationType != null) {
      map['location_type'] = Variable<int?>(locationType);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<String?>(longitude);
    }
    if (!nullToAbsent || province != null) {
      map['province'] = Variable<String?>(province);
    }
    if (!nullToAbsent || speed != null) {
      map['speed'] = Variable<double?>(speed);
    }
    if (!nullToAbsent || street != null) {
      map['street'] = Variable<String?>(street);
    }
    if (!nullToAbsent || streetNumber != null) {
      map['street_number'] = Variable<String?>(streetNumber);
    }
    if (!nullToAbsent || errorCode != null) {
      map['error_code'] = Variable<int?>(errorCode);
    }
    if (!nullToAbsent || errorInfo != null) {
      map['error_info'] = Variable<String?>(errorInfo);
    }
    return map;
  }

  AMapLocationCompanion toCompanion(bool nullToAbsent) {
    return AMapLocationCompanion(
      accuracy: accuracy == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracy),
      adCode:
          adCode == null && nullToAbsent ? const Value.absent() : Value(adCode),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      altitude: altitude == null && nullToAbsent
          ? const Value.absent()
          : Value(altitude),
      bearing: bearing == null && nullToAbsent
          ? const Value.absent()
          : Value(bearing),
      callbackTime: callbackTime == null && nullToAbsent
          ? const Value.absent()
          : Value(callbackTime),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      cityCode: cityCode == null && nullToAbsent
          ? const Value.absent()
          : Value(cityCode),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      district: district == null && nullToAbsent
          ? const Value.absent()
          : Value(district),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      locationTime: locationTime == null && nullToAbsent
          ? const Value.absent()
          : Value(locationTime),
      locationType: locationType == null && nullToAbsent
          ? const Value.absent()
          : Value(locationType),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      province: province == null && nullToAbsent
          ? const Value.absent()
          : Value(province),
      speed:
          speed == null && nullToAbsent ? const Value.absent() : Value(speed),
      street:
          street == null && nullToAbsent ? const Value.absent() : Value(street),
      streetNumber: streetNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(streetNumber),
      errorCode: errorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(errorCode),
      errorInfo: errorInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(errorInfo),
    );
  }

  factory AMapLocationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return AMapLocationData(
      accuracy: serializer.fromJson<double?>(json['accuracy']),
      adCode: serializer.fromJson<String?>(json['adCode']),
      address: serializer.fromJson<String?>(json['address']),
      altitude: serializer.fromJson<double?>(json['altitude']),
      bearing: serializer.fromJson<double?>(json['bearing']),
      callbackTime: serializer.fromJson<String?>(json['callbackTime']),
      city: serializer.fromJson<String?>(json['city']),
      cityCode: serializer.fromJson<String?>(json['cityCode']),
      country: serializer.fromJson<String?>(json['country']),
      description: serializer.fromJson<String?>(json['description']),
      district: serializer.fromJson<String?>(json['district']),
      latitude: serializer.fromJson<String?>(json['latitude']),
      locationTime: serializer.fromJson<String?>(json['locationTime']),
      locationType: serializer.fromJson<int?>(json['locationType']),
      longitude: serializer.fromJson<String?>(json['longitude']),
      province: serializer.fromJson<String?>(json['province']),
      speed: serializer.fromJson<double?>(json['speed']),
      street: serializer.fromJson<String?>(json['street']),
      streetNumber: serializer.fromJson<String?>(json['streetNumber']),
      errorCode: serializer.fromJson<int?>(json['errorCode']),
      errorInfo: serializer.fromJson<String?>(json['errorInfo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accuracy': serializer.toJson<double?>(accuracy),
      'adCode': serializer.toJson<String?>(adCode),
      'address': serializer.toJson<String?>(address),
      'altitude': serializer.toJson<double?>(altitude),
      'bearing': serializer.toJson<double?>(bearing),
      'callbackTime': serializer.toJson<String?>(callbackTime),
      'city': serializer.toJson<String?>(city),
      'cityCode': serializer.toJson<String?>(cityCode),
      'country': serializer.toJson<String?>(country),
      'description': serializer.toJson<String?>(description),
      'district': serializer.toJson<String?>(district),
      'latitude': serializer.toJson<String?>(latitude),
      'locationTime': serializer.toJson<String?>(locationTime),
      'locationType': serializer.toJson<int?>(locationType),
      'longitude': serializer.toJson<String?>(longitude),
      'province': serializer.toJson<String?>(province),
      'speed': serializer.toJson<double?>(speed),
      'street': serializer.toJson<String?>(street),
      'streetNumber': serializer.toJson<String?>(streetNumber),
      'errorCode': serializer.toJson<int?>(errorCode),
      'errorInfo': serializer.toJson<String?>(errorInfo),
    };
  }

  AMapLocationData copyWith(
          {double? accuracy,
          String? adCode,
          String? address,
          double? altitude,
          double? bearing,
          String? callbackTime,
          String? city,
          String? cityCode,
          String? country,
          String? description,
          String? district,
          String? latitude,
          String? locationTime,
          int? locationType,
          String? longitude,
          String? province,
          double? speed,
          String? street,
          String? streetNumber,
          int? errorCode,
          String? errorInfo}) =>
      AMapLocationData(
        accuracy: accuracy ?? this.accuracy,
        adCode: adCode ?? this.adCode,
        address: address ?? this.address,
        altitude: altitude ?? this.altitude,
        bearing: bearing ?? this.bearing,
        callbackTime: callbackTime ?? this.callbackTime,
        city: city ?? this.city,
        cityCode: cityCode ?? this.cityCode,
        country: country ?? this.country,
        description: description ?? this.description,
        district: district ?? this.district,
        latitude: latitude ?? this.latitude,
        locationTime: locationTime ?? this.locationTime,
        locationType: locationType ?? this.locationType,
        longitude: longitude ?? this.longitude,
        province: province ?? this.province,
        speed: speed ?? this.speed,
        street: street ?? this.street,
        streetNumber: streetNumber ?? this.streetNumber,
        errorCode: errorCode ?? this.errorCode,
        errorInfo: errorInfo ?? this.errorInfo,
      );
  @override
  String toString() {
    return (StringBuffer('AMapLocationData(')
          ..write('accuracy: $accuracy, ')
          ..write('adCode: $adCode, ')
          ..write('address: $address, ')
          ..write('altitude: $altitude, ')
          ..write('bearing: $bearing, ')
          ..write('callbackTime: $callbackTime, ')
          ..write('city: $city, ')
          ..write('cityCode: $cityCode, ')
          ..write('country: $country, ')
          ..write('description: $description, ')
          ..write('district: $district, ')
          ..write('latitude: $latitude, ')
          ..write('locationTime: $locationTime, ')
          ..write('locationType: $locationType, ')
          ..write('longitude: $longitude, ')
          ..write('province: $province, ')
          ..write('speed: $speed, ')
          ..write('street: $street, ')
          ..write('streetNumber: $streetNumber, ')
          ..write('errorCode: $errorCode, ')
          ..write('errorInfo: $errorInfo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        accuracy,
        adCode,
        address,
        altitude,
        bearing,
        callbackTime,
        city,
        cityCode,
        country,
        description,
        district,
        latitude,
        locationTime,
        locationType,
        longitude,
        province,
        speed,
        street,
        streetNumber,
        errorCode,
        errorInfo
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AMapLocationData &&
          other.accuracy == this.accuracy &&
          other.adCode == this.adCode &&
          other.address == this.address &&
          other.altitude == this.altitude &&
          other.bearing == this.bearing &&
          other.callbackTime == this.callbackTime &&
          other.city == this.city &&
          other.cityCode == this.cityCode &&
          other.country == this.country &&
          other.description == this.description &&
          other.district == this.district &&
          other.latitude == this.latitude &&
          other.locationTime == this.locationTime &&
          other.locationType == this.locationType &&
          other.longitude == this.longitude &&
          other.province == this.province &&
          other.speed == this.speed &&
          other.street == this.street &&
          other.streetNumber == this.streetNumber &&
          other.errorCode == this.errorCode &&
          other.errorInfo == this.errorInfo);
}

class AMapLocationCompanion extends UpdateCompanion<AMapLocationData> {
  final Value<double?> accuracy;
  final Value<String?> adCode;
  final Value<String?> address;
  final Value<double?> altitude;
  final Value<double?> bearing;
  final Value<String?> callbackTime;
  final Value<String?> city;
  final Value<String?> cityCode;
  final Value<String?> country;
  final Value<String?> description;
  final Value<String?> district;
  final Value<String?> latitude;
  final Value<String?> locationTime;
  final Value<int?> locationType;
  final Value<String?> longitude;
  final Value<String?> province;
  final Value<double?> speed;
  final Value<String?> street;
  final Value<String?> streetNumber;
  final Value<int?> errorCode;
  final Value<String?> errorInfo;
  const AMapLocationCompanion({
    this.accuracy = const Value.absent(),
    this.adCode = const Value.absent(),
    this.address = const Value.absent(),
    this.altitude = const Value.absent(),
    this.bearing = const Value.absent(),
    this.callbackTime = const Value.absent(),
    this.city = const Value.absent(),
    this.cityCode = const Value.absent(),
    this.country = const Value.absent(),
    this.description = const Value.absent(),
    this.district = const Value.absent(),
    this.latitude = const Value.absent(),
    this.locationTime = const Value.absent(),
    this.locationType = const Value.absent(),
    this.longitude = const Value.absent(),
    this.province = const Value.absent(),
    this.speed = const Value.absent(),
    this.street = const Value.absent(),
    this.streetNumber = const Value.absent(),
    this.errorCode = const Value.absent(),
    this.errorInfo = const Value.absent(),
  });
  AMapLocationCompanion.insert({
    this.accuracy = const Value.absent(),
    this.adCode = const Value.absent(),
    this.address = const Value.absent(),
    this.altitude = const Value.absent(),
    this.bearing = const Value.absent(),
    this.callbackTime = const Value.absent(),
    this.city = const Value.absent(),
    this.cityCode = const Value.absent(),
    this.country = const Value.absent(),
    this.description = const Value.absent(),
    this.district = const Value.absent(),
    this.latitude = const Value.absent(),
    this.locationTime = const Value.absent(),
    this.locationType = const Value.absent(),
    this.longitude = const Value.absent(),
    this.province = const Value.absent(),
    this.speed = const Value.absent(),
    this.street = const Value.absent(),
    this.streetNumber = const Value.absent(),
    this.errorCode = const Value.absent(),
    this.errorInfo = const Value.absent(),
  });
  static Insertable<AMapLocationData> custom({
    Expression<double?>? accuracy,
    Expression<String?>? adCode,
    Expression<String?>? address,
    Expression<double?>? altitude,
    Expression<double?>? bearing,
    Expression<String?>? callbackTime,
    Expression<String?>? city,
    Expression<String?>? cityCode,
    Expression<String?>? country,
    Expression<String?>? description,
    Expression<String?>? district,
    Expression<String?>? latitude,
    Expression<String?>? locationTime,
    Expression<int?>? locationType,
    Expression<String?>? longitude,
    Expression<String?>? province,
    Expression<double?>? speed,
    Expression<String?>? street,
    Expression<String?>? streetNumber,
    Expression<int?>? errorCode,
    Expression<String?>? errorInfo,
  }) {
    return RawValuesInsertable({
      if (accuracy != null) 'accuracy': accuracy,
      if (adCode != null) 'ad_code': adCode,
      if (address != null) 'address': address,
      if (altitude != null) 'altitude': altitude,
      if (bearing != null) 'bearing': bearing,
      if (callbackTime != null) 'callback_time': callbackTime,
      if (city != null) 'city': city,
      if (cityCode != null) 'city_code': cityCode,
      if (country != null) 'country': country,
      if (description != null) 'description': description,
      if (district != null) 'district': district,
      if (latitude != null) 'latitude': latitude,
      if (locationTime != null) 'location_time': locationTime,
      if (locationType != null) 'location_type': locationType,
      if (longitude != null) 'longitude': longitude,
      if (province != null) 'province': province,
      if (speed != null) 'speed': speed,
      if (street != null) 'street': street,
      if (streetNumber != null) 'street_number': streetNumber,
      if (errorCode != null) 'error_code': errorCode,
      if (errorInfo != null) 'error_info': errorInfo,
    });
  }

  AMapLocationCompanion copyWith(
      {Value<double?>? accuracy,
      Value<String?>? adCode,
      Value<String?>? address,
      Value<double?>? altitude,
      Value<double?>? bearing,
      Value<String?>? callbackTime,
      Value<String?>? city,
      Value<String?>? cityCode,
      Value<String?>? country,
      Value<String?>? description,
      Value<String?>? district,
      Value<String?>? latitude,
      Value<String?>? locationTime,
      Value<int?>? locationType,
      Value<String?>? longitude,
      Value<String?>? province,
      Value<double?>? speed,
      Value<String?>? street,
      Value<String?>? streetNumber,
      Value<int?>? errorCode,
      Value<String?>? errorInfo}) {
    return AMapLocationCompanion(
      accuracy: accuracy ?? this.accuracy,
      adCode: adCode ?? this.adCode,
      address: address ?? this.address,
      altitude: altitude ?? this.altitude,
      bearing: bearing ?? this.bearing,
      callbackTime: callbackTime ?? this.callbackTime,
      city: city ?? this.city,
      cityCode: cityCode ?? this.cityCode,
      country: country ?? this.country,
      description: description ?? this.description,
      district: district ?? this.district,
      latitude: latitude ?? this.latitude,
      locationTime: locationTime ?? this.locationTime,
      locationType: locationType ?? this.locationType,
      longitude: longitude ?? this.longitude,
      province: province ?? this.province,
      speed: speed ?? this.speed,
      street: street ?? this.street,
      streetNumber: streetNumber ?? this.streetNumber,
      errorCode: errorCode ?? this.errorCode,
      errorInfo: errorInfo ?? this.errorInfo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accuracy.present) {
      map['accuracy'] = Variable<double?>(accuracy.value);
    }
    if (adCode.present) {
      map['ad_code'] = Variable<String?>(adCode.value);
    }
    if (address.present) {
      map['address'] = Variable<String?>(address.value);
    }
    if (altitude.present) {
      map['altitude'] = Variable<double?>(altitude.value);
    }
    if (bearing.present) {
      map['bearing'] = Variable<double?>(bearing.value);
    }
    if (callbackTime.present) {
      map['callback_time'] = Variable<String?>(callbackTime.value);
    }
    if (city.present) {
      map['city'] = Variable<String?>(city.value);
    }
    if (cityCode.present) {
      map['city_code'] = Variable<String?>(cityCode.value);
    }
    if (country.present) {
      map['country'] = Variable<String?>(country.value);
    }
    if (description.present) {
      map['description'] = Variable<String?>(description.value);
    }
    if (district.present) {
      map['district'] = Variable<String?>(district.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<String?>(latitude.value);
    }
    if (locationTime.present) {
      map['location_time'] = Variable<String?>(locationTime.value);
    }
    if (locationType.present) {
      map['location_type'] = Variable<int?>(locationType.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<String?>(longitude.value);
    }
    if (province.present) {
      map['province'] = Variable<String?>(province.value);
    }
    if (speed.present) {
      map['speed'] = Variable<double?>(speed.value);
    }
    if (street.present) {
      map['street'] = Variable<String?>(street.value);
    }
    if (streetNumber.present) {
      map['street_number'] = Variable<String?>(streetNumber.value);
    }
    if (errorCode.present) {
      map['error_code'] = Variable<int?>(errorCode.value);
    }
    if (errorInfo.present) {
      map['error_info'] = Variable<String?>(errorInfo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AMapLocationCompanion(')
          ..write('accuracy: $accuracy, ')
          ..write('adCode: $adCode, ')
          ..write('address: $address, ')
          ..write('altitude: $altitude, ')
          ..write('bearing: $bearing, ')
          ..write('callbackTime: $callbackTime, ')
          ..write('city: $city, ')
          ..write('cityCode: $cityCode, ')
          ..write('country: $country, ')
          ..write('description: $description, ')
          ..write('district: $district, ')
          ..write('latitude: $latitude, ')
          ..write('locationTime: $locationTime, ')
          ..write('locationType: $locationType, ')
          ..write('longitude: $longitude, ')
          ..write('province: $province, ')
          ..write('speed: $speed, ')
          ..write('street: $street, ')
          ..write('streetNumber: $streetNumber, ')
          ..write('errorCode: $errorCode, ')
          ..write('errorInfo: $errorInfo')
          ..write(')'))
        .toString();
  }
}

class $AMapLocationTable extends AMapLocation
    with TableInfo<$AMapLocationTable, AMapLocationData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $AMapLocationTable(this._db, [this._alias]);
  final VerificationMeta _accuracyMeta = const VerificationMeta('accuracy');
  late final GeneratedColumn<double?> accuracy = GeneratedColumn<double?>(
      'accuracy', aliasedName, true,
      typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _adCodeMeta = const VerificationMeta('adCode');
  late final GeneratedColumn<String?> adCode = GeneratedColumn<String?>(
      'ad_code', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _addressMeta = const VerificationMeta('address');
  late final GeneratedColumn<String?> address = GeneratedColumn<String?>(
      'address', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _altitudeMeta = const VerificationMeta('altitude');
  late final GeneratedColumn<double?> altitude = GeneratedColumn<double?>(
      'altitude', aliasedName, true,
      typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _bearingMeta = const VerificationMeta('bearing');
  late final GeneratedColumn<double?> bearing = GeneratedColumn<double?>(
      'bearing', aliasedName, true,
      typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _callbackTimeMeta =
      const VerificationMeta('callbackTime');
  late final GeneratedColumn<String?> callbackTime = GeneratedColumn<String?>(
      'callback_time', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cityMeta = const VerificationMeta('city');
  late final GeneratedColumn<String?> city = GeneratedColumn<String?>(
      'city', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _cityCodeMeta = const VerificationMeta('cityCode');
  late final GeneratedColumn<String?> cityCode = GeneratedColumn<String?>(
      'city_code', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _countryMeta = const VerificationMeta('country');
  late final GeneratedColumn<String?> country = GeneratedColumn<String?>(
      'country', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _districtMeta = const VerificationMeta('district');
  late final GeneratedColumn<String?> district = GeneratedColumn<String?>(
      'district', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _latitudeMeta = const VerificationMeta('latitude');
  late final GeneratedColumn<String?> latitude = GeneratedColumn<String?>(
      'latitude', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _locationTimeMeta =
      const VerificationMeta('locationTime');
  late final GeneratedColumn<String?> locationTime = GeneratedColumn<String?>(
      'location_time', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _locationTypeMeta =
      const VerificationMeta('locationType');
  late final GeneratedColumn<int?> locationType = GeneratedColumn<int?>(
      'location_type', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _longitudeMeta = const VerificationMeta('longitude');
  late final GeneratedColumn<String?> longitude = GeneratedColumn<String?>(
      'longitude', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _provinceMeta = const VerificationMeta('province');
  late final GeneratedColumn<String?> province = GeneratedColumn<String?>(
      'province', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _speedMeta = const VerificationMeta('speed');
  late final GeneratedColumn<double?> speed = GeneratedColumn<double?>(
      'speed', aliasedName, true,
      typeName: 'REAL', requiredDuringInsert: false);
  final VerificationMeta _streetMeta = const VerificationMeta('street');
  late final GeneratedColumn<String?> street = GeneratedColumn<String?>(
      'street', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _streetNumberMeta =
      const VerificationMeta('streetNumber');
  late final GeneratedColumn<String?> streetNumber = GeneratedColumn<String?>(
      'street_number', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _errorCodeMeta = const VerificationMeta('errorCode');
  late final GeneratedColumn<int?> errorCode = GeneratedColumn<int?>(
      'error_code', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _errorInfoMeta = const VerificationMeta('errorInfo');
  late final GeneratedColumn<String?> errorInfo = GeneratedColumn<String?>(
      'error_info', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        accuracy,
        adCode,
        address,
        altitude,
        bearing,
        callbackTime,
        city,
        cityCode,
        country,
        description,
        district,
        latitude,
        locationTime,
        locationType,
        longitude,
        province,
        speed,
        street,
        streetNumber,
        errorCode,
        errorInfo
      ];
  @override
  String get aliasedName => _alias ?? 'a_map_location';
  @override
  String get actualTableName => 'a_map_location';
  @override
  VerificationContext validateIntegrity(Insertable<AMapLocationData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('accuracy')) {
      context.handle(_accuracyMeta,
          accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta));
    }
    if (data.containsKey('ad_code')) {
      context.handle(_adCodeMeta,
          adCode.isAcceptableOrUnknown(data['ad_code']!, _adCodeMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('altitude')) {
      context.handle(_altitudeMeta,
          altitude.isAcceptableOrUnknown(data['altitude']!, _altitudeMeta));
    }
    if (data.containsKey('bearing')) {
      context.handle(_bearingMeta,
          bearing.isAcceptableOrUnknown(data['bearing']!, _bearingMeta));
    }
    if (data.containsKey('callback_time')) {
      context.handle(
          _callbackTimeMeta,
          callbackTime.isAcceptableOrUnknown(
              data['callback_time']!, _callbackTimeMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    }
    if (data.containsKey('city_code')) {
      context.handle(_cityCodeMeta,
          cityCode.isAcceptableOrUnknown(data['city_code']!, _cityCodeMeta));
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('district')) {
      context.handle(_districtMeta,
          district.isAcceptableOrUnknown(data['district']!, _districtMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('location_time')) {
      context.handle(
          _locationTimeMeta,
          locationTime.isAcceptableOrUnknown(
              data['location_time']!, _locationTimeMeta));
    }
    if (data.containsKey('location_type')) {
      context.handle(
          _locationTypeMeta,
          locationType.isAcceptableOrUnknown(
              data['location_type']!, _locationTypeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('province')) {
      context.handle(_provinceMeta,
          province.isAcceptableOrUnknown(data['province']!, _provinceMeta));
    }
    if (data.containsKey('speed')) {
      context.handle(
          _speedMeta, speed.isAcceptableOrUnknown(data['speed']!, _speedMeta));
    }
    if (data.containsKey('street')) {
      context.handle(_streetMeta,
          street.isAcceptableOrUnknown(data['street']!, _streetMeta));
    }
    if (data.containsKey('street_number')) {
      context.handle(
          _streetNumberMeta,
          streetNumber.isAcceptableOrUnknown(
              data['street_number']!, _streetNumberMeta));
    }
    if (data.containsKey('error_code')) {
      context.handle(_errorCodeMeta,
          errorCode.isAcceptableOrUnknown(data['error_code']!, _errorCodeMeta));
    }
    if (data.containsKey('error_info')) {
      context.handle(_errorInfoMeta,
          errorInfo.isAcceptableOrUnknown(data['error_info']!, _errorInfoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  AMapLocationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return AMapLocationData.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AMapLocationTable createAlias(String alias) {
    return $AMapLocationTable(_db, alias);
  }
}

class YlzLogData extends DataClass implements Insertable<YlzLogData> {
  final int? logTime;
  final String? logTimeFormat;
  final String? userId;
  final String? mobile;
  final String? appVersion;
  final String? buildNumber;
  final String? platform;
  final String? dfp;
  final String? systemVersion;
  final String? brand;
  final String? deviceName;
  final String? fingerprint;
  final String? content;
  final String? source;
  final String? contentType;
  YlzLogData(
      {this.logTime,
      this.logTimeFormat,
      this.userId,
      this.mobile,
      this.appVersion,
      this.buildNumber,
      this.platform,
      this.dfp,
      this.systemVersion,
      this.brand,
      this.deviceName,
      this.fingerprint,
      this.content,
      this.source,
      this.contentType});
  factory YlzLogData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return YlzLogData(
      logTime: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}log_time']),
      logTimeFormat: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}log_time_format']),
      userId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
      mobile: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}mobile']),
      appVersion: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}app_version']),
      buildNumber: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}build_number']),
      platform: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}platform']),
      dfp: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dfp']),
      systemVersion: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}system_version']),
      brand: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}brand']),
      deviceName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}device_name']),
      fingerprint: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}fingerprint']),
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content']),
      source: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}source']),
      contentType: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content_type']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || logTime != null) {
      map['log_time'] = Variable<int?>(logTime);
    }
    if (!nullToAbsent || logTimeFormat != null) {
      map['log_time_format'] = Variable<String?>(logTimeFormat);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String?>(userId);
    }
    if (!nullToAbsent || mobile != null) {
      map['mobile'] = Variable<String?>(mobile);
    }
    if (!nullToAbsent || appVersion != null) {
      map['app_version'] = Variable<String?>(appVersion);
    }
    if (!nullToAbsent || buildNumber != null) {
      map['build_number'] = Variable<String?>(buildNumber);
    }
    if (!nullToAbsent || platform != null) {
      map['platform'] = Variable<String?>(platform);
    }
    if (!nullToAbsent || dfp != null) {
      map['dfp'] = Variable<String?>(dfp);
    }
    if (!nullToAbsent || systemVersion != null) {
      map['system_version'] = Variable<String?>(systemVersion);
    }
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String?>(brand);
    }
    if (!nullToAbsent || deviceName != null) {
      map['device_name'] = Variable<String?>(deviceName);
    }
    if (!nullToAbsent || fingerprint != null) {
      map['fingerprint'] = Variable<String?>(fingerprint);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String?>(content);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String?>(source);
    }
    if (!nullToAbsent || contentType != null) {
      map['content_type'] = Variable<String?>(contentType);
    }
    return map;
  }

  YlzLogCompanion toCompanion(bool nullToAbsent) {
    return YlzLogCompanion(
      logTime: logTime == null && nullToAbsent
          ? const Value.absent()
          : Value(logTime),
      logTimeFormat: logTimeFormat == null && nullToAbsent
          ? const Value.absent()
          : Value(logTimeFormat),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      mobile:
          mobile == null && nullToAbsent ? const Value.absent() : Value(mobile),
      appVersion: appVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(appVersion),
      buildNumber: buildNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(buildNumber),
      platform: platform == null && nullToAbsent
          ? const Value.absent()
          : Value(platform),
      dfp: dfp == null && nullToAbsent ? const Value.absent() : Value(dfp),
      systemVersion: systemVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(systemVersion),
      brand:
          brand == null && nullToAbsent ? const Value.absent() : Value(brand),
      deviceName: deviceName == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceName),
      fingerprint: fingerprint == null && nullToAbsent
          ? const Value.absent()
          : Value(fingerprint),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      source:
          source == null && nullToAbsent ? const Value.absent() : Value(source),
      contentType: contentType == null && nullToAbsent
          ? const Value.absent()
          : Value(contentType),
    );
  }

  factory YlzLogData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return YlzLogData(
      logTime: serializer.fromJson<int?>(json['logTime']),
      logTimeFormat: serializer.fromJson<String?>(json['logTimeFormat']),
      userId: serializer.fromJson<String?>(json['userId']),
      mobile: serializer.fromJson<String?>(json['mobile']),
      appVersion: serializer.fromJson<String?>(json['appVersion']),
      buildNumber: serializer.fromJson<String?>(json['buildNumber']),
      platform: serializer.fromJson<String?>(json['platform']),
      dfp: serializer.fromJson<String?>(json['dfp']),
      systemVersion: serializer.fromJson<String?>(json['systemVersion']),
      brand: serializer.fromJson<String?>(json['brand']),
      deviceName: serializer.fromJson<String?>(json['deviceName']),
      fingerprint: serializer.fromJson<String?>(json['fingerprint']),
      content: serializer.fromJson<String?>(json['content']),
      source: serializer.fromJson<String?>(json['source']),
      contentType: serializer.fromJson<String?>(json['contentType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'logTime': serializer.toJson<int?>(logTime),
      'logTimeFormat': serializer.toJson<String?>(logTimeFormat),
      'userId': serializer.toJson<String?>(userId),
      'mobile': serializer.toJson<String?>(mobile),
      'appVersion': serializer.toJson<String?>(appVersion),
      'buildNumber': serializer.toJson<String?>(buildNumber),
      'platform': serializer.toJson<String?>(platform),
      'dfp': serializer.toJson<String?>(dfp),
      'systemVersion': serializer.toJson<String?>(systemVersion),
      'brand': serializer.toJson<String?>(brand),
      'deviceName': serializer.toJson<String?>(deviceName),
      'fingerprint': serializer.toJson<String?>(fingerprint),
      'content': serializer.toJson<String?>(content),
      'source': serializer.toJson<String?>(source),
      'contentType': serializer.toJson<String?>(contentType),
    };
  }

  YlzLogData copyWith(
          {int? logTime,
          String? logTimeFormat,
          String? userId,
          String? mobile,
          String? appVersion,
          String? buildNumber,
          String? platform,
          String? dfp,
          String? systemVersion,
          String? brand,
          String? deviceName,
          String? fingerprint,
          String? content,
          String? source,
          String? contentType}) =>
      YlzLogData(
        logTime: logTime ?? this.logTime,
        logTimeFormat: logTimeFormat ?? this.logTimeFormat,
        userId: userId ?? this.userId,
        mobile: mobile ?? this.mobile,
        appVersion: appVersion ?? this.appVersion,
        buildNumber: buildNumber ?? this.buildNumber,
        platform: platform ?? this.platform,
        dfp: dfp ?? this.dfp,
        systemVersion: systemVersion ?? this.systemVersion,
        brand: brand ?? this.brand,
        deviceName: deviceName ?? this.deviceName,
        fingerprint: fingerprint ?? this.fingerprint,
        content: content ?? this.content,
        source: source ?? this.source,
        contentType: contentType ?? this.contentType,
      );
  @override
  String toString() {
    return (StringBuffer('YlzLogData(')
          ..write('logTime: $logTime, ')
          ..write('logTimeFormat: $logTimeFormat, ')
          ..write('userId: $userId, ')
          ..write('mobile: $mobile, ')
          ..write('appVersion: $appVersion, ')
          ..write('buildNumber: $buildNumber, ')
          ..write('platform: $platform, ')
          ..write('dfp: $dfp, ')
          ..write('systemVersion: $systemVersion, ')
          ..write('brand: $brand, ')
          ..write('deviceName: $deviceName, ')
          ..write('fingerprint: $fingerprint, ')
          ..write('content: $content, ')
          ..write('source: $source, ')
          ..write('contentType: $contentType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      logTime,
      logTimeFormat,
      userId,
      mobile,
      appVersion,
      buildNumber,
      platform,
      dfp,
      systemVersion,
      brand,
      deviceName,
      fingerprint,
      content,
      source,
      contentType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is YlzLogData &&
          other.logTime == this.logTime &&
          other.logTimeFormat == this.logTimeFormat &&
          other.userId == this.userId &&
          other.mobile == this.mobile &&
          other.appVersion == this.appVersion &&
          other.buildNumber == this.buildNumber &&
          other.platform == this.platform &&
          other.dfp == this.dfp &&
          other.systemVersion == this.systemVersion &&
          other.brand == this.brand &&
          other.deviceName == this.deviceName &&
          other.fingerprint == this.fingerprint &&
          other.content == this.content &&
          other.source == this.source &&
          other.contentType == this.contentType);
}

class YlzLogCompanion extends UpdateCompanion<YlzLogData> {
  final Value<int?> logTime;
  final Value<String?> logTimeFormat;
  final Value<String?> userId;
  final Value<String?> mobile;
  final Value<String?> appVersion;
  final Value<String?> buildNumber;
  final Value<String?> platform;
  final Value<String?> dfp;
  final Value<String?> systemVersion;
  final Value<String?> brand;
  final Value<String?> deviceName;
  final Value<String?> fingerprint;
  final Value<String?> content;
  final Value<String?> source;
  final Value<String?> contentType;
  const YlzLogCompanion({
    this.logTime = const Value.absent(),
    this.logTimeFormat = const Value.absent(),
    this.userId = const Value.absent(),
    this.mobile = const Value.absent(),
    this.appVersion = const Value.absent(),
    this.buildNumber = const Value.absent(),
    this.platform = const Value.absent(),
    this.dfp = const Value.absent(),
    this.systemVersion = const Value.absent(),
    this.brand = const Value.absent(),
    this.deviceName = const Value.absent(),
    this.fingerprint = const Value.absent(),
    this.content = const Value.absent(),
    this.source = const Value.absent(),
    this.contentType = const Value.absent(),
  });
  YlzLogCompanion.insert({
    this.logTime = const Value.absent(),
    this.logTimeFormat = const Value.absent(),
    this.userId = const Value.absent(),
    this.mobile = const Value.absent(),
    this.appVersion = const Value.absent(),
    this.buildNumber = const Value.absent(),
    this.platform = const Value.absent(),
    this.dfp = const Value.absent(),
    this.systemVersion = const Value.absent(),
    this.brand = const Value.absent(),
    this.deviceName = const Value.absent(),
    this.fingerprint = const Value.absent(),
    this.content = const Value.absent(),
    this.source = const Value.absent(),
    this.contentType = const Value.absent(),
  });
  static Insertable<YlzLogData> custom({
    Expression<int?>? logTime,
    Expression<String?>? logTimeFormat,
    Expression<String?>? userId,
    Expression<String?>? mobile,
    Expression<String?>? appVersion,
    Expression<String?>? buildNumber,
    Expression<String?>? platform,
    Expression<String?>? dfp,
    Expression<String?>? systemVersion,
    Expression<String?>? brand,
    Expression<String?>? deviceName,
    Expression<String?>? fingerprint,
    Expression<String?>? content,
    Expression<String?>? source,
    Expression<String?>? contentType,
  }) {
    return RawValuesInsertable({
      if (logTime != null) 'log_time': logTime,
      if (logTimeFormat != null) 'log_time_format': logTimeFormat,
      if (userId != null) 'user_id': userId,
      if (mobile != null) 'mobile': mobile,
      if (appVersion != null) 'app_version': appVersion,
      if (buildNumber != null) 'build_number': buildNumber,
      if (platform != null) 'platform': platform,
      if (dfp != null) 'dfp': dfp,
      if (systemVersion != null) 'system_version': systemVersion,
      if (brand != null) 'brand': brand,
      if (deviceName != null) 'device_name': deviceName,
      if (fingerprint != null) 'fingerprint': fingerprint,
      if (content != null) 'content': content,
      if (source != null) 'source': source,
      if (contentType != null) 'content_type': contentType,
    });
  }

  YlzLogCompanion copyWith(
      {Value<int?>? logTime,
      Value<String?>? logTimeFormat,
      Value<String?>? userId,
      Value<String?>? mobile,
      Value<String?>? appVersion,
      Value<String?>? buildNumber,
      Value<String?>? platform,
      Value<String?>? dfp,
      Value<String?>? systemVersion,
      Value<String?>? brand,
      Value<String?>? deviceName,
      Value<String?>? fingerprint,
      Value<String?>? content,
      Value<String?>? source,
      Value<String?>? contentType}) {
    return YlzLogCompanion(
      logTime: logTime ?? this.logTime,
      logTimeFormat: logTimeFormat ?? this.logTimeFormat,
      userId: userId ?? this.userId,
      mobile: mobile ?? this.mobile,
      appVersion: appVersion ?? this.appVersion,
      buildNumber: buildNumber ?? this.buildNumber,
      platform: platform ?? this.platform,
      dfp: dfp ?? this.dfp,
      systemVersion: systemVersion ?? this.systemVersion,
      brand: brand ?? this.brand,
      deviceName: deviceName ?? this.deviceName,
      fingerprint: fingerprint ?? this.fingerprint,
      content: content ?? this.content,
      source: source ?? this.source,
      contentType: contentType ?? this.contentType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (logTime.present) {
      map['log_time'] = Variable<int?>(logTime.value);
    }
    if (logTimeFormat.present) {
      map['log_time_format'] = Variable<String?>(logTimeFormat.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String?>(userId.value);
    }
    if (mobile.present) {
      map['mobile'] = Variable<String?>(mobile.value);
    }
    if (appVersion.present) {
      map['app_version'] = Variable<String?>(appVersion.value);
    }
    if (buildNumber.present) {
      map['build_number'] = Variable<String?>(buildNumber.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String?>(platform.value);
    }
    if (dfp.present) {
      map['dfp'] = Variable<String?>(dfp.value);
    }
    if (systemVersion.present) {
      map['system_version'] = Variable<String?>(systemVersion.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String?>(brand.value);
    }
    if (deviceName.present) {
      map['device_name'] = Variable<String?>(deviceName.value);
    }
    if (fingerprint.present) {
      map['fingerprint'] = Variable<String?>(fingerprint.value);
    }
    if (content.present) {
      map['content'] = Variable<String?>(content.value);
    }
    if (source.present) {
      map['source'] = Variable<String?>(source.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String?>(contentType.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('YlzLogCompanion(')
          ..write('logTime: $logTime, ')
          ..write('logTimeFormat: $logTimeFormat, ')
          ..write('userId: $userId, ')
          ..write('mobile: $mobile, ')
          ..write('appVersion: $appVersion, ')
          ..write('buildNumber: $buildNumber, ')
          ..write('platform: $platform, ')
          ..write('dfp: $dfp, ')
          ..write('systemVersion: $systemVersion, ')
          ..write('brand: $brand, ')
          ..write('deviceName: $deviceName, ')
          ..write('fingerprint: $fingerprint, ')
          ..write('content: $content, ')
          ..write('source: $source, ')
          ..write('contentType: $contentType')
          ..write(')'))
        .toString();
  }
}

class $YlzLogTable extends YlzLog with TableInfo<$YlzLogTable, YlzLogData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $YlzLogTable(this._db, [this._alias]);
  final VerificationMeta _logTimeMeta = const VerificationMeta('logTime');
  late final GeneratedColumn<int?> logTime = GeneratedColumn<int?>(
      'log_time', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _logTimeFormatMeta =
      const VerificationMeta('logTimeFormat');
  late final GeneratedColumn<String?> logTimeFormat = GeneratedColumn<String?>(
      'log_time_format', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  late final GeneratedColumn<String?> userId = GeneratedColumn<String?>(
      'user_id', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  late final GeneratedColumn<String?> mobile = GeneratedColumn<String?>(
      'mobile', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _appVersionMeta = const VerificationMeta('appVersion');
  late final GeneratedColumn<String?> appVersion = GeneratedColumn<String?>(
      'app_version', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _buildNumberMeta =
      const VerificationMeta('buildNumber');
  late final GeneratedColumn<String?> buildNumber = GeneratedColumn<String?>(
      'build_number', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _platformMeta = const VerificationMeta('platform');
  late final GeneratedColumn<String?> platform = GeneratedColumn<String?>(
      'platform', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _dfpMeta = const VerificationMeta('dfp');
  late final GeneratedColumn<String?> dfp = GeneratedColumn<String?>(
      'dfp', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _systemVersionMeta =
      const VerificationMeta('systemVersion');
  late final GeneratedColumn<String?> systemVersion = GeneratedColumn<String?>(
      'system_version', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _brandMeta = const VerificationMeta('brand');
  late final GeneratedColumn<String?> brand = GeneratedColumn<String?>(
      'brand', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _deviceNameMeta = const VerificationMeta('deviceName');
  late final GeneratedColumn<String?> deviceName = GeneratedColumn<String?>(
      'device_name', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _fingerprintMeta =
      const VerificationMeta('fingerprint');
  late final GeneratedColumn<String?> fingerprint = GeneratedColumn<String?>(
      'fingerprint', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _sourceMeta = const VerificationMeta('source');
  late final GeneratedColumn<String?> source = GeneratedColumn<String?>(
      'source', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _contentTypeMeta =
      const VerificationMeta('contentType');
  late final GeneratedColumn<String?> contentType = GeneratedColumn<String?>(
      'content_type', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        logTime,
        logTimeFormat,
        userId,
        mobile,
        appVersion,
        buildNumber,
        platform,
        dfp,
        systemVersion,
        brand,
        deviceName,
        fingerprint,
        content,
        source,
        contentType
      ];
  @override
  String get aliasedName => _alias ?? 'ylz_log';
  @override
  String get actualTableName => 'ylz_log';
  @override
  VerificationContext validateIntegrity(Insertable<YlzLogData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('log_time')) {
      context.handle(_logTimeMeta,
          logTime.isAcceptableOrUnknown(data['log_time']!, _logTimeMeta));
    }
    if (data.containsKey('log_time_format')) {
      context.handle(
          _logTimeFormatMeta,
          logTimeFormat.isAcceptableOrUnknown(
              data['log_time_format']!, _logTimeFormatMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('mobile')) {
      context.handle(_mobileMeta,
          mobile.isAcceptableOrUnknown(data['mobile']!, _mobileMeta));
    }
    if (data.containsKey('app_version')) {
      context.handle(
          _appVersionMeta,
          appVersion.isAcceptableOrUnknown(
              data['app_version']!, _appVersionMeta));
    }
    if (data.containsKey('build_number')) {
      context.handle(
          _buildNumberMeta,
          buildNumber.isAcceptableOrUnknown(
              data['build_number']!, _buildNumberMeta));
    }
    if (data.containsKey('platform')) {
      context.handle(_platformMeta,
          platform.isAcceptableOrUnknown(data['platform']!, _platformMeta));
    }
    if (data.containsKey('dfp')) {
      context.handle(
          _dfpMeta, dfp.isAcceptableOrUnknown(data['dfp']!, _dfpMeta));
    }
    if (data.containsKey('system_version')) {
      context.handle(
          _systemVersionMeta,
          systemVersion.isAcceptableOrUnknown(
              data['system_version']!, _systemVersionMeta));
    }
    if (data.containsKey('brand')) {
      context.handle(
          _brandMeta, brand.isAcceptableOrUnknown(data['brand']!, _brandMeta));
    }
    if (data.containsKey('device_name')) {
      context.handle(
          _deviceNameMeta,
          deviceName.isAcceptableOrUnknown(
              data['device_name']!, _deviceNameMeta));
    }
    if (data.containsKey('fingerprint')) {
      context.handle(
          _fingerprintMeta,
          fingerprint.isAcceptableOrUnknown(
              data['fingerprint']!, _fingerprintMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('content_type')) {
      context.handle(
          _contentTypeMeta,
          contentType.isAcceptableOrUnknown(
              data['content_type']!, _contentTypeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  YlzLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return YlzLogData.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $YlzLogTable createAlias(String alias) {
    return $YlzLogTable(_db, alias);
  }
}

abstract class _$YLZConsignorDB extends GeneratedDatabase {
  _$YLZConsignorDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $AMapLocationTable aMapLocation = $AMapLocationTable(this);
  late final $YlzLogTable ylzLog = $YlzLogTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [aMapLocation, ylzLog];
}
