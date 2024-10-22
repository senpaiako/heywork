import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:payroll_vade/common/styles/spacing_styles.dart';
import 'package:payroll_vade/feature/activity/screens/home_screen/widget/home_profile.dart';
import 'package:payroll_vade/utils/constants/image.strings.dart';
import 'package:payroll_vade/utils/constants/sizes.dart';
import 'package:payroll_vade/utils/device/device_utility.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              const homeProfile(),
              const SizedBox(height: TSizes.spaceBtwSections),
              // Rounded Container
              Container(
                width: TDeviceUtils.getScreenWidth(context),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 156, 50, 50),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.all(16.0), // Add some padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Running Time',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Date: ${DateTime.now().toLocal().toString().split(' ')[0]}',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Day: ${DateTime.now().toLocal().weekday}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
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
