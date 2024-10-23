import 'dart:async'; // Import the async package
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payroll_vade/common/styles/spacing_styles.dart';
import 'package:payroll_vade/feature/activity/screens/home_screen/widget/home_profile.dart';
import 'package:payroll_vade/utils/constants/colors.dart';
import 'package:payroll_vade/utils/constants/sizes.dart';
import 'package:payroll_vade/utils/device/device_utility.dart';
import 'package:payroll_vade/utils/constants/enums.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime _currentTime; // Variable to hold the current time
  late Timer _timer; // Timer for updating the clock
  bool _isClockedIn = false; // Track clock in/out state
  DateTime? _clockInTime; // Variable to hold the clock in time
  DateTime? _clockOutTime; // Variable to hold the clock out time

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now(); // Initialize the current time
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now(); // Update the current time every second
      });
    });
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

  @override
  Widget build(BuildContext context) {
    // Adjusting the index to match the DayOfWeek enum
    DayOfWeek currentDay =
        DayOfWeek.values[(_currentTime.toLocal().weekday - 1) % 7];

    return Stack(
      children: [
        Container(
          width: TDeviceUtils.getScreenWidth(context),
          height: 170,
          decoration: BoxDecoration(
            color: TColors.primary,
            border: Border.all(
              color: TColors.borderPrimary, // Use your defined border color
              width: 1.0, // Adjust the width as needed
            ),
          ),
        ),
        Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              const homeProfile(),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Rounded Container
              Container(
                width: TDeviceUtils.getScreenWidth(context),
                decoration: BoxDecoration(
                  color: TColors.primaryBackground,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color:
                        TColors.borderPrimary, // Use your defined border color
                    width: 1.0, // Adjust the width as needed
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _currentTime.toLocal().toString().split(' ')[0],
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                currentDay
                                    .name, // Use the name getter to get the day name
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Container(
                            width: 1.0,
                            height: 50.0,
                            color: Colors.black,
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Text(
                            '${_currentTime.toLocal().hour.toString().padLeft(2, '0')}:${_currentTime.toLocal().minute.toString().padLeft(2, '0')}:${_currentTime.toLocal().second.toString().padLeft(2, '0')}',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: TColors
                              .borderSecondary, // Use your defined border color
                          width: 1.0, // Adjust the width as needed
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
                                // Display clock in time if available
                                Text(_formatTime(_clockInTime)),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Clock Out',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                // Display clock out time if available
                                Text(_formatTime(_clockOutTime)),
                              ],
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _toggleClockInOut,
                        // Toggle button text between 'Clock In' and 'Clock Out'
                        child: Text(_isClockedIn ? 'Clock Out' : 'Clock In'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
