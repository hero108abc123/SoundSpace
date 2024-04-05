import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soundspace/core/theme/theme.dart';
import 'features/auth/presentation/screens/screens.dart';



void main() {
  runApp(DevicePreview(enabled: !kReleaseMode, builder: (content) => const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'SoundSpace',
      theme: AppTheme.darkThemeMode,
      home: const UserProfileScreen(),
    );
  }
}

