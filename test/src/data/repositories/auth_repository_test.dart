import 'package:dartz/dartz.dart';
import 'package:desafio_mobile/src/shared/data_struct/auth.dart';
import 'package:desafio_mobile/src/data/datadources/auth_datasource.dart';
import 'package:desafio_mobile/src/data/repositories/auth_repository.dart';
import 'package:desafio_mobile/src/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class AuthDatasourceMock extends Mock implements IAuthDatasource {}

void main() {
  final IAuthDatasource authDatasource = AuthDatasourceMock();

  final repository = AuthRepository(authDatasource);

  test('verificar de retorna o usuario', () async {
    final auth = AuthUser(email: '', password: '');
    when(() => authDatasource.authUser(auth)).thenAnswer((_) async => json);

    final result = await repository.authUser(auth);

    final user = result.fold(id, id);
    expect(user, isA<User>());

    expect((user as User).email, 'jacksonpaulino@gmail.com');

    expect((user).uid, 'DDr80n424LMt5MM8eweeklcnsqQ2');
  });
}

final json = <String, dynamic>{
  'uid': 'DDr80n424LMt5MM8eweeklcnsqQ2',
  'email': 'jacksonpaulino@gmail.com'
};
