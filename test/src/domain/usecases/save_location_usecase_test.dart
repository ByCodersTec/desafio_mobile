import 'package:dartz/dartz.dart';
import 'package:desafio_mobile/src/domain/entities/location.dart';
import 'package:desafio_mobile/src/domain/entities/user.dart';
import 'package:desafio_mobile/src/domain/errors/errors.dart';
import 'package:desafio_mobile/src/domain/repositories/bank_repository.dart';
import 'package:desafio_mobile/src/domain/usecases/save_bank_location_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LocationRepositoryMock extends Mock implements IBankRepository {}

void main() {
  final repository = LocationRepositoryMock();
  final usecase = SaveBankLocationUsecase(repository);

  test('should return the code of the location saved in the database', () async {
    final user = User(uid: 'uid', email: 'email');
    final location = Location(latitude: 123, longitude: 123, user: user);

    when(() => repository.saveLocation(location)).thenAnswer((_) async => right(1));

    final result = await usecase(location);

    expect(result.fold(id, id), isA<int>());
  });

  test('should return a FalireException if the uid is empty or null', () async {
    final user = User(uid: '', email: 'email');
    final location = Location(latitude: 123, longitude: 123, user: user);
    const falire = FalireException('error');

    when(() => repository.saveLocation(location)).thenAnswer((_) async => left(falire));

    final result = await usecase(location);

    expect(result.fold(id, id), isA<FalireException>());
  });
  test('should return a FalireException if the email is empty or null', () async {
    final user = User(uid: 'a', email: '');
    final location = Location(latitude: 123, longitude: 123, user: user);
    const falire = FalireException('error');

    when(() => repository.saveLocation(location)).thenAnswer((_) async => left(falire));

    final result = await usecase(location);

    expect(result.fold(id, id), isA<FalireException>());
  });
  test('should return a FalireException if latitude is empty or null', () async {
    final user = User(uid: 'a', email: 'a');
    final location = Location(latitude: 0, longitude: 123, user: user);
    const falire = FalireException('error');

    when(() => repository.saveLocation(location)).thenAnswer((_) async => left(falire));

    final result = await usecase(location);

    expect(result.fold(id, id), isA<FalireException>());
  });
  test('should return a FalireException if the longitude is empty or null', () async {
    final user = User(uid: 'a', email: 'a');
    final location = Location(latitude: 123, longitude: 0, user: user);
    const falire = FalireException('error');

    when(() => repository.saveLocation(location)).thenAnswer((_) async => left(falire));

    final result = await usecase(location);

    expect(result.fold(id, id), isA<FalireException>());
  });
}
