// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:soundspace/core/network/remote/dio_client.dart';
import 'package:soundspace/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:soundspace/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:soundspace/features/auth/domain/repositories/auth_repository.dart';
import 'package:soundspace/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:soundspace/features/home/presentation/bloc/discovery/discovery_bloc.dart';
import 'package:soundspace/features/home/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:soundspace/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:soundspace/features/home/presentation/bloc/language/language_bloc.dart';
import 'package:soundspace/features/home/presentation/bloc/language/language_state.dart';
import 'package:soundspace/features/home/presentation/bloc/user/user_bloc.dart';
import 'package:soundspace/features/home/presentation/provider/language_provider.dart';
import 'package:soundspace/features/home/presentation/screens/homepage_screen.dart';
import 'package:soundspace/init_dependencies.dart';
import 'features/auth/presentation/screens/auth_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    //----------------------------App mobile-------------------------------------------------

    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<HomeBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<DiscoveryBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<FavoriteBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<UserBloc>(),
        ),
        Provider<AuthRemoteDataSource>(
          create: (_) => AuthRemoteDataSourceImpl(serviceLocator<DioClient>()),
        ),
        Provider<AuthRepository>(
          create: (context) =>
              AuthRepositoryImpl(context.read<AuthRemoteDataSource>()),
        ),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        BlocProvider(create: (_) => LanguageBloc()),
      ],
      child: const MyApp(),
    ),

    //----------------------------Device Preview-------------------------------------------------

    // MultiBlocProvider(
    //   providers: [
    //     BlocProvider(
    //       create: (_) => serviceLocator<AppUserCubit>(),
    //     ),
    //     BlocProvider(
    //       create: (_) => serviceLocator<AuthBloc>(),
    //     ),
    //     BlocProvider(
    //       create: (_) => serviceLocator<HomeBloc>(),
    //     ),
    //     BlocProvider(
    //       create: (_) => serviceLocator<DiscoveryBloc>(),
    //     ),
    //     BlocProvider(
    //       create: (_) => serviceLocator<FavoriteBloc>(),
    //     ),
    //     BlocProvider(
    //       create: (_) => serviceLocator<UserBloc>(),
    //     ),
    //     Provider<AuthRemoteDataSource>(
    //       create: (_) => AuthRemoteDataSourceImpl(serviceLocator<DioClient>()),
    //     ),
    //     Provider<AuthRepository>(
    //       create: (context) =>
    //           AuthRepositoryImpl(context.read<AuthRemoteDataSource>()),
    //     ),
    //     ChangeNotifierProvider(create: (_) => LanguageProvider()),
    //     BlocProvider(create: (_) => LanguageBloc()),
    //   ],
    //   child: DevicePreview(
    //     enabled: !kReleaseMode,
    //     builder: (content) => const MyApp(),
    //   ),
    // ),

    //-------------------------------------------------------------------------------------------
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Kiểm tra xem người dùng có đang đăng nhập hay không
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        String languageCode = 'en';
        if (state is LanguageInitial) {
          languageCode = state.languageCode;
        }

        return MaterialApp(
          locale: Locale(languageCode),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // Tiếng Anh
            Locale('vi', ''), // Tiếng Việt
          ],
          title: 'SoundSpace',
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AppUserCubit, AppUserState>(
            builder: (context, state) {
              if (state is AppUserLoggedIn) {
                return HomeScreen(user: state.user);
              }
              return const LoginScreen();
            },
          ),
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
