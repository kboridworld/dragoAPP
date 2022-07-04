import 'package:moor/moor.dart';

class AMapLocation extends Table {
  RealColumn get accuracy => real().nullable()();
  TextColumn get adCode => text().nullable()();
  TextColumn get address => text().nullable()();
  RealColumn get altitude => real().nullable()();
  RealColumn get bearing => real().nullable()();
  TextColumn get callbackTime => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get cityCode => text().nullable()();
  TextColumn get country => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get district => text().nullable()();
  TextColumn get latitude => text().nullable()();
  TextColumn get locationTime => text().nullable()();
  IntColumn get locationType => integer().nullable()();
  TextColumn get longitude => text().nullable()();
  TextColumn get province => text().nullable()();
  RealColumn get speed => real().nullable()();
  TextColumn get street => text().nullable()();
  TextColumn get streetNumber => text().nullable()();
}
