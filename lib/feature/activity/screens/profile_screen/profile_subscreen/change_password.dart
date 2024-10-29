import 'package:flutter/material.dart';
import 'package:payroll_vade/common/styles/spacing_styles.dart';
import 'package:payroll_vade/feature/authentication/screens/Login/widget/login_header.dart';
import 'package:payroll_vade/utils/constants/colors.dart';
import 'package:payroll_vade/utils/constants/image.strings.dart';
import 'package:payroll_vade/utils/constants/sizes.dart';
import 'package:payroll_vade/utils/helpers/helper_functions.dart';
import 'package:payroll_vade/utils/request/login_request.dart';
import 'package:payroll_vade/utils/request/change_password_request.dart';
import 'package:payroll_vade/utils/api/change_password_api.dart';

class ChangePassword extends StatefulWidget {
  final LoginRequest loginRequest;
  const ChangePassword({super.key, required this.loginRequest});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController repeatNewPasswordController =
      TextEditingController();
  String? errorMessage;
  bool loading = false;

  Future<void> changePassword() async {
    setState(() {
      loading = true;
      errorMessage = null; // Clear previous error message
    });

    final oldPassword = currentPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final repeatNewPassword = repeatNewPasswordController.text.trim();

    if (newPassword != repeatNewPassword) {
      setState(() {
        errorMessage = 'New passwords do not match.';
        loading = false;
      });
      return;
    }

    final changePasswordRequest = ChangePasswordRequest(
      mobileNo: widget.loginRequest.mobileNo,
      password: widget.loginRequest.password,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    final dynamic response = await ChangePasswordApi().changePassword(
      changePasswordRequest: changePasswordRequest,
    );

    setState(() {
      loading = false;
    });

    // Check if the response is not null and handle it accordingly
    if (response is Map<String, dynamic>) {
      // If the response is a JSON object
      if (response['message'] == 'Success.') {
        Navigator.pop(context); // Navigate back if successful
      } else {
        // Handle specific error messages from the response
        errorMessage = response['message'] ?? 'An error occurred';
      }
    } else if (response is String) {
      // If the response is a string (like an error message)
      errorMessage = response;
    } else {
      // Handle unexpected response types
      errorMessage = 'Unexpected response format';
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
              Image.asset(TImages.forgotPassword),
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              if (loading) Center(child: CircularProgressIndicator()),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: TSizes.spaceBtwSections),
                child: Column(
                  children: [
                    TextFormField(
                      controller: currentPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Current Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: TSizes.sm),
                    TextFormField(
                      controller: newPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: TSizes.sm),
                    TextFormField(
                      controller: repeatNewPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Repeat New Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: TSizes.sm),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: changePassword,
                        child: const Text('Change Password'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
