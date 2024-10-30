class DtrRequest {
  final String mobileNo;
  final String password;
  final String type;
  final double latitude;
  final double longitude;

  DtrRequest({
    required this.mobileNo,
    required this.password,
    required this.type,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'mobileNo': mobileNo,
      'password': password,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  String toString() {
    return 'DtrRequest(mobileNo: $mobileNo, password: $password, type: $type, latitude: $latitude, longitude: $longitude)';
  }
}
