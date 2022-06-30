import 'package:dartz/dartz.dart';
import 'package:desafio_mobile/src/domain/entities/location.dart';

import '../errors/errors.dart';
import '../repositories/bank_repository.dart';

abstract class IFeatchBankLocationUsecase {
  Future<Either<IErrorsException, Location?>> call(String uid);
}

class FeatchBankLocationUsecase implements IFeatchBankLocationUsecase {
  final IBankRepository _repository;

  FeatchBankLocationUsecase(this._repository);

  @override
  Future<Either<IErrorsException, Location?>> call(String uid) async {
    final result = await _repository.featchLocation(uid);

    return result;
  }
}
