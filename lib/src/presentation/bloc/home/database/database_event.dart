import '../../../../domain/entities/location.dart';

abstract class DatabaseEvent {}

class DatabaseInitial extends DatabaseEvent {}

class AddLocation implements DatabaseEvent {
  final Location location;

  AddLocation(this.location);
}

class FeatchLocation implements DatabaseEvent {
  final String uid;

  FeatchLocation(this.uid);
}
