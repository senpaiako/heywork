import 'package:flutter/material.dart';
import 'package:payroll_vade/common/styles/spacing_styles.dart';
import 'package:payroll_vade/feature/authentication/screens/Login/widget/login_form.dart';
import 'package:payroll_vade/feature/authentication/screens/Login/widget/login_header.dart';
import 'package:payroll_vade/utils/constants/colors.dart';
import 'package:payroll_vade/utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.darkBackground : TColors.lightBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Login Header
              LoginHeader(dark, context),

              /// Login Form
              logInForm(context, dark)
            ],
          ),
        ),
      ),
    );
  }
}
