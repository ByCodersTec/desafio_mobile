import 'package:dartz/dartz.dart';
import 'package:desafio_mobile/src/domain/entities/location.dart';
import 'package:desafio_mobile/src/domain/entities/user.dart';
import 'package:desafio_mobile/src/domain/errors/errors.dart';
import 'package:desafio_mobile/src/domain/repositories/bank_repository.dart';
import 'package:desafio_mobile/src/domain/usecases/featch_bank_location_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LocationRepositoryMock extends Mock implements IBankRepository {}

void main() {
  final repository = LocationRepositoryMock();
  final usecase = FeatchBankLocationUsecase(repository);

  test('should return the last location saved in the database', () async {
    final user = User(uid: 'uid', email: 'email');
    final location = Location(latitude: 123, longitude: 123, user: user);

    when(() => repository.featchLocation(user.uid)).thenAnswer((_) async => right(location));

    final result = await usecase(user.uid);

    expect(result.fold(id, id), isA<Location>());
  });

  test('should return null when it does not have a location saved in the database', () async {
    final user = User(uid: 'uid', email: 'email');

    when(() => repository.featchLocation(user.uid)).thenAnswer((_) async => right(null));

    final result = await usecase(user.uid);

    expect(result.fold(id, id), null);
  });

  test('should return a FalireException for some error in the database query', () async {
    final user = User(uid: 'a', email: '');
    const falire = FalireException('error');

    when(() => repository.featchLocation(user.uid)).thenAnswer((_) async => left(falire));

    final result = await usecase(user.uid);

    expect(result.fold(id, id), isA<FalireException>());
  });
}
