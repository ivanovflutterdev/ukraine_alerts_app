
class ApiConstants {
  static const String baseUrl = 'https://api.alerts.in.ua';
  static const String apiToken = '89f7fd8b8eb24e67113b985852c3e087239724a4ab2203';

  static const String activeAlertsPath = '/v1/alerts/active.json';
  static String regionAlertPath(String uid) {
    return '/v1/iot/active_air_raid_alerts/$uid.json';
  }
}
