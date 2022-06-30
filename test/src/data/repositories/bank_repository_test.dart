import 'package:desafio_mobile/src/data/datasources/featch_bank_location_datasource.dart';
import 'package:desafio_mobile/src/data/datasources/save_bank_location_datasource.dart';
import 'package:desafio_mobile/src/data/repositories/bank_repository.dart';
import 'package:desafio_mobile/src/domain/entities/location.dart';
import 'package:desafio_mobile/src/domain/entities/user.dart';
import 'package:desafio_mobile/src/external/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SaveLocationDatasourceMock extends Mock implements ISaveBankLocationDatasource {}

class FeatchLocationDatasourceMock extends Mock implements IFeatchBankLocationDatasource {}

void main() {
  final ISaveBankLocationDatasource saveLocation = SaveLocationDatasourceMock();
  final IFeatchBankLocationDatasource featchLocation = FeatchLocationDatasourceMock();

  final repository = BankRepository(saveLocation, featchLocation);

  test('check if the location has been saved in the bank', () async {
    final user = User(uid: 'uid', email: 'email');
    final location = Location(latitude: 123, longitude: 123, user: user);

    when(() => saveLocation.saveLocation(location)).thenAnswer((_) async => 1);

    final result = await repository.saveLocation(location);

    final resultLocation = result.fold((l) => l, (r) => r);

    expect(resultLocation, isA<int>());

    expect((resultLocation as int), 1);
  });

  test('should return the location saved in the database', () async {
    final user = User(uid: 'uid', email: 'email');
    final userLocalization = UserLocalizationData(
      id: 1,
      uid: 'uid',
      email: 'email',
      latitude: '111',
      longitude: '2222',
    );

    when(() => featchLocation.featchLocation(user.uid)).thenAnswer((_) async => userLocalization);

    final result = await repository.featchLocation(user.uid);

    final resultLocation = result.fold((l) => l, (r) => r);

    expect(resultLocation, isA<Location>());

    expect((resultLocation as Location).user.uid, 'uid');
  });

  test('should return null when not finding the location in the database', () async {
    final user = User(uid: 'uid', email: 'email');

    when(() => featchLocation.featchLocation(user.uid)).thenAnswer((_) async => null);

    final result = await repository.featchLocation(user.uid);

    final resultLocation = result.fold((l) => l, (r) => r);

    expect(resultLocation, null);
  });
}
