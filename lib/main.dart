import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:soundspace/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:soundspace/config/theme/theme.dart';
import 'package:soundspace/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:soundspace/init_dependencies.dart';
// import 'features/auth/presentation/screens/auth_screens.dart';
import 'features/home/presentation/screens/homepage_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    //----------------------------App mobile-------------------------------------------------

    //   MultiBlocProvider(
    //     providers: [
    //       BlocProvider(
    //         create: (_) => serviceLocator<AppUserCubit>(),
    //       ),
    //       BlocProvider(
    //         create: (_) => serviceLocator<AuthBloc>(),
    //       ),
    //     ],
    //     child: const MyApp(),
    //   ),
    // );

    //----------------------------Device Preview-------------------------------------------------

    DevicePreview(
      enabled: !kReleaseMode,
      builder: (content) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => serviceLocator<AppUserCubit>(),
          ),
          BlocProvider(
            create: (_) => serviceLocator<AuthBloc>(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
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
    return GetMaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
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
          }
          return const HomeScreen();
        },
      ),
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen()),
        GetPage(name: '/track', page: () => const TrackScreen()),
        GetPage(name: '/playlist', page: () => const PlaylistScreen()),
      ],
    );
  }
}
