import 'package:flutter/material.dart';
import 'package:ukraine_alerts_app/features/alerts/data/dto/active_alerts_response_dto.dart';
import 'package:ukraine_alerts_app/features/alerts/data/mappers/active_alert_mapper.dart';
import 'package:ukraine_alerts_app/features/alerts/data/services/alerts_api_service.dart';
import 'package:ukraine_alerts_app/features/alerts/domain/entities/alert_entity.dart';
import 'package:ukraine_alerts_app/features/alerts/domain/entities/regions_extensions.dart';
import 'package:ukraine_alerts_app/features/alerts/domain/entities/regions_list.dart';
import 'package:ukraine_alerts_app/features/alerts/domain/repositories/alerts_repository.dart';

class AlertsRepositoryImpl implements AlertsRepository {
  AlertsRepositoryImpl(this._apiService);

  final AlertsApiService _apiService;

  @override
  Future<List<AlertEntity>> getActiveAlerts() async {
    final json = await _apiService.getActiveAlerts();

    final dto = ActiveAlertsResponseDto.fromJson(json);

    final alerts = dto.alerts.map((alertDto) => alertDto.toEntity()).toList();

    final uniqueAlerts = <String, AlertEntity>{};

    for (final alert in alerts) {
      uniqueAlerts[alert.regionName] = alert;
    }

    return uniqueAlerts.values.toList();
  }

  @override
  Future<AlertEntity> getRegionAlert(String regionUid) async {
    final status = await _apiService.getRegionAlertStatus(regionUid);
    final normalizedStatus = status.replaceAll('"', '');

    final region = regionsList.byUid(regionUid);
    debugPrint('REGION UID: $regionUid');
debugPrint('REGION STATUS: $status');
debugPrint('NORMALIZED STATUS: $normalizedStatus');

    return AlertEntity(
      regionName: region?.name ?? 'Unknown region',
      isActive: normalizedStatus == 'A' || normalizedStatus == 'P',
      alertStartedAt: null,
    );
  }
}
