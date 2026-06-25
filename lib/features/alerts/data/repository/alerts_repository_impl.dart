import 'package:ukraine_alerts_app/features/alerts/data/dto/active_alerts_response_dto.dart';
import 'package:ukraine_alerts_app/features/alerts/data/mappers/active_alert_mapper.dart';
import 'package:ukraine_alerts_app/features/alerts/data/services/alerts_api_service.dart';
import 'package:ukraine_alerts_app/features/alerts/domain/entities/alert_entity.dart';
import 'package:ukraine_alerts_app/features/alerts/domain/repositories/alerts_repository.dart';

class AlertsRepositoryImpl implements AlertsRepository {
  AlertsRepositoryImpl(this._apiService);

  final AlertsApiService _apiService;

  @override
  Future<List<AlertEntity>> getActiveAlerts() async {
    final json = await _apiService.getActiveAlerts();

    final dto = ActiveAlertsResponseDto.fromJson(json);

    return dto.alerts.map((alertDto) => alertDto.toEntity()).toList();
  }

  @override
  Future<AlertEntity> getRegionAlert(String regionUid) {
    throw UnimplementedError();
  }
}
