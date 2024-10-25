import 'dart:async'; // Import the async package
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // Import Geolocator
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:payroll_vade/common/styles/spacing_styles.dart';
import 'package:payroll_vade/feature/activity/screens/home_screen/widget/container.dart';
import 'package:payroll_vade/feature/activity/screens/home_screen/widget/home_profile.dart';
import 'package:payroll_vade/utils/constants/colors.dart';
import 'package:payroll_vade/utils/constants/sizes.dart';
import 'package:payroll_vade/utils/device/device_utility.dart';
import 'package:payroll_vade/utils/constants/enums.dart';
import 'package:payroll_vade/utils/dto/account_dto.dart';
import 'package:payroll_vade/utils/helpers/helper_functions.dart';
import 'package:payroll_vade/utils/request/login_request.dart';

class HomeScreen extends StatefulWidget {
  final LoginRequest loginRequest;
  final AccountDto accountDTO;
  const HomeScreen(
      {Key? key, required this.loginRequest, required this.accountDTO})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime _currentTime; // Variable to hold the current time
  late Timer _timer; // Timer for updating the clock
  bool _isClockedIn = false; // Track clock in/out state
  DateTime? _clockInTime; // Variable to hold the clock in time
  DateTime? _clockOutTime; // Variable to hold the clock out time
  Position? _currentPosition; // Variable to hold current position

  @override
  void initState() {
    super.initState();

    _currentTime = DateTime.now(); // Initialize the current time
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now(); // Update the current time every second
      });
    });

    _getCurrentLocation(); // Get the current location
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _toggleClockInOut() {
    setState(() {
      if (!_isClockedIn) {
        // If not clocked in, clock in and record the time
        _clockInTime = DateTime.now();
      } else {
        // If clocked in, clock out and record the time
        _clockOutTime = DateTime.now();
      }
      _isClockedIn = !_isClockedIn; // Toggle the clock in/out state
    });
  }

  String _formatTime(DateTime? time) {
    if (time == null) {
      return '--';
    }
    return DateFormat('HH:mm').format(time); // Format time using intl
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMMM d, y')
        .format(date); // Format date to "Month Day, Year"
  }

  Future<void> _getCurrentLocation() async {
    // Check if location services are enabled
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle the case when location permissions are denied forever
      return;
    }

    // Get the current position
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(
        "Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}");
  }

  @override
  Widget build(BuildContext context) {
    // Adjusting the index to match the DayOfWeek enum
    DayOfWeek currentDay =
        DayOfWeek.values[(_currentTime.toLocal().weekday - 1) % 7];

    // Check if dark mode is enabled
    final dark = THelperFunctions.isDarkMode(context);

    return Stack(
      children: [
        // Background
        Container(
          color: dark ? TColors.darkBackground : TColors.lightBackground,
          width: TDeviceUtils.getScreenWidth(context),
          height: TDeviceUtils.getScreenHeight(),
        ),
        // Body
        Container(
          width: TDeviceUtils.getScreenWidth(context),
          height: 170,
          child: CustomPaint(
            painter: WavyBottomPainter(dark ? TColors.accent : TColors.primary),
          ),
        ),
        Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              HomeProfile(accountDTO: widget.accountDTO),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Rounded Container
              Container(
                width: TDeviceUtils.getScreenWidth(context),
                decoration: BoxDecoration(
                  color: dark ? TColors.darkContainer : TColors.lightContainer,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: dark ? TColors.borderDark : TColors.borderLight,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                              color: TColors.primary,
                              size: 50,
                              Iconsax.calendar),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    _formatDate(_currentTime.toLocal()),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    currentDay.name,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                '${_currentTime.toLocal().hour.toString().padLeft(2, '0')}:${_currentTime.toLocal().minute.toString().padLeft(2, '0')}:${_currentTime.toLocal().second.toString().padLeft(2, '0')}',
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      height: 80,
                      decoration: BoxDecoration(
                        color: dark ? TColors.darkContainer : Colors.white,
                        border: Border.all(
                          color:
                              dark ? TColors.borderDark : TColors.borderLight,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Clock In',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                Text(
                                  _formatTime(_clockInTime),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Clock Out',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                Text(
                                  _formatTime(_clockOutTime),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _toggleClockInOut,
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0.0), // Sharp corner
                              topRight: Radius.circular(0.0), // Sharp corner
                              bottomLeft:
                                  Radius.circular(20.0), // Rounded corner
                              bottomRight:
                                  Radius.circular(20.0), // Rounded corner
                            ),
                          ),
                        ),
                        child: Text(_isClockedIn ? 'Clock Out' : 'Clock In'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(color: TColors.primary, Iconsax.notification),
                      SizedBox(width: TSizes.spaceBtwItems),
                      Text(
                        'Announcement',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
