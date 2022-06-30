import '../../../../domain/entities/location.dart';
import '../../../../domain/errors/errors.dart';

abstract class DatabaseState {}

class DatabaseInitialState extends DatabaseState {}

class DatabaseLoadingState extends DatabaseState {}

class AddDatabaseFinishedState implements DatabaseState {
  final int? id;

  AddDatabaseFinishedState(this.id);
}

class FeatchDatabaseFinishedState implements DatabaseState {
  final Location? location;

  FeatchDatabaseFinishedState(this.location);
}

class DatabaseFailureState implements DatabaseState {
  final IErrorsException errorException;

  DatabaseFailureState(this.errorException);
}
