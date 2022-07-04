/*
*
* {"callbackTime": "2020-07-21 19:43:35",
 "locationTime":"2020-07-21 19:43:35",
 "locationType":5,
 "latitude":30.590689,
 "longitude":104.085631,
 "accuracy":50.0,
 "altitude":0.0,
 "bearing":0.0,
 "speed":0.0,
 "country":"中国",
 "province":"四川省",
 "city":"成都市",
 "district":"锦江区",
 "street":"三色路",
 "streetNumber":"209-附7号",
 "cityCode":"成都市",
 "adCode":"成都市",
 "address":"四川省成都市锦江区三色路209-附7号靠近成都银行(锦江工业园支行)",
 "description":"在成都银行(锦江工业园支行)附近"}
* */

class AMapLocationEntity {
  double? accuracy;
  String? adCode;
  String? address;
  double? altitude;
  double? bearing;
  String? callbackTime;
  String? city;
  String? cityCode;
  String? country;
  String? description;
  String? district;
  double? latitude;
  String? locationTime;
  int? locationType;
  double? longitude;
  String? province;
  double? speed;
  String? street;
  String? streetNumber;

  AMapLocationEntity(
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
      this.streetNumber});

  factory AMapLocationEntity.fromJson(Map<String, dynamic> json) {
    return AMapLocationEntity(
      accuracy: json['accuracy'],
      adCode: json['adCode'],
      address: json['address'],
      altitude: json['altitude'],
      bearing: json['bearing'],
      callbackTime: json['callbackTime'],
      city: json['city'],
      cityCode: json['cityCode'],
      country: json['country'],
      description: json['description'],
      district: json['district'],
      latitude: json['latitude'],
      locationTime: json['locationTime'],
      locationType: json['locationType'],
      longitude: json['longitude'],
      province: json['province'],
      speed: json['speed'],
      street: json['street'],
      streetNumber: json['streetNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accuracy'] = this.accuracy;
    data['adCode'] = this.adCode;
    data['address'] = this.address;
    data['altitude'] = this.altitude;
    data['bearing'] = this.bearing;
    data['callbackTime'] = this.callbackTime;
    data['city'] = this.city;
    data['cityCode'] = this.cityCode;
    data['country'] = this.country;
    data['description'] = this.description;
    data['district'] = this.district;
    data['latitude'] = this.latitude;
    data['locationTime'] = this.locationTime;
    data['locationType'] = this.locationType;
    data['longitude'] = this.longitude;
    data['province'] = this.province;
    data['speed'] = this.speed;
    data['street'] = this.street;
    data['streetNumber'] = this.streetNumber;
    return data;
  }
}
