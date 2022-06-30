import 'package:desafio_mobile/src/external/database/app_database.dart';
import 'package:desafio_mobile/src/external/datasources/save_bank_location_datasource.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/data/repositories/auth_repository.dart';
import 'src/data/repositories/bank_repository.dart';
import 'src/data/repositories/position_repository.dart';
import 'src/domain/usecases/auth_user_usecase.dart';
import 'src/domain/usecases/featch_bank_location_usecase.dart';
import 'src/domain/usecases/get_current_position_usecase.dart';
import 'src/domain/usecases/save_bank_location_usecase.dart';
import 'src/external/datasources/auth_datasource.dart';
import 'src/external/datasources/featch_bank_location_datasource.dart';
import 'src/external/datasources/get_current_position_datasource.dart';
import 'src/external/location_device/localization.dart';
import 'src/presentation/bloc/home/database/database_bloc.dart';
import 'src/presentation/bloc/home/position/position_bloc.dart';
import 'src/presentation/bloc/signin/signin_bloc.dart';

class Shell extends StatelessWidget {
  final Widget child;
  const Shell({Key? key, required this.child}) : super(key: key);

  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static final FirebaseAnalyticsObserver _observer =
      FirebaseAnalyticsObserver(analytics: _analytics);
  static final crashlytics = FirebaseCrashlytics.instance;
  static final db = AppDatabase.instance;

  List<RepositoryProvider> get listRepositoryProvider => [
        //Bank place usecase injection
        RepositoryProvider<AppDatabase>(
          create: (context) => db,
        ),
        RepositoryProvider<SaveBankLocationDatasource>(create: (context) {
          final db = context.read<AppDatabase>();
          return SaveBankLocationDatasource(db);
        }),
        RepositoryProvider<FeatchBankLocationDatasource>(create: (context) {
          final db = context.read<AppDatabase>();
          return FeatchBankLocationDatasource(db);
        }),
        RepositoryProvider<BankRepository>(create: (context) {
          final saveBankLocation = context.read<SaveBankLocationDatasource>();
          final featchBankLocation = context.read<FeatchBankLocationDatasource>();
          return BankRepository(saveBankLocation, featchBankLocation);
        }),
        RepositoryProvider<SaveBankLocationUsecase>(create: (context) {
          final repository = context.read<BankRepository>();
          return SaveBankLocationUsecase(repository);
        }),
        RepositoryProvider<FeatchBankLocationUsecase>(create: (context) {
          final repository = context.read<BankRepository>();
          return FeatchBankLocationUsecase(repository);
        }),

        //position usecase injection
        RepositoryProvider<Localization>(
          create: (context) => Localization(),
        ),
        RepositoryProvider<GetCurrentPositionDatasource>(create: (context) {
          final localization = context.read<Localization>();
          return GetCurrentPositionDatasource(localization);
        }),
        RepositoryProvider<PositionRepository>(create: (context) {
          final datasource = context.read<GetCurrentPositionDatasource>();
          return PositionRepository(datasource);
        }),
        RepositoryProvider<GetCurrentPositionUsecase>(create: (context) {
          final repository = context.read<PositionRepository>();
          return GetCurrentPositionUsecase(repository);
        }),

        //FirebaseCrashlytics injection
        RepositoryProvider<FirebaseCrashlytics>(
          create: (context) => crashlytics,
        ),

        //FirebaseAnalyticsObserver injection
        RepositoryProvider<FirebaseAnalyticsObserver>(
          create: (context) => _observer,
        ),

        //FirebaseAnalytics injection
        RepositoryProvider<FirebaseAnalytics>(
          create: (context) => _analytics,
        ),

        //FirebaseAuth injection
        RepositoryProvider<FirebaseAuth>(
          create: (context) => _firebaseAuth,
        ),

        //authentication usecase injection
        RepositoryProvider<AuthDatasource>(
          create: (context) {
            final firebaseAuth = context.read<FirebaseAuth>();
            final analytics = context.read<FirebaseAnalytics>();
            return AuthDatasource(
              firebaseAuth: firebaseAuth,
              analytics: analytics,
              crashlytics: crashlytics,
            );
          },
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) {
            final authDatasource = context.read<AuthDatasource>();
            return AuthRepository(authDatasource);
          },
        ),
        RepositoryProvider<AuthUserUsecase>(
          create: (context) {
            final authRepository = context.read<AuthRepository>();
            return AuthUserUsecase(authRepository);
          },
        )
      ];

  List<BlocProvider> get listBlocProvider => [
        BlocProvider<SigninBloc>(
          create: (context) {
            final authUserUsecase = context.read<AuthUserUsecase>();
            return SigninBloc(authUserUsecase);
          },
        ),
        BlocProvider<PositionBloc>(
          create: (context) {
            final usecase = context.read<GetCurrentPositionUsecase>();
            return PositionBloc(usecase);
          },
        ),
        BlocProvider<DatabaseBloc>(
          create: (context) {
            final saveBankLocation = context.read<SaveBankLocationUsecase>();
            final featchBankLocation = context.read<FeatchBankLocationUsecase>();
            return DatabaseBloc(saveBankLocation, featchBankLocation);
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: listRepositoryProvider,
      child: MultiBlocProvider(
        providers: listBlocProvider,
        child: child,
      ),
    );
  }
}
