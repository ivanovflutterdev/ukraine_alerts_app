import 'package:ukraine_alerts_app/features/alerts/data/dto/active_alert_dto.dart';
import 'package:ukraine_alerts_app/features/alerts/domain/entities/alert_entity.dart';

extension ActiveAlertMapper on ActiveAlertDto {
  AlertEntity toEntity() {
    return AlertEntity(
      regionName: locationTitle,
      isActive: true,
      alertStartedAt: DateTime.tryParse(startedAt),
    );
  }
}
