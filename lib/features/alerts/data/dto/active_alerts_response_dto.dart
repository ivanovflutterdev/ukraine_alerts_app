import 'package:ukraine_alerts_app/features/alerts/data/dto/active_alert_dto.dart';

class ActiveAlertsResponseDto {
  const ActiveAlertsResponseDto({
    required this.alerts,
  });

  factory ActiveAlertsResponseDto.fromJson(
    Map<String, dynamic> json,
  ) {
    return ActiveAlertsResponseDto(
      alerts: (json['alerts'] as List<dynamic>)
          .map(
            (item) => ActiveAlertDto.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }

  final List<ActiveAlertDto> alerts;
}
