import 'package:get_it/get_it.dart';
import 'package:soundspace/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:soundspace/core/network/module/network_module.dart';
import 'package:soundspace/core/network/remote/dio_client.dart';
import 'package:soundspace/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:soundspace/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:soundspace/features/auth/domain/repositories/auth_repository.dart';
import 'package:soundspace/features/auth/domain/usecases/current_user.dart';
import 'package:soundspace/features/auth/domain/usecases/user_email_validation.dart';
import 'package:soundspace/features/auth/domain/usecases/user_login.dart';
import 'package:soundspace/features/auth/domain/usecases/user_profile.dart';
import 'package:soundspace/features/auth/domain/usecases/user_sign_up.dart';
import 'package:soundspace/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:soundspace/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:soundspace/features/home/data/repositories/home_repository_impl.dart';
import 'package:soundspace/features/home/domain/repositories/home_repository.dart';
import 'package:soundspace/features/home/domain/usecase/get_playlists_from_unfollowing.dart';
import 'package:soundspace/features/home/domain/usecase/get_tracks_from_unfollowings.dart';
import 'package:soundspace/features/home/domain/usecase/get_unfollowed_artist.dart';
import 'package:soundspace/features/home/domain/usecase/load_track.dart';

import 'features/home/presentation/bloc/home_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  //core
  serviceLocator.registerLazySingleton(() => NetworkModule.provideDio());
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator

    //Datasource
    ..registerFactory<DioClient>(
      () => DioClient(
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    //Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(
        serviceLocator(),
      ),
    )
    //Auth Service
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
    ..registerFactory(
      () => UserProfile(
        serviceLocator(),
      ),
    )

    //Home Service
    ..registerFactory(
      () => LoadData(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetPlaylistsFromUnfollowings(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetUnfollowedArtists(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetTracksFromUnfollowings(
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
        userProfile: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => HomeBloc(
        loadData: serviceLocator(),
        getPlaylistsFromUnfollowings: serviceLocator(),
        getUnfollowedArtists: serviceLocator(),
        getTracksFromUnfollowings: serviceLocator(),
      ),
    );
}
