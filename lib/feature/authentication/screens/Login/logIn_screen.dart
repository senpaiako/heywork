import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:payroll_vade/common/styles/spacing_styles.dart';
import 'package:payroll_vade/feature/authentication/screens/Login/widget/login_header.dart';
import 'package:payroll_vade/nagivagation_menu.dart';
import 'package:payroll_vade/utils/api/login_api.dart';
import 'package:payroll_vade/utils/constants/sizes.dart';
import 'package:payroll_vade/utils/constants/text_strings.dart';
import 'package:payroll_vade/utils/dto/account_dto.dart';
import 'package:payroll_vade/utils/request/login_request.dart';
import 'package:payroll_vade/utils/theme/custom_themes/text_field_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:payroll_vade/utils/constants/colors.dart';
import 'package:payroll_vade/utils/helpers/helper_functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final LoginApi loginApi = LoginApi();
  String? errorMessage;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    checkLoggedInStatus();
  }

  Future<void> checkLoggedInStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? mobileNo = prefs.getString('mobileNo');
    final String? password = prefs.getString('password');

    if (mobileNo != null && password != null) {
      login(mobileNo, password);
    } else {
      setState(() {
        loading = false; // Update loading state
      });
    }
  }

  Future<void> login(String mobileNo, String password) async {
    final LoginRequest loginRequest = LoginRequest(
      mobileNo: mobileNo,
      password: password,
    );

    final dynamic response = await loginApi.login(loginRequest: loginRequest);
    if (response != null) {
      final AccountDto accountDTO = response;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('mobileNo', mobileNo);
      await prefs.setString('password', password);

      if (accountDTO != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationMenu(
              loginRequest: loginRequest,
              accountDTO: accountDTO,
            ),
          ),
          (route) => false,
        );
      }
    } else {
      setState(() {
        errorMessage = 'Incorrect email or password.';
      });
    }
  }

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

              /// Error Message
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),

              /// Login Form
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: TSizes.spaceBtwSections),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: mobileNoController,
                        decoration: dark
                            ? TTextFormFieldTheme.darkInputDecorationTheme
                                .copyWith(
                                prefixIcon: const Icon(Iconsax.login),
                                labelText: TTexts.phoneNo,
                              )
                            : TTextFormFieldTheme.lightInputDecorationTheme
                                .copyWith(
                                prefixIcon: const Icon(Iconsax.login),
                                labelText: TTexts.phoneNo,
                              ),
                      ),
                      const SizedBox(height: TSizes.sm),
                      TextFormField(
                        controller: passwordController,
                        decoration: dark
                            ? TTextFormFieldTheme.darkInputDecorationTheme
                                .copyWith(
                                prefixIcon: const Icon(Iconsax.password_check),
                                labelText: TTexts.password,
                                suffixIcon: const Icon(Iconsax.eye_slash),
                              )
                            : TTextFormFieldTheme.lightInputDecorationTheme
                                .copyWith(
                                prefixIcon: const Icon(Iconsax.password_check),
                                labelText: TTexts.password,
                                suffixIcon: const Icon(Iconsax.eye_slash),
                              ),
                      ),
                      const SizedBox(height: TSizes.sm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(value: true, onChanged: (value) {}),
                              const Text(TTexts.rememberMe),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.sm),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            String mobileNo = mobileNoController.text.trim();
                            String password = passwordController.text.trim();
                            login(mobileNo, password); // Call login method
                          },
                          child: const Text(TTexts.signIn),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
