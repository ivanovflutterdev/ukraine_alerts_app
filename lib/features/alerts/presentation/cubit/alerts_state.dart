import 'package:ukraine_alerts_app/features/alerts/domain/entities/alert_entity.dart';

abstract class AlertsState {
  const AlertsState();
}

class AlertsInitial extends AlertsState {
  const AlertsInitial();
}

class AlertsLoading extends AlertsState {
  const AlertsLoading();
}

class AlertsLoaded extends AlertsState {
  const AlertsLoaded({
    required this.alerts,
  });

  final List<AlertEntity> alerts;
}

class AlertsError extends AlertsState {
  const AlertsError(this.message);

  final String message;
}
