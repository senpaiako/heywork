import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:payroll_vade/feature/activity/screens/home_screen/home.dart';
import 'package:payroll_vade/feature/activity/screens/profile_screen/profile.dart';
import 'package:payroll_vade/feature/activity/screens/self_service_screen/self_service.dart';
import 'package:payroll_vade/utils/constants/colors.dart';
import 'package:payroll_vade/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
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
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            backgroundColor: Colors.transparent,
            indicatorColor: dark
                ? TColors.textWhite.withOpacity(0.1)
                : TColors.black.withOpacity(0.1),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: [
              NavigationDestination(
                icon: Icon(
                  controller.selectedIndex.value == 0
                      ? Iconsax.home5 // Filled version when selected
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
                  controller.selectedIndex.value == 1
                      ? Iconsax.setting_2 // Filled version when selected
                      : Iconsax.setting_2,
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
                      ? Iconsax.profile_2user5 // Filled version when selected
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

  final screens = [const HomeScreen(), const SelfService(), const Profile()];
}
