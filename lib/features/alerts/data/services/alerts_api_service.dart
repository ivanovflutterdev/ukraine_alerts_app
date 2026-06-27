import 'package:dio/dio.dart';
import 'package:ukraine_alerts_app/core/constants/api_constants.dart';

class AlertsApiService {
  AlertsApiService(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> getActiveAlerts() async {
    final response = await _dio.get<Map<String, dynamic>>
    (ApiConstants.activeAlertsPath);

    return response.data!;
  }

  Future<String> getRegionAlertStatus(String regionUid) async {
    final response = await _dio.get<String>
    (ApiConstants.regionAlertPath(regionUid));

    return response.data!;
  }
}
