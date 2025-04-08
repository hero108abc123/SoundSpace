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
import 'package:soundspace/features/home/data/data_sources/discovery_remote_data_source.dart';
import 'package:soundspace/features/home/data/data_sources/favorite_remote_data_source.dart';
import 'package:soundspace/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:soundspace/features/home/data/data_sources/user_remote_date_source.dart';
import 'package:soundspace/features/home/data/repositories/discovery_repository_impl.dart';
import 'package:soundspace/features/home/data/repositories/favorite_repository_impl.dart';
import 'package:soundspace/features/home/data/repositories/home_repository_impl.dart';
import 'package:soundspace/features/home/data/repositories/user_repository_impl.dart';
import 'package:soundspace/features/home/domain/repositories/discovery_repository.dart';
import 'package:soundspace/features/home/domain/repositories/favorite_repository.dart';
import 'package:soundspace/features/home/domain/repositories/home_repository.dart';
import 'package:soundspace/features/home/domain/repositories/user_repository.dart';
import 'package:soundspace/features/home/domain/usecase/add_track.dart';
import 'package:soundspace/features/home/domain/usecase/create_playlist.dart';
import 'package:soundspace/features/home/domain/usecase/follow_user.dart';
import 'package:soundspace/features/home/domain/usecase/get_favorite_tracks.dart';
import 'package:soundspace/features/home/domain/usecase/get_followed_artists.dart';
import 'package:soundspace/features/home/domain/usecase/get_followed_playlist.dart';
import 'package:soundspace/features/home/domain/usecase/get_followers.dart';
import 'package:soundspace/features/home/domain/usecase/get_my_playlists.dart';
import 'package:soundspace/features/home/domain/usecase/get_my_tracks.dart';
import 'package:soundspace/features/home/domain/usecase/get_playlists_by_userid.dart';
import 'package:soundspace/features/home/domain/usecase/get_playlists_from_followings.dart';
import 'package:soundspace/features/home/domain/usecase/get_playlists_from_unfollowing.dart';
import 'package:soundspace/features/home/domain/usecase/get_tracks_by_userid.dart';
import 'package:soundspace/features/home/domain/usecase/get_tracks_from_unfollowings.dart';
import 'package:soundspace/features/home/domain/usecase/get_unfollowed_artist.dart';
import 'package:soundspace/features/home/domain/usecase/load_track.dart';
import 'package:soundspace/features/home/domain/usecase/logout.dart';
import 'package:soundspace/features/home/domain/usecase/unfollow_user.dart';
import 'package:soundspace/features/home/domain/usecase/update_user_profile.dart';
import 'package:soundspace/features/home/presentation/bloc/discovery/discovery_bloc.dart';
import 'package:soundspace/features/home/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:soundspace/features/home/presentation/bloc/user/user_bloc.dart';

import 'features/home/presentation/bloc/home/home_bloc.dart';

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
    ..registerFactory<DiscoveryRemoteDataSource>(
      () => DiscoveryRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<FavoriteRemoteDataSource>(
      () => FavoriteRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(
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
    ..registerFactory<DiscoveryRepository>(
      () => DiscoveryRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<FavoriteRepository>(
      () => FavoriteRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<UserRepository>(
      () => UserRepositoryImpl(
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
      () => GetPlaylistsFromFollowings(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetFollowedArtists(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetFavoriteTracks(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetFollowedPlaylist(
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
    ..registerFactory(
      () => Logout(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UpdateUserProfile(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetMyTracks(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetMyPlaylists(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetFollowers(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => FollowUser(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UnfollowUser(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetPlaylistsByUserId(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetTracksByUserId(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CreatePlaylist(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => AddTrack(
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
        getPlaylistsFromFollowings: serviceLocator(),
        getFollowedArtists: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => DiscoveryBloc(
        getPlaylistsFromUnfollowings: serviceLocator(),
        getUnfollowedArtists: serviceLocator(),
        getTracksFromUnfollowings: serviceLocator(),
        getPlaylistsByUserId: serviceLocator(),
        getTracksByUserId: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => FavoriteBloc(
        getFavoriteTracks: serviceLocator(),
        getFollowedPlaylist: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserBloc(
        logout: serviceLocator(),
        updateUserProfile: serviceLocator(),
        getMyPlaylists: serviceLocator(),
        getMyTracks: serviceLocator(),
        getFollowers: serviceLocator(),
        followUser: serviceLocator(),
        unfollowUser: serviceLocator(),
        createPlaylist: serviceLocator(),
        addTrack: serviceLocator(),
      ),
    );
}
