import 'package:desafio_mobile/src/presentation/bloc/signin_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/datadources/auth_datasource.dart';
import 'data/repositories/auth_repository.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/auth_user_usecase.dart';
import 'external/datasources/auth_datasource.dart';
import 'presentation/pages/signin_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<FirebaseAuth>((i) => FirebaseAuth.instance),
        Bind.factory<IAuthDatasource>((i) => AuthDatasource(i())),
        Bind.factory<IAuthRepository>((i) => AuthRepository(i())),
        Bind.factory<IAuthUserUsecase>((i) => AuthUserUsecase(i())),
        Bind.singleton<SigninBloc>((i) => SigninBloc(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SigninPage()),
      ];
}
