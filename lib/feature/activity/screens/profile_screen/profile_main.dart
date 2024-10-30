import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:payroll_vade/common/styles/spacing_styles.dart';
import 'package:payroll_vade/feature/activity/screens/home_screen/widget/background.dart';
import 'package:payroll_vade/feature/activity/screens/home_screen/widget/container.dart';
import 'package:payroll_vade/feature/activity/screens/profile_screen/profile_subscreen/Org_chart.dart';
import 'package:payroll_vade/feature/activity/screens/profile_screen/profile_subscreen/change_password.dart';
import 'package:payroll_vade/feature/activity/screens/profile_screen/profile_subscreen/government.dart';
import 'package:payroll_vade/feature/activity/screens/profile_screen/profile_subscreen/profile.dart';
import 'package:payroll_vade/feature/authentication/screens/Login/logIn_screen.dart';
import 'package:payroll_vade/utils/constants/colors.dart';
import 'package:payroll_vade/utils/constants/image.strings.dart';
import 'package:payroll_vade/utils/constants/sizes.dart';
import 'package:payroll_vade/utils/device/device_utility.dart';
import 'package:payroll_vade/utils/dto/account_dto.dart';
import 'package:payroll_vade/utils/helpers/helper_functions.dart';
import 'package:payroll_vade/utils/helpers/image_decoder.dart';
import 'package:payroll_vade/utils/request/login_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileMain extends StatefulWidget {
  final LoginRequest loginRequest;
  final AccountDto accountDTO;
  const ProfileMain(
      {Key? key, required this.accountDTO, required this.loginRequest})
      : super(key: key);

  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  Uint8List? bytes;

  @override
  void initState() {
    super.initState();
    bytes = decodeImage(widget.accountDTO.image);
  }

  void _navigateTo(String destination) async {
    if (destination == 'Logout') {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('mobileNo');
      await prefs.remove('password');

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
      return;
    }

    Widget screen;

    switch (destination) {
      case 'Profile':
        screen = Profile();
        break;
      case 'Organization Chart':
        screen = OrganizationChart();
        break;
      case 'Government':
        screen = Government();
        break;
      case 'Change Password':
        screen = ChangePassword(loginRequest: widget.loginRequest);
        break;
      default:
        return; // Handle default case if needed
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        appBackground(dark: dark),
        Container(
          width: TDeviceUtils.getScreenWidth(context),
          height: 170,
          child: CustomPaint(
            painter:
                WavyBottomPainter(dark ? TColors.secondary : TColors.primary),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: TSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              children: [
                SizedBox(height: TSizes.appBarHeight / 2),
                CircleAvatar(
                  backgroundImage: bytes != null
                      ? MemoryImage(bytes!)
                      : const AssetImage(TImages.vadeLogoBlack)
                          as ImageProvider,
                  maxRadius: 70,
                ),
                Text(
                  widget.accountDTO.employeeName,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: TSizes.spaceBtwItems),
                Padding(
                  padding: const EdgeInsets.all(TSizes.cardRadiusSm),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          dark ? TColors.darkContainer : TColors.lightContainer,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: dark ? TColors.borderDark : TColors.borderLight,
                        width: 1.0,
                      ),
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        final labels = [
                          'Profile',
                          'Organization Chart',
                          'Government',
                          'Change Password',
                        ];
                        return _buildNavigationItem(labels[index]);
                      },
                      separatorBuilder: (context, index) => Divider(
                        color: dark ? TColors.borderDark : TColors.borderLight,
                        thickness: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(TColors.error)),
                    onPressed: () {
                      _navigateTo("Logout");
                    },
                    icon: const Icon(Iconsax.logout),
                    label: const Text("Log Out"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationItem(String label) {
    return ListTile(
      title: Text(label, style: Theme.of(context).textTheme.bodyMedium),
      trailing: Icon(Icons.arrow_forward_ios, size: 10),
      onTap: () => _navigateTo(label),
    );
  }
}
