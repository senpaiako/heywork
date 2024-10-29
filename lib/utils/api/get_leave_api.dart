import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:payroll_vade/utils/dto/account_dto.dart';
import 'package:payroll_vade/utils/dto/leave/employee_leave.dto.dart';
import 'package:payroll_vade/utils/http/http_client.dart';
import 'package:payroll_vade/utils/request/login_request.dart';

class GetLeaveApi {
  Future<dynamic> getLeave({required LoginRequest loginRequest}) async {
    String url =
        '${ServerUtilities.server}/leave?mobileNo=${loginRequest.mobileNo}&password=${loginRequest.password}';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      switch (response.statusCode) {
        case 200:
        case 201:
          final Map<String, dynamic> jsonResponse =
              jsonDecode(utf8.decode(response.bodyBytes));
          return EmployeeLeaveDto.fromJson(jsonResponse);
        case 400:
        case 401:
          return null;
        case 500:
        case 501:
        case 502:
          return null;
        default:
          return null;
      }
    } on SocketException {
      return null;
    } on FormatException {
      return null;
    } on HttpException {
      return null;
    }
  }
}
