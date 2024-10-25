import 'package:flutter/material.dart';
import 'package:payroll_vade/utils/constants/colors.dart';
import 'package:payroll_vade/utils/device/device_utility.dart';

class appBackground extends StatelessWidget {
  const appBackground({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: dark ? TColors.darkBackground : TColors.lightBackground,
      width: TDeviceUtils.getScreenWidth(context),
      height: TDeviceUtils.getScreenHeight(),
    );
  }
}
