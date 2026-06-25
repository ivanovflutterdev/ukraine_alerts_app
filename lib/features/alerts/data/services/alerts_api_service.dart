import 'package:dio/dio.dart';
import 'package:ukraine_alerts_app/core/constants/api_constants.dart';

class AlertsApiService {
  AlertsApiService(this._dio);

  final Dio _dio;

Future<Map<String, dynamic>> getActiveAlerts() async {
  final response = await _dio.get(
    ApiConstants.activeAlertsPath,
  );

  return response.data as Map<String, dynamic>;
}

  Future<String> getRegionAlertStatus(String regionUid) {
    throw UnimplementedError();
  }
}
