import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_current_position_usecase.dart';
import 'position_event.dart';
import 'position_state.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  final IGetCurrentPositionUsecase getCurrentPositionUsecase;

  PositionBloc(this.getCurrentPositionUsecase) : super(PositionLoadingState()) {
    on<RequestPosition>(_requesPosition);
  }

  void _requesPosition(
    RequestPosition event,
    Emitter<PositionState> emitter,
  ) async {
    final result = await getCurrentPositionUsecase();
    result.fold(
      (l) => emit(PositionFailureState(l)),
      (r) => emit(PositionFinishedState(r)),
    );
  }
}
