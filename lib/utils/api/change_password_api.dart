import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:payroll_vade/utils/http/http_client.dart';
import 'package:payroll_vade/utils/request/change_password_request.dart';

class ChangePasswordApi {
  Future<dynamic> changePassword({
    required ChangePasswordRequest changePasswordRequest,
  }) async {
    String url = '${ServerUtilities.server}/changePassword';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(changePasswordRequest.toJson()),
      );

      // Debugging: Print out the response content type and body for examination
      print('Response Content-Type: ${response.headers['content-type']}');
      print('Response Body: ${response.body}');

      // Check content type to confirm if the response is JSON
      if (response.headers['content-type']?.contains('application/json') ??
          false) {
        final dynamic jsonResponse =
            jsonDecode(utf8.decode(response.bodyBytes));
        switch (response.statusCode) {
          case 200:
            return jsonResponse;
          case 201:
            return jsonResponse;
          case 400:
          case 401:
            return jsonResponse['message'] ?? 'Authorization error';
          case 500:
          case 501:
          case 502:
            return jsonResponse['message'] ??
                'Server error. Please try again later.';
          default:
            return 'Unexpected error. Please try again.';
        }
      } else {
        // If response is not JSON, return raw body as a fallback
        return response.body;
      }
    } on SocketException {
      return 'No Internet connection. Please check your connection and try again.';
    } on FormatException catch (e) {
      print('FormatException: $e');
      return 'Received an unexpected response format from the server.';
    } on HttpException {
      return 'HTTP exception occurred while processing the request.';
    }
  }
}
