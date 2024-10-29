import 'dart:convert';
import 'dart:typed_data';

Uint8List? decodeImage(String? base64String) {
  if (base64String != null) {
    try {
      return base64Decode(base64String);
    } catch (e) {
      print("Error decoding image: $e");
    }
  }
  return null;
}
