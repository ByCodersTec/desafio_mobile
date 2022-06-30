import 'package:desafio_mobile/src/domain/entities/location.dart';

abstract class ISaveBankLocationDatasource {
  Future<int> saveLocation(Location location);
}
