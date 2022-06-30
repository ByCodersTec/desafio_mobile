import 'package:desafio_mobile/src/domain/entities/user.dart';

class Location {
  final int? id;
  final double latitude;
  final double longitude;
  final User user;

  Location({
    this.id,
    required this.latitude,
    required this.longitude,
    required this.user,
  });
}
