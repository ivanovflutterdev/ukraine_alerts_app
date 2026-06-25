import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ukraine_alerts_app/features/alerts/domain/repositories/alerts_repository.dart';
import 'package:ukraine_alerts_app/features/alerts/presentation/cubit/alerts_state.dart';

class AlertsCubit extends Cubit<AlertsState> {
  AlertsCubit(this._repository) : super(const AlertsInitial());

  final AlertsRepository _repository;

  Future<void> loadActiveAlerts() async {
    emit(const AlertsLoading());

    try {
      final alerts = await _repository.getActiveAlerts();

      emit(AlertsLoaded(alerts: alerts));
    } catch (error) {
      emit(
        AlertsError(
          error.toString(),
        ),
      );
    }
  }
}
