import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ukraine_alerts_app/core/di/service_locator.dart';
import 'package:ukraine_alerts_app/features/alerts/presentation/cubit/alerts_cubit.dart';
import 'package:ukraine_alerts_app/features/alerts/presentation/cubit/alerts_state.dart';
import 'package:ukraine_alerts_app/features/alerts/presentation/helpers/region_overlay_helper.dart';
import 'package:ukraine_alerts_app/features/alerts/presentation/widgets/alerts_card.dart';

class AlertsMapScreen extends StatelessWidget {
  const AlertsMapScreen({super.key});
  String _formatAlertDate(DateTime dateTime) {
  final local = dateTime.toLocal();

  final months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  final month = months[local.month - 1];
  final day = local.day;
  final year = local.year;
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  final second = local.second.toString().padLeft(2, '0');

  return '$month $day, $year $hour:$minute:$second';
}

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AlertsCubit>()..loadActiveAlerts(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFC7ECFA),
              centerTitle: true,
              elevation: 0,
              title: const Text(
                'Alerts Map',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<AlertsCubit>().loadActiveAlerts();
                  },
                  icon: const Icon(Icons.refresh, color: Colors.black87),
                ),
              ],
            ),
            body: Container(
              width: double.infinity,
              color: const Color(0xFFAEE3F8),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1.45,
                    child: ClipRect(
                      child: InteractiveViewer(
                        minScale: 1,
                        maxScale: 4,
                        child: BlocBuilder<AlertsCubit, AlertsState>(
                          builder: (context, state) {
                            final overlays = <Widget>[];

                            if (state is AlertsLoaded) {
                              for (final alert in state.alerts) {
                                final overlayAsset =
                                    RegionOverlayHelper.getOverlay(
                                      alert.regionName,
                                    );

                                if (overlayAsset != null) {
                                  overlays.add(
                                    Image.asset(
                                      overlayAsset,
                                      fit: BoxFit.contain,
                                    ),
                                  );
                                }
                              }
                            }

                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  'assets/images/map/ukraine_map.png',
                                  fit: BoxFit.contain,
                                ),
                                ...overlays,
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: BlocBuilder<AlertsCubit, AlertsState>(
                      builder: (context, state) {
                        if (state is AlertsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is AlertsError) {
                          return Center(child: Text(state.message));
                        }

                        if (state is AlertsLoaded) {
                          return ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                            itemCount: state.alerts.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final alert = state.alerts[index];

                              return AlertCard(
                                title: alert.regionName,
                                description: alert.alertStartedAt == null
                                    ? ''
                                    : _formatAlertDate(alert.alertStartedAt!),
                                icon: Icons.warning_amber,
                              );
                            },
                          );
                        }

                        return const SizedBox.shrink();
                      },
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
}
