import 'package:desafio_mobile/src/domain/entities/user.dart';

class UserAdapter {
  UserAdapter._();

  static User fromJson(Map<String, dynamic> data) {
    return User(
      name: data['name'],
      sobreNome: data['sobre_nome'],
    );
  }
}
