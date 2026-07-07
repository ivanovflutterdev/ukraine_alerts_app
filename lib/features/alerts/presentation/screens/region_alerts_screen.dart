import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ukraine_alerts_app/core/di/service_locator.dart';
import 'package:ukraine_alerts_app/features/alerts/domain/entities/region_entity.dart';
import 'package:ukraine_alerts_app/features/alerts/domain/entities/regions_list.dart';
import 'package:ukraine_alerts_app/features/alerts/presentation/cubit/region_alerts_cubit.dart';
import 'package:ukraine_alerts_app/features/alerts/presentation/cubit/region_alerts_state.dart';

enum AlertStatus { initial, loading, noAlert, alert }

class RegionAlertsScreen extends StatefulWidget {
  const RegionAlertsScreen({super.key});

  @override
  State<RegionAlertsScreen> createState() => _RegionAlertsScreenState();
}

class _RegionAlertsScreenState extends State<RegionAlertsScreen> {
  RegionEntity? _selectedRegion;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RegionAlertsCubit>(),
      child: BlocBuilder<RegionAlertsCubit, RegionAlertsState>(
        builder: (context, state) {
          final status = _mapStateToStatus(state);
          final isInitialOrLoading =
              status == AlertStatus.initial || status == AlertStatus.loading;

          final appBarColor = _getAppBarColor(status);
          final backgroundDecoration = _getBackgroundDecoration(status);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: appBarColor,
              centerTitle: true,
              elevation: 0,
              title: Text(
                'Region Alerts',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isInitialOrLoading ? Colors.black87 : Colors.white,
                ),
              ),
              iconTheme: IconThemeData(
                color: isInitialOrLoading ? Colors.black87 : Colors.white,
              ),
              actions: [
                IconButton(
                  onPressed: _selectedRegion == null
                      ? null
                      : () {
                          context
                              .read<RegionAlertsCubit>()
                              .loadRegionAlert(_selectedRegion!.uid);
                        },
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            body: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              decoration: backgroundDecoration,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: DropdownMenu<RegionEntity>(
                      width: MediaQuery.of(context).size.width - 32,
                      enableSearch: true,
                      enableFilter: true,
                      hintText: 'Оберіть місто або регіон',
                      leadingIcon: const Icon(Icons.search),
                      onSelected: (region) {
                        if (region == null) return;

                        setState(() {
                          _selectedRegion = region;
                        });

                        context
                            .read<RegionAlertsCubit>()
                            .loadRegionAlert(region.uid);
                      },
                      inputDecorationTheme: const InputDecorationTheme(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      dropdownMenuEntries: regionsList.map((region) {
                        return DropdownMenuEntry<RegionEntity>(
                          value: region,
                          label: region.name,
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: _StatusContent(status: status),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AlertStatus _mapStateToStatus(RegionAlertsState state) {
    return switch (state) {
      RegionAlertsInitial() => AlertStatus.initial,
      RegionAlertsLoading() => AlertStatus.loading,
      RegionAlertsLoaded(:final alert) =>
        alert.isActive ? AlertStatus.alert : AlertStatus.noAlert,
      RegionAlertsError() => AlertStatus.initial,
    };
  }

  Color _getAppBarColor(AlertStatus status) {
    return switch (status) {
      AlertStatus.initial || AlertStatus.loading => const Color(0xFFC7ECFA),
      AlertStatus.noAlert => const Color(0xFF55C982),
      AlertStatus.alert => const Color(0xFFC75A5A),
    };
  }

  BoxDecoration _getBackgroundDecoration(AlertStatus status) {
    return switch (status) {
      AlertStatus.initial || AlertStatus.loading => const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 116, 183, 228),
              Color.fromARGB(255, 186, 229, 247),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      AlertStatus.noAlert => const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00A85A), Color(0xFF65F06E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      AlertStatus.alert => const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB00000), Color(0xFFFF2B2B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
    };
  }
}

class _StatusContent extends StatelessWidget {
  const _StatusContent({required this.status});

  final AlertStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case AlertStatus.initial:
        return Transform.translate(
          offset: const Offset(0, -100),
          child: Opacity(
            opacity: 0.5,
            child: Center(
              child: Image.asset(
                'assets/images/map/city.png',
                width: 380,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );

      case AlertStatus.loading:
        return const CircularProgressIndicator(color: Colors.white);

      case AlertStatus.noAlert:
        return const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 120, color: Color(0xFF00FF1A)),
            SizedBox(height: 16),
            Text(
              'Немає тривоги',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );

      case AlertStatus.alert:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.notifications_active_rounded,
              size: 120,
              color: Colors.white.withValues(alpha: 0.85),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Повітряна тривога! Будь ласка, пройдіть до укриття',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
    }
  }
}
