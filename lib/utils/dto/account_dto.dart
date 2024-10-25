import 'package:payroll_vade/utils/dto/employees_dto.dart';
import 'package:payroll_vade/utils/dto/timecard_dto.dart';

class AccountDto {
  final String? lastLogin;
  final List<TimecardDto> timecard;
  final List<EmployeeDto> employees;
  final String companyCode;
  final String? image;
  final String employeeName;

  AccountDto({
    this.lastLogin,
    required this.timecard,
    required this.employees,
    required this.companyCode,
    this.image,
    required this.employeeName,
  });

  factory AccountDto.fromJson(Map<String, dynamic> json) {
    var timecardList = (json['timecard'] as List)
        .map((item) => TimecardDto.fromJson(item))
        .toList();

    var employeeList = (json['employees'] as List)
        .map((item) => EmployeeDto.fromJson(item))
        .toList();

    return AccountDto(
      lastLogin: json['lastLogin'],
      timecard: timecardList,
      employees: employeeList,
      companyCode: json['companyCode'],
      image: json['image'],
      employeeName: json['employeeName'],
    );
  }
  @override
  String toString() {
    return 'AccountDto(lastLogin: $lastLogin, timecard: $timecard, employees: $employees, companyCode: $companyCode, image: $image, employeeName: $employeeName)';
  }
}
