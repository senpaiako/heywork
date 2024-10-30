import 'package:flutter/material.dart';
import 'package:payroll_vade/common/styles/spacing_styles.dart';
import 'package:payroll_vade/utils/constants/colors.dart';
import 'package:payroll_vade/utils/constants/image.strings.dart';
import 'package:payroll_vade/utils/constants/sizes.dart';
import 'package:payroll_vade/utils/helpers/helper_functions.dart';
import 'package:payroll_vade/utils/request/login_request.dart';
import 'package:payroll_vade/utils/request/change_password_request.dart';
import 'package:payroll_vade/utils/api/change_password_api.dart';
import 'package:payroll_vade/utils/theme/custom_themes/text_field_theme.dart';
import 'package:payroll_vade/utils/constants/text_strings.dart';

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
  bool isNewPasswordVisible = false;
  bool isRepeatPasswordVisible = false;

  Future<void> changePassword() async {
    setState(() {
      loading = true;
      errorMessage = null;
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

    if (response is Map<String, dynamic>) {
      if (response['message'] == 'Success.') {
        Navigator.pop(context);
      } else {
        errorMessage = response['message'] ?? 'An error occurred';
      }
    } else if (response is String) {
      errorMessage = response;
    } else {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Change Password",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    TextFormField(
                      controller: currentPasswordController,
                      obscureText: true,
                      decoration: dark
                          ? TTextFormFieldTheme.darkInputDecorationTheme
                              .copyWith(
                              prefixIcon: const Icon(Icons.lock),
                              labelText: 'Current Password',
                            )
                          : TTextFormFieldTheme.lightInputDecorationTheme
                              .copyWith(
                              prefixIcon: const Icon(Icons.lock),
                              labelText: 'Current Password',
                            ),
                    ),
                    const SizedBox(height: TSizes.sm),
                    TextFormField(
                      controller: newPasswordController,
                      obscureText: !isNewPasswordVisible,
                      decoration: dark
                          ? TTextFormFieldTheme.darkInputDecorationTheme
                              .copyWith(
                              prefixIcon: const Icon(Icons.lock),
                              labelText: 'New Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isNewPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isNewPasswordVisible =
                                        !isNewPasswordVisible;
                                  });
                                },
                              ),
                            )
                          : TTextFormFieldTheme.lightInputDecorationTheme
                              .copyWith(
                              prefixIcon: const Icon(Icons.lock),
                              labelText: 'New Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isNewPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isNewPasswordVisible =
                                        !isNewPasswordVisible;
                                  });
                                },
                              ),
                            ),
                    ),
                    const SizedBox(height: TSizes.sm),
                    TextFormField(
                      controller: repeatNewPasswordController,
                      obscureText: !isRepeatPasswordVisible,
                      decoration: dark
                          ? TTextFormFieldTheme.darkInputDecorationTheme
                              .copyWith(
                              prefixIcon: const Icon(Icons.lock),
                              labelText: 'Repeat New Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isRepeatPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isRepeatPasswordVisible =
                                        !isRepeatPasswordVisible;
                                  });
                                },
                              ),
                            )
                          : TTextFormFieldTheme.lightInputDecorationTheme
                              .copyWith(
                              prefixIcon: const Icon(Icons.lock),
                              labelText: 'Repeat New Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isRepeatPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isRepeatPasswordVisible =
                                        !isRepeatPasswordVisible;
                                  });
                                },
                              ),
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
