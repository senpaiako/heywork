import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:payroll_vade/nagivagation_menu.dart';
import 'package:payroll_vade/utils/constants/sizes.dart';
import 'package:payroll_vade/utils/constants/text_strings.dart';
import 'package:payroll_vade/utils/theme/custom_themes/text_field_theme.dart';

Form logInForm(BuildContext context, bool dark) {
  return Form(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
      child: Column(
        children: [
          TextFormField(
            decoration: dark
                ? TTextFormFieldTheme.darkInputDecorationTheme.copyWith(
                    prefixIcon: const Icon(Iconsax.login),
                    labelText: TTexts.phoneNo,
                  )
                : TTextFormFieldTheme.lightInputDecorationTheme.copyWith(
                    prefixIcon: const Icon(Iconsax.login),
                    labelText: TTexts.phoneNo,
                  ),
          ),
          const SizedBox(height: TSizes.sm),
          TextFormField(
            decoration: dark
                ? TTextFormFieldTheme.darkInputDecorationTheme.copyWith(
                    prefixIcon: const Icon(Iconsax.password_check),
                    labelText: TTexts.password,
                    suffixIcon: const Icon(Iconsax.eye_slash),
                  )
                : TTextFormFieldTheme.lightInputDecorationTheme.copyWith(
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
              onPressed: () => Get.to(() => const NavigationMenu()),
              child: const Text(TTexts.signIn),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
        ],
      ),
    ),
  );
}
