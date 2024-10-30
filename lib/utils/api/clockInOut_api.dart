import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:payroll_vade/utils/http/http_client.dart';
import 'package:payroll_vade/utils/request/dtr_request.dart';

class DtrApi {
  Future<String?> submitDtr(DtrRequest request) async {
    String url = '${ServerUtilities.server}/dtr';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(request.toJson()),
      );
      if (response.statusCode == 200) {
        return response.body; // Handle response as needed
      } else {
        return null; // Handle non-200 responses appropriately
      }
    } catch (e) {
      print('Error: $e'); // Log the error or handle it as needed
      return null; // Handle error appropriately
    }
  }
}
