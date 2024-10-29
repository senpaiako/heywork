class LeaveCredit {
  final int id;
  final String type;
  final double available;

  LeaveCredit({required this.id, required this.type, required this.available});

  factory LeaveCredit.fromJson(Map<String, dynamic> json) {
    return LeaveCredit(
      id: json['id'],
      type: json['type'],
      available: json['available'],
    );
  }
}
