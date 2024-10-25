class TimecardDto {
  final String date;
  final String? inTime;
  final String? outTime;
  final bool legal;
  final bool special;
  final bool sunday;
  final bool saturday;
  final double? total;
  final bool onLeave;

  TimecardDto({
    required this.date,
    this.inTime,
    this.outTime,
    required this.legal,
    required this.special,
    required this.sunday,
    required this.saturday,
    this.total,
    required this.onLeave,
  });

  factory TimecardDto.fromJson(Map<String, dynamic> json) {
    return TimecardDto(
      date: json['date'],
      inTime: json['in'],
      outTime: json['out'],
      legal: json['legal'],
      special: json['special'],
      sunday: json['sunday'],
      saturday: json['saturday'],
      total: json['total'],
      onLeave: json['onLeave'],
    );
  }
  @override
  String toString() {
    return 'TimecardDto(date: $date, inTime: $inTime, outTime: $outTime, '
        'legal: $legal, special: $special, sunday: $sunday, '
        'saturday: $saturday, total: $total, onLeave: $onLeave)';
  }
}
