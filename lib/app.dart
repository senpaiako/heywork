import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payroll_vade/feature/authentication/screens/Login/logIn_screen.dart';
import 'package:payroll_vade/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}
