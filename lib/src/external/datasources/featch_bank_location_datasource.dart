import 'package:desafio_mobile/src/data/datasources/featch_bank_location_datasource.dart';
import 'package:desafio_mobile/src/external/database/app_database.dart';

import '../../domain/errors/errors.dart';

class FeatchBankLocationDatasource implements IFeatchBankLocationDatasource {
  final AppDatabase appDatabase;

  FeatchBankLocationDatasource(this.appDatabase);

  @override
  Future<UserLocalizationData?> featchLocation(String uid) async {
    try {
      final result = await appDatabase.localizationDAO.featchLocalization(uid);
      print('result $result');
      return result;
    } catch (e, s) {
      throw FalireException(e.toString(), s);
    }
  }
}
