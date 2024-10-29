import 'package:flutter/material.dart';
import 'package:payroll_vade/utils/api/get_leave_api.dart';
import 'package:payroll_vade/utils/constants/colors.dart';
import 'package:payroll_vade/utils/dto/leave/employee_leave.dto.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:payroll_vade/utils/request/login_request.dart';

class SelfService extends StatefulWidget {
  final LoginRequest loginRequest;

  const SelfService({Key? key, required this.loginRequest}) : super(key: key);

  @override
  State<SelfService> createState() => _SelfServiceState();
}

class _SelfServiceState extends State<SelfService> {
  late Map<DateTime, List<Map<String, dynamic>>> _events = {};
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    const leaveColor = Colors.blue;
    String leaveType = "WHOLEDAY";

    final dynamic response =
        await GetLeaveApi().getLeave(loginRequest: widget.loginRequest);

    if (response != null) {
      // Assuming response is of type EmployeeLeaveDto
      final EmployeeLeaveDto leaveData = response;

      // Populate the events map with leave data
      for (var leave in leaveData.leaves) {
        // Parse startDate and endDate as DateTime
        DateTime startDate = DateTime.parse(leave.startDate);
        DateTime endDate = DateTime.parse(leave.endDate);

        // Iterate through the date range to add events for each day
        for (var day = startDate;
            day.isBefore(endDate) || day.isAtSameMomentAs(endDate);
            day = day.add(Duration(days: 1))) {
          _events.putIfAbsent(day, () => []).add({
            'type': leave.leaveType,
            'remarks': leave.remarks ?? 'No remarks',
            'color': leave.leaveType != leaveType
                ? leaveColor
                : TColors.secondary, // Use ternary operator here
          });
        }
      }
    }
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    DateTime normalizedDay = DateTime(day.year, day.month, day.day);
    return _events[normalizedDay] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  void _showEventDetails(BuildContext context, Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${event['type']} Event'),
          content: Text('Remarks: ${event['remarks']}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Self Service'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: _onDaySelected,
            eventLoader: _getEventsForDay,
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Events for ${_selectedDay.toLocal()}'.split(' ')[0],
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView(
              children: _getEventsForDay(_selectedDay).isNotEmpty
                  ? _getEventsForDay(_selectedDay).map((event) {
                      return GestureDetector(
                        onTap: () => _showEventDetails(context, event),
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: event['color'],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${event['type']}: ${event['remarks']}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }).toList()
                  : [
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'No events for this day',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
            ),
          ),
        ],
      ),
    );
  }
}
