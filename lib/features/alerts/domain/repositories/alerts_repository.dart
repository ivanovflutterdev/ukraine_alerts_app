
import 'package:ukraine_alerts_app/features/alerts/domain/entities/alert_entity.dart';

abstract class AlertsRepository {
  Future<List<AlertEntity>> getActiveAlerts();

  Future<AlertEntity> getRegionAlert(String regionUid);
}
