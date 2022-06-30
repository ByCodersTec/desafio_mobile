import 'package:dartz/dartz.dart';
import 'package:desafio_mobile/src/domain/entities/location.dart';

import '../errors/errors.dart';
import '../repositories/bank_repository.dart';

abstract class ISaveBankLocationUsecase {
  Future<Either<IErrorsException, int>> call(Location location);
}

class SaveBankLocationUsecase implements ISaveBankLocationUsecase {
  final IBankRepository _repository;

  SaveBankLocationUsecase(this._repository);

  @override
  Future<Either<IErrorsException, int>> call(Location location) async {
    if (location.user.uid.isEmpty || location.user.uid == '') {
      return left(const FalireException('uid is empty or null'));
    }
    if (location.user.email.isEmpty || location.user.email == '') {
      return left(const FalireException('email is empty or null'));
    }
    if (location.latitude == 0) {
      return left(const FalireException('latitude is empty or null'));
    }
    if (location.longitude == 0) {
      return left(const FalireException('longitude is empty or null'));
    }

    final result = await _repository.saveLocation(location);

    return result;
  }
}
