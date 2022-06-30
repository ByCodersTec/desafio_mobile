import 'package:desafio_mobile/src/data/datasources/get_current_position_datasource.dart';
import 'package:desafio_mobile/src/data/repositories/position_repository.dart';
import 'package:desafio_mobile/src/domain/errors/errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mocktail/mocktail.dart';

class GetCurrentPositionDatasourceMock extends Mock implements IGetCurrentPositionDatasource {}

void main() {
  final IGetCurrentPositionDatasource getCurrentPosition = GetCurrentPositionDatasourceMock();

  final repository = PositionRepository(getCurrentPosition);

  test('should return a Position with the device\'s location', () async {
    final position = Position(
      longitude: 123.0,
      latitude: 90.0,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1,
    );

    when(() => getCurrentPosition.featchLocation()).thenAnswer((_) async => position);

    final result = await repository.featchPosition();

    final resultLocation = result.fold((l) => l, (r) => r);

    expect(resultLocation, isA<LatLng>());

    expect((resultLocation as LatLng).latitude, 90.0);
  });

  test('should return a FalireException if not authorized', () async {
    const falire = FalireException('Você precisa autorizar o acesso à localização');

    when(() => getCurrentPosition.featchLocation()).thenThrow(falire);

    final result = await repository.featchPosition();

    final resultLocation = result.fold((l) => l, (r) => r);

    expect(resultLocation, isA<FalireException>());

    expect((resultLocation as FalireException).message,
        'Você precisa autorizar o acesso à localização');
  });
}
