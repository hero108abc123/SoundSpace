import 'package:get_it/get_it.dart';
import 'package:soundspace/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:soundspace/core/network/module/network_module.dart';
import 'package:soundspace/core/network/remote/dio_client.dart';
import 'package:soundspace/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:soundspace/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:soundspace/features/auth/data/repositories/token_repository_impl.dart';
import 'package:soundspace/features/auth/domain/repositories/auth_repository.dart';
import 'package:soundspace/features/auth/domain/repositories/token_repository.dart';
import 'package:soundspace/features/auth/domain/usecases/current_user.dart';
import 'package:soundspace/features/auth/domain/usecases/user_email_validation.dart';
import 'package:soundspace/features/auth/domain/usecases/user_login.dart';
import 'package:soundspace/features/auth/domain/usecases/user_sign_up.dart';
import 'package:soundspace/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  serviceLocator.registerLazySingleton(() => NetworkModule.provideDio());

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    ..registerFactory<TokenRepository>(
      () => TokenRepositoryImpl(),
    )
    ..registerFactory<DioClient>(
      () => DioClient(
        serviceLocator(),
      ),
    )

    //Datasource
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )

    //Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )

    //Service
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => Userlogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserEmailValidation(
        serviceLocator(),
      ),
    )
    //Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userlogin: serviceLocator(),
        userEmailValidation: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
