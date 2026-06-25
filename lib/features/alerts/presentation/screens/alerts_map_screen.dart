import 'package:flutter/material.dart';
import 'package:ukraine_alerts_app/features/alerts/presentation/widgets/alerts_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ukraine_alerts_app/core/di/service_locator.dart';
import 'package:ukraine_alerts_app/features/alerts/presentation/cubit/alerts_cubit.dart';
import 'package:ukraine_alerts_app/features/alerts/presentation/cubit/alerts_state.dart';

class AlertsMapScreen extends StatelessWidget {
  const AlertsMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AlertsCubit>()..loadActiveAlerts(),
      child: Scaffold(
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
              onPressed: () {},
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
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/images/map/ukraine_map.png',
                          fit: BoxFit.contain,
                        ),
                        Image.asset(
                          'assets/images/map/overlays/Krym.png',
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                child: BlocBuilder<AlertsCubit, AlertsState>(
                  builder: (context, state) {
                    if (state is AlertsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is AlertsError) {
                      return Center(child: Text(state.message));
                    }

                    if (state is AlertsLoaded) {
                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        itemCount: state.alerts.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final alert = state.alerts[index];

                          return AlertCard(
                            title: alert.regionName,
                            description: 'Active air raid alert',
                            icon: Icons.warning_amber_rounded,
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
      ),
    );
  }
}
