import 'package:geolocator/geolocator.dart';

import '../../domain/errors/errors.dart';

class Localization {
  Future<Position> featchLocalization() async {
    try {
      return await _position();
    } catch (e, s) {
      throw FalireException(e.toString(), s);
    }
  }

  Future<Position> _position() async {
    LocationPermission permission;

    bool ativado = await Geolocator.isLocationServiceEnabled();
    if (!ativado) {
      throw const FalireException('Por favor, habilite a localização no smartphone');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const FalireException('Você precisa autorizar o acesso à localização');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw const FalireException('Você precisa autorizar o acesso à localização');
    }

    return await Geolocator.getCurrentPosition();
  }
}
