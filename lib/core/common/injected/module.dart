import 'package:desafio_mobile/app/common/db_storage/db_storage_dao.dart';
import 'package:desafio_mobile/app/common/db_storage/db_storage_imp_dao.dart';
import 'package:desafio_mobile/app/common/store/global_store.dart';
import 'package:desafio_mobile/app/home/data/datasource/home_datasource.dart';
import 'package:desafio_mobile/app/home/data/datasource/home_datasource_imp.dart';
import 'package:desafio_mobile/app/home/data/repository/home_repository_imp.dart';
import 'package:desafio_mobile/app/home/domain/repository/home_repository.dart';
import 'package:desafio_mobile/app/home/domain/usecase/save_user_info_in_db_usecase.dart';
import 'package:desafio_mobile/app/home/ui/controller/home_controller.dart';
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
    ..registerLazySingleton<DbStorageDao>(() => DbStorageImpDao())
    ..registerLazySingleton(() => SignInWithEmailAndPasswordUsecase())
    ..registerLazySingleton<LoginDatasource>(
      () => LoginDatasourceImp(),
    )
    ..registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImp(),
    )
    ..registerFactory(() => LoginController())
    ..registerLazySingleton(() => SaveUserInfoInDbUsecase())
    ..registerLazySingleton<HomeDatasource>(
      () => HomeDatasourceImp(),
    )
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImp(),
    )
    ..registerFactory(() => HomeController())
    ..registerLazySingleton(() => GlobalStore());
  // getIt.registerLazySingleton(() => ThemeStore());
}
