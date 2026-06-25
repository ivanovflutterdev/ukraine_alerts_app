class ActiveAlertDto {
  const ActiveAlertDto({
    required this.locationTitle,
    required this.startedAt,
    required this.locationUid,
    required this.locationOblastUid,
    required this.alertType,
  });

  final String locationTitle;
  final String startedAt;
  final int locationUid;
  final int locationOblastUid;
  final String alertType;

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.parse(value);

    throw FormatException('Invalid int value: $value');
  }

  factory ActiveAlertDto.fromJson(Map<String, dynamic> json) {
    return ActiveAlertDto(
      locationTitle: json['location_title'] as String,
      startedAt: json['started_at'] as String,
      locationUid: _parseInt(json['location_uid']),
      locationOblastUid: _parseInt(json['location_oblast_uid']),
      alertType: json['alert_type'] as String,
    );
  }
}
