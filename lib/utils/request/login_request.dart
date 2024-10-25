class LoginRequest {
  final String mobileNo;
  final String password;

  LoginRequest({
    required this.mobileNo,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': mobileNo,
      'password': password,
    };
  }
}
