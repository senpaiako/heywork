import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import SpinKit
import 'package:iconsax/iconsax.dart';
import 'package:payroll_vade/common/styles/spacing_styles.dart';
import 'package:payroll_vade/feature/authentication/screens/Login/widget/login_header.dart';
import 'package:payroll_vade/utils/constants/sizes.dart';
import 'package:payroll_vade/utils/constants/text_strings.dart';
import 'package:payroll_vade/utils/helpers/helper_functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false; // State for the remember me checkbox
  bool _isLoading = false; // State for loading

  void _signIn() {
    setState(() {
      _isLoading = true; // Start loading when sign-in is initiated
    });

    // Simulate a delay for login process
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false; // Stop loading after the delay
      });
      // Add your login logic here
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              logInHeader(),
              const SizedBox(height: TSizes.sm),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: TSizes.spaceBtwSections),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.login),
                        labelText: TTexts.phoneNo,
                      ),
                    ),
                    PasswordField(),
                    const SizedBox(height: TSizes.sm),
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe =
                                  value ?? false; // Update checkbox state
                            });
                          },
                        ),
                        const Text(TTexts.rememberMe),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            TTexts.forgetPassword,
                            style: TextStyle(fontSize: TSizes.fontSizeSm),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : _signIn, // Disable the button while loading
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: dark ? Colors.blueGrey : Colors.blue,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SpinKitThreeBounce(
                              color: Colors.white,
                              size: 24.0,
                            )
                          : const Text(TTexts.signIn),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true; // Initial state for obscured text

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured; // Toggle the visibility state
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isObscured, // Control the visibility of the text
      decoration: InputDecoration(
        prefixIcon: const Icon(Iconsax.password_check),
        labelText: TTexts.password,
        suffixIcon: IconButton(
          icon: Icon(
            _isObscured ? Iconsax.eye_slash : Iconsax.eye, // Toggle icon
          ),
          onPressed: _toggleVisibility, // Handle icon click
        ),
      ),
    );
  }
}
