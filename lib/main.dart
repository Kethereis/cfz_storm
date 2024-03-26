import 'package:cfz_storm/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

import 'layout/mobile/home_screen_mobile.dart';
import 'layout/web/home_screen_web.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crefaz Storm',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ResponsiveLayout(
        mobileBody: HomeScreenMobile(step: 0,),
        desktopBody: HomeScreenWeb(step: 0,),
      ),
    );
  }
}