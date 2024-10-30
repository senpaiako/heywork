import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:payroll_vade/common/styles/spacing_styles.dart';
import 'package:payroll_vade/feature/activity/screens/home_screen/widget/background.dart';
import 'package:payroll_vade/feature/activity/screens/home_screen/widget/container.dart';
import 'package:payroll_vade/feature/activity/screens/home_screen/widget/home_profile.dart';
import 'package:payroll_vade/utils/api/clockInOut_api.dart';
import 'package:payroll_vade/utils/constants/colors.dart';
import 'package:payroll_vade/utils/constants/sizes.dart';
import 'package:payroll_vade/utils/device/device_utility.dart';
import 'package:payroll_vade/utils/constants/enums.dart';
import 'package:payroll_vade/utils/dto/account_dto.dart';
import 'package:payroll_vade/utils/dto/timecard_dto.dart';
import 'package:payroll_vade/utils/helpers/helper_functions.dart';
import 'package:payroll_vade/utils/request/dtr_request.dart';
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
  late DateTime _currentTime;
  late Timer _timer;
  bool _isClockedIn = false;
  String? _clockInTime; // Changed to String
  String? _clockOutTime; // Changed to String
  TimecardDto? _todayTimecard;

  @override
  void initState() {
    super.initState();

    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });

    // Filter today’s timecard
    String todayDate = DateFormat('yyyy-MM-dd').format(_currentTime);
    _todayTimecard = widget.accountDTO.timecard.firstWhere(
      (timecard) => timecard.date == todayDate,
      orElse: () => TimecardDto(
        date: todayDate,
        legal: false, // Provide a default value
        special: false, // Provide a default value
        sunday: false, // Provide a default value
        saturday: false, // Provide a default value
        onLeave: false,
      ), // Handle case if not found
    );

    // If today's timecard exists, set initial clock-in/out times
    if (_todayTimecard != null) {
      _clockInTime = _todayTimecard!.inTime;
      _clockOutTime = _todayTimecard!.outTime;
      _isClockedIn = _clockInTime != null; // Set clocked in state
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _toggleClockInOut(BuildContext context) async {
    String clockType = _clockInTime != null ? "TIME_OUT" : "TIME_IN";

    final request = DtrRequest(
        mobileNo: widget.loginRequest.mobileNo,
        password: widget.loginRequest.password,
        type: clockType,
        latitude: 1, // Placeholder for actual latitude
        longitude: 1); // Placeholder for actual longitude

    final api = DtrApi();
    final response = await api.submitDtr(request); // Awaiting the response

    if (response != null) {
      setState(() {
        if (clockType == "TIME_IN") {
          _clockInTime = DateFormat('HH:mm:ss').format(DateTime.now());
          _isClockedIn = true;
        } else {
          _clockOutTime = DateFormat('HH:mm:ss').format(DateTime.now());
          _isClockedIn = false;
        }
      });
      _showSnackBar(context,
          'Successfully ${clockType == "TIME_IN" ? "Clocked In" : "Clocked Out"}');
    } else {
      _showSnackBar(context,
          'Failed to ${clockType == "TIME_IN" ? "Clock In" : "Clock Out"}');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  String _formatTime(String? time) {
    return time ?? '--'; // If time is null, return '--'
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMMM d, y').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final currentDay =
        DayOfWeek.values[(_currentTime.toLocal().weekday - 1) % 7];

    return Stack(
      children: [
        // Background
        appBackground(dark: dark),
        Container(
          width: TDeviceUtils.getScreenWidth(context),
          height: 170,
          child: CustomPaint(
            painter:
                WavyBottomPainter(dark ? TColors.secondary : TColors.primary),
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
                                    _formatDate(_currentTime),
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
                                '${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}:${_currentTime.second.toString().padLeft(2, '0')}',
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
                              Text('Clock In',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              Text(_formatTime(_clockInTime),
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Clock Out',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              Text(_formatTime(_clockOutTime),
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _toggleClockInOut(context),
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0.0),
                              topRight: Radius.circular(0.0),
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
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
              Row(
                children: [
                  Icon(color: TColors.primary, Iconsax.notification),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Text('Announcement',
                      style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
