class EmployeeDto {
  final String name;
  final String? inTime;
  final String? outTime;
  final bool onLeave;

  EmployeeDto({
    required this.name,
    this.inTime,
    this.outTime,
    required this.onLeave,
  });

  factory EmployeeDto.fromJson(Map<String, dynamic> json) {
    return EmployeeDto(
      name: json['name'],
      inTime: json['in'],
      outTime: json['out'],
      onLeave: json['onLeave'],
    );
  }
}
