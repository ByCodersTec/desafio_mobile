import 'package:desafio_mobile/app/common/local_storage/local_storage_dao.dart';
import 'package:desafio_mobile/app/common/local_storage/local_storage_imp_dao.dart';
import 'package:desafio_mobile/app/login/data/datasource/login_datasource.dart';
import 'package:desafio_mobile/app/login/data/datasource/login_datasource_imp.dart';
import 'package:desafio_mobile/app/login/data/repository/login_repository_imp.dart';
import 'package:desafio_mobile/app/login/domain/repository/login_repository.dart';
import 'package:desafio_mobile/app/login/domain/usecase/sign_in_with_email_and_password_usecase.dart';
import 'package:desafio_mobile/app/login/ui/controller/login_controller.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureInjection() async {
  getIt
    ..registerLazySingleton<LocalStorageDao>(() => LocalStorageImpDao())
    ..registerLazySingleton(() => SignInWithEmailAndPasswordUsecase())
    ..registerLazySingleton<LoginDatasource>(
      () => LoginDatasourceImp(),
    )
    ..registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImp(),
    )
    ..registerFactory(() => LoginController());
  // getIt.registerLazySingleton(() => ThemeStore());
}
