import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soundspace/screens/tellmemore-screen.dart';
import 'screens/screens.dart';


void main() {
  runApp(DevicePreview(enabled: !kReleaseMode, builder: (content) => const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'SoundSpace',
      home: const SignInScreen(),
      getPages: [
        GetPage(name: '/', page: () => const GetStartedScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/email', page: () => const EmailScreen()),
        GetPage(name: '/signin', page: () => const SignInScreen()),
        GetPage(name: '/signup', page: () => const SignUpScreen()),
        GetPage(name: '/tellmemore', page: () => const TellMeMoreScreen()),
        
      ],
    );
  }
}

