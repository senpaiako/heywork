class ChangePasswordRequest {
  final String mobileNo;
  final String password;
  final String oldPassword;
  final String newPassword;

  ChangePasswordRequest({
    required this.mobileNo,
    required this.password,
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'mobileNo': mobileNo,
      'password': password,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }
}
