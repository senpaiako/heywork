import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:payroll_vade/feature/activity/screens/home_screen/home.dart';
import 'package:payroll_vade/feature/activity/screens/profile_screen/profile.dart';
import 'package:payroll_vade/feature/activity/screens/self_service_screen/self_service.dart';
import 'package:payroll_vade/feature/authentication/screens/Login/logIn_screen.dart';
import 'package:payroll_vade/utils/constants/colors.dart';
import 'package:payroll_vade/utils/dto/account_dto.dart';
import 'package:payroll_vade/utils/helpers/helper_functions.dart';
import 'package:payroll_vade/utils/request/login_request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class NavigationMenu extends StatefulWidget {
  final LoginRequest loginRequest;
  final AccountDto accountDTO;

  const NavigationMenu({
    Key? key,
    required this.loginRequest,
    required this.accountDTO,
  }) : super(key: key);

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final NavigationController controller;

  _NavigationMenuState() : controller = Get.put(NavigationController());

  Timer? _sessionTimer;

  @override
  void initState() {
    super.initState();
    _startSessionTimer();
    controller.init(
        widget.loginRequest, widget.accountDTO); // Pass the parameters
  }

  @override
  void dispose() {
    _sessionTimer?.cancel();
    super.dispose();
  }

  void _startSessionTimer() {
    _sessionTimer?.cancel();
    _sessionTimer = Timer(const Duration(minutes: 10), _logout);
  }

  void _resetSessionTimer() {
    _startSessionTimer();
  }

  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored preferences

    _showLogoutMessage(); // Show message before navigating
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  void _showLogoutMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('You have been logged out due to inactivity.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: dark ? Colors.black : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) {
              controller.selectedIndex.value = index;
              _resetSessionTimer(); // Reset the session timer on tab change
            },
            backgroundColor: Colors.transparent,
            indicatorColor: dark
                ? TColors.textWhite.withOpacity(0.1)
                : TColors.black.withOpacity(0.1),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: [
              NavigationDestination(
                icon: Icon(
                  controller.selectedIndex.value == 0
                      ? Iconsax.home5
                      : Iconsax.home_1,
                  color: controller.selectedIndex.value == 0
                      ? TColors.primary
                      : dark
                          ? TColors.textWhite
                          : TColors.black,
                ),
                label: 'Home',
                tooltip: 'Home',
              ),
              NavigationDestination(
                icon: Icon(
                  Iconsax.setting_2,
                  color: controller.selectedIndex.value == 1
                      ? TColors.primary
                      : dark
                          ? TColors.textWhite
                          : TColors.black,
                ),
                label: 'Self-service',
                tooltip: 'Self-service',
              ),
              NavigationDestination(
                icon: Icon(
                  controller.selectedIndex.value == 2
                      ? Iconsax.profile_2user5
                      : Iconsax.profile_2user,
                  color: controller.selectedIndex.value == 2
                      ? TColors.primary
                      : dark
                          ? TColors.textWhite
                          : TColors.black,
                ),
                label: 'Profile',
                tooltip: 'Profile',
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  List<Widget> screens = [];

  void init(LoginRequest loginRequest, AccountDto accountDTO) {
    screens = [
      HomeScreen(loginRequest: loginRequest, accountDTO: accountDTO),
      const SelfService(),
      const Profile(),
    ];
  }
}
