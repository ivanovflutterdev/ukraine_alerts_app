import 'package:ukraine_alerts_app/features/alerts/domain/entities/alert_entity.dart';

sealed class RegionAlertsState {
  const RegionAlertsState();
}

class RegionAlertsInitial extends RegionAlertsState {
  const RegionAlertsInitial();
}

class RegionAlertsLoading extends RegionAlertsState {
  const RegionAlertsLoading();
}

class RegionAlertsLoaded extends RegionAlertsState {
  const RegionAlertsLoaded({
    required this.alert,
  });

  final AlertEntity alert;
}

class RegionAlertsError extends RegionAlertsState {
  const RegionAlertsError(this.message);

  final String message;
}
