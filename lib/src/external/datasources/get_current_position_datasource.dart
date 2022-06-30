import 'package:desafio_mobile/src/data/datasources/get_current_position_datasource.dart';
import 'package:geolocator/geolocator.dart';

import '../location_device/localization.dart';

class GetCurrentPositionDatasource implements IGetCurrentPositionDatasource {
  final Localization localization;

  GetCurrentPositionDatasource(this.localization);

  @override
  Future<Position> featchLocation() async {
    final result = await localization.featchLocalization();
    return result;
  }
}
