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

  test('deve retornar os dados de usuario logado', () async {
    final auth = AuthUser(email: 'login', password: 'password');

    when(() => repository.authUser(auth)).thenAnswer((_) async => right(User(uid: '', email: '')));

    final result = await usecase(auth);

    expect(result.fold(id, id), isA<User>());
  });

  test('deve retornar um AuthException se enviar  o login ou password vazio', () async {
    final auth = AuthUser(email: '', password: '');

    final result = await usecase(auth);

    expect(result.fold(id, id), isA<AuthException>());
  });
}
