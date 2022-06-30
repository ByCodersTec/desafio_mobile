import 'package:dartz/dartz.dart';
import 'package:desafio_mobile/src/data/adapters/position_adapter.dart';
import 'package:desafio_mobile/src/domain/errors/errors.dart';
import 'package:desafio_mobile/src/domain/repositories/position_repository.dart';
import 'package:desafio_mobile/src/domain/usecases/get_current_position_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mocktail/mocktail.dart';

class PositionRepositoryMock extends Mock implements IPositionRepository {}

void main() {
  final repository = PositionRepositoryMock();
  final usecase = GetCurrentPositionUsecase(repository);

  test('should return the current position of the device', () async {
    final position = Position(
      longitude: 123.0,
      latitude: 123.0,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1,
    );
    final positionAdapter = PositionAdapter.fromJson(position);

    when(() => repository.featchPosition()).thenAnswer((_) async => right(positionAdapter));

    final result = await usecase();

    final resultPosition = result.fold(id, id);

    expect(result.fold(id, id), isA<LatLng>());

    expect((resultPosition as LatLng).longitude, 123.0);
  });

  test('should return Failure Exception if you don\'t have permission to access divice location',
      () async {
    const falire = FalireException('Você precisa autorizar o acesso à localização');

    when(() => repository.featchPosition()).thenAnswer((_) async => left(falire));

    final result = await usecase();

    final resultPosition = result.fold(id, id);

    expect(result.fold(id, id), isA<FalireException>());

    expect((resultPosition as FalireException).message,
        'Você precisa autorizar o acesso à localização');
  });
}
