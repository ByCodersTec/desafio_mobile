import 'package:geolocator/geolocator.dart';

abstract class IGetCurrentPositionDatasource {
  Future<Position> featchLocation();
}
