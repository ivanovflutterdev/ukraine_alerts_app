import 'package:ukraine_alerts_app/features/alerts/domain/entities/region_entity.dart';

extension RegionsListExtension on List<RegionEntity> {
  RegionEntity? byUid(String uid) {
    try {
      return firstWhere((region) => region.uid == uid);
    } catch (_) {
      return null;
    }
  }
}
