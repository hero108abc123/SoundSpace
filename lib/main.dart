// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundspace/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:soundspace/config/theme/theme.dart';
import 'package:soundspace/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:soundspace/features/home/presentation/bloc/home_bloc.dart';
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
        )
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
    //     )
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
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'SoundSpace',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const HomeScreen();
            // return const LoginScreen();
          }
          return const LoginScreen();
          // return const HomeScreen();
        },
      ),
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
