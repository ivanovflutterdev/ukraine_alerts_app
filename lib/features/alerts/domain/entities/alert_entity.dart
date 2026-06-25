
class AlertEntity {
  const AlertEntity({
    required this.regionName,
    required this.isActive,
    this.alertStartedAt,
  });

  final String regionName;
  final bool isActive;
  final DateTime? alertStartedAt;
}
