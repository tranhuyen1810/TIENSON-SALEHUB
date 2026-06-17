import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/app_state.dart';
import '../widgets/status_badge.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: const Color(0xFF0052CC),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () => Navigator.pushNamed(context, '/assistant'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              state.logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Xin chào,', style: TextStyle(fontSize: 18, color: Color(0xFF6B7280))),
              const SizedBox(height: 6),
              Text(state.userName, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF1F2937))),
              const SizedBox(height: 22),
              Row(
                children: const [
                  StatusBadge(label: 'Sản lượng hôm nay', color: Color(0xFF3B82F6)),
                  SizedBox(width: 10),
                  StatusBadge(label: 'Lệnh chờ cân', color: Color(0xFFFBBF24)),
                ],
              ),
              const SizedBox(height: 18),
              Expanded(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 1.1,
                  ),
                  children: [
                    _StatCard(title: 'Sản lượng hôm nay', value: '${state.todaysQuantity.toStringAsFixed(1)} tấn', color: const Color(0xFF0052CC)),
                    _StatCard(title: 'Số xe hoạt động', value: '${state.activeVehicles}', color: const Color(0xFF22C55E)),
                    _StatCard(title: 'Lệnh hôm nay', value: '${state.todaysOrders}', color: const Color(0xFF3B82F6)),
                    _StatCard(title: 'Chờ cân', value: '${state.waitingOrders}', color: const Color(0xFFFBBF24)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/orders'),
                icon: const Icon(Icons.list_alt_outlined),
                label: const Text('Xem danh sách lệnh'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  backgroundColor: const Color(0xFF0052CC),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create_order'),
        backgroundColor: const Color(0xFF0052CC),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: const Color.fromRGBO(0, 0, 0, 0.08), blurRadius: 16, spreadRadius: 1)],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280), fontWeight: FontWeight.w600)),
          const Spacer(),
          Text(value, style: TextStyle(fontSize: 28, color: color, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
