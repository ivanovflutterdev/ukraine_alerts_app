import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ukraine_alerts_app/core/constants/api_constants.dart';
import 'package:ukraine_alerts_app/features/alerts/data/repository/alerts_repository_impl.dart';
import 'package:ukraine_alerts_app/features/alerts/data/services/alerts_api_service.dart';
import 'package:ukraine_alerts_app/features/alerts/domain/repositories/alerts_repository.dart';
import 'package:ukraine_alerts_app/features/alerts/presentation/cubit/alerts_cubit.dart';
import 'package:ukraine_alerts_app/features/alerts/presentation/cubit/region_alerts_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: {'Authorization': 'Bearer ${ApiConstants.apiToken}'},
      ),
    ),
  );

  getIt.registerLazySingleton<AlertsApiService>(
    () => AlertsApiService(getIt<Dio>()),
  );

  getIt.registerLazySingleton<AlertsRepository>(
    () => AlertsRepositoryImpl(getIt<AlertsApiService>()),
  );

  getIt.registerFactory<AlertsCubit>(
    () => AlertsCubit(getIt<AlertsRepository>()),
  );
  getIt.registerFactory<RegionAlertsCubit>(
    () => RegionAlertsCubit(getIt<AlertsRepository>()),
  );
}
