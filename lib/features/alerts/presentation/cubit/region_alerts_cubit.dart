import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ukraine_alerts_app/features/alerts/domain/repositories/alerts_repository.dart';
import 'package:ukraine_alerts_app/features/alerts/presentation/cubit/region_alerts_state.dart';

class RegionAlertsCubit extends Cubit<RegionAlertsState> {
  RegionAlertsCubit(this._repository) : super(const RegionAlertsInitial());

  final AlertsRepository _repository;

  Future<void> loadRegionAlert(String regionUid) async {
    emit(const RegionAlertsLoading());

    try {
      final alert = await _repository.getRegionAlert(regionUid);

      emit(RegionAlertsLoaded(alert: alert));
    } catch (error) {
      emit(RegionAlertsError(error.toString()));
    }
  }
}
