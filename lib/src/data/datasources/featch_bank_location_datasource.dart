import '../../external/database/app_database.dart';

abstract class IFeatchBankLocationDatasource {
  Future<UserLocalizationData?> featchLocation(String uid);
}
