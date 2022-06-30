import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/featch_bank_location_usecase.dart';
import '../../../../domain/usecases/save_bank_location_usecase.dart';
import 'database_event.dart';
import 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final ISaveBankLocationUsecase saveBankLocation;
  final IFeatchBankLocationUsecase featchBankLocation;

  DatabaseBloc(this.saveBankLocation, this.featchBankLocation) : super(DatabaseInitialState()) {
    on<AddLocation>(_addLocation);
    on<FeatchLocation>(_featchLocation);
    on<DatabaseInitial>(_intialState);
  }

  void _intialState(
    DatabaseInitial event,
    Emitter<DatabaseState> emitter,
  ) {
    emit(DatabaseInitialState());
  }

  void _addLocation(
    AddLocation event,
    Emitter<DatabaseState> emitter,
  ) async {
    emit(DatabaseLoadingState());
    final result = await saveBankLocation(event.location);
    result.fold(
      (l) => emit(DatabaseFailureState(l)),
      (r) => emit(AddDatabaseFinishedState(r)),
    );
  }

  void _featchLocation(
    FeatchLocation event,
    Emitter<DatabaseState> emitter,
  ) async {
    emit(DatabaseLoadingState());
    final result = await featchBankLocation(event.uid);
    result.fold(
      (l) => emit(DatabaseFailureState(l)),
      (r) => emit(FeatchDatabaseFinishedState(r)),
    );
  }
}
