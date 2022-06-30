import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../domain/errors/errors.dart';

abstract class PositionState {}

class PositionLoadingState extends PositionState {}

class PositionFinishedState implements PositionState {
  final LatLng? position;

  PositionFinishedState(this.position);
}

class PositionFailureState implements PositionState {
  final IErrorsException errorException;

  PositionFailureState(this.errorException);
}
