import 'package:dartz/dartz.dart';
import 'package:desafio_mobile/src/shared/data_struct/auth.dart';
import 'package:desafio_mobile/src/domain/entities/user.dart';
import 'package:desafio_mobile/src/domain/errors/errors.dart';
import 'package:desafio_mobile/src/domain/repositories/auth_repository.dart';
import 'package:desafio_mobile/src/domain/usecases/auth_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AuthRepositoryMock extends Mock implements IAuthRepository {}

void main() {
  final repository = AuthRepositoryMock();
  final usecase = AuthUserUsecase(repository);

  test('should return the data of the logged in user', () async {
    final auth = AuthUser(email: 'login', password: 'password');

    when(() => repository.authUser(auth)).thenAnswer((_) async => right(User(uid: '', email: '')));

    final result = await usecase(auth);

    expect(result.fold(id, id), isA<User>());
  });

  test('should return an AuthException if it sends the login empty or null', () async {
    final auth = AuthUser(email: '', password: '00');
    const falire = FalireException('error');

    when(() => repository.authUser(auth)).thenAnswer((_) async => left(falire));

    final result = await usecase(auth);

    expect(result.fold(id, id), isA<FalireException>());
  });
  test('should return an AuthException if it sends the password empty or null', () async {
    final auth = AuthUser(email: 'a', password: '');
    const falire = FalireException('error');

    when(() => repository.authUser(auth)).thenAnswer((_) async => left(falire));

    final result = await usecase(auth);

    expect(result.fold(id, id), isA<FalireException>());
  });
}
