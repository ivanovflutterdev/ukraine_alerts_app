import 'package:flutter/material.dart';

enum AlertStatus { initial, loading, noAlert, alert }

class RegionAlertsScreen extends StatelessWidget {
  const RegionAlertsScreen({super.key});

  final AlertStatus status = AlertStatus.initial;

  bool get hasAlert => status == AlertStatus.alert;

  bool get isLoading => status == AlertStatus.loading;

  bool get isInitial => status == AlertStatus.initial;

  @override
  Widget build(BuildContext context) {
    final appBarColor = switch (status) {
      AlertStatus.initial => const Color(0xFFC7ECFA),
      AlertStatus.loading => const Color(0xFFC7ECFA),
      AlertStatus.noAlert => const Color(0xFF55C982),
      AlertStatus.alert => const Color(0xFFC75A5A),
    };

    final backgroundDecoration = switch (status) {
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Region Alerts',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isInitial || isLoading ? Colors.black87 : Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: isInitial || isLoading ? Colors.black87 : Colors.white,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
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
              child: DropdownMenu<String>(
                width: MediaQuery.of(context).size.width - 32,
                enableSearch: true,
                enableFilter: true,
                hintText: 'Оберіть місто або регіон',
                leadingIcon: const Icon(Icons.search),

                inputDecorationTheme: const InputDecorationTheme(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),

                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: 'kyiv', label: 'Київ'),
                  DropdownMenuEntry(
                    value: 'kharkiv',
                    label: 'Харківська область',
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(child: _StatusContent(status: status)),
            ),
          ],
        ),
      ),
    );
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
              color: Colors.white.withOpacity(0.85),
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
