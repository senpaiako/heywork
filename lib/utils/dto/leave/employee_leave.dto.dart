import 'package:payroll_vade/utils/dto/leave/leave_credit_dto.dart';
import 'package:payroll_vade/utils/dto/leave/leave_dto.dart';

class EmployeeLeaveDto {
  final List<LeaveCredit> credits;
  final List<Leave> leaves;

  EmployeeLeaveDto({required this.credits, required this.leaves});

  factory EmployeeLeaveDto.fromJson(Map<String, dynamic> json) {
    var creditsJson = json['credits'] as List;
    var leavesJson = json['leaves'] as List;

    List<LeaveCredit> creditsList =
        creditsJson.map((e) => LeaveCredit.fromJson(e)).toList();
    List<Leave> leavesList = leavesJson.map((e) => Leave.fromJson(e)).toList();

    return EmployeeLeaveDto(
      credits: creditsList,
      leaves: leavesList,
    );
  }
}
