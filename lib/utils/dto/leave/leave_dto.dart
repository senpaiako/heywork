import 'package:payroll_vade/utils/dto/leave/leave_credit_dto.dart';

class Leave {
  final int id;
  final String startDate;
  final String endDate;
  final LeaveCredit leaveCredit;
  final String? remarks;
  final String status;
  final String leaveType;
  final String? startTime;
  final String? endTime;

  Leave({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.leaveCredit,
    this.remarks,
    required this.status,
    required this.leaveType,
    this.startTime,
    this.endTime,
  });

  factory Leave.fromJson(Map<String, dynamic> json) {
    return Leave(
      id: json['id'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      leaveCredit: LeaveCredit.fromJson(json['leaveCredit']),
      remarks: json['remarks'],
      status: json['status'],
      leaveType: json['leaveType'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }
}
