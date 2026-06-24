import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../services/app_state.dart';
import '../widgets/status_badge.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách lệnh'),
        backgroundColor: const Color(0xFF0052CC),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(18),
          itemCount: state.orders.length,
          itemBuilder: (context, index) {
            final order = state.orders[index];
            return _OrderCard(order: order);
          },
          separatorBuilder: (context, _) => const SizedBox(height: 14),
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: const Color.fromRGBO(0, 0, 0, 0.08), blurRadius: 16, spreadRadius: 1)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(order.id, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
              StatusBadge(label: order.statusLabel, color: order.statusColor),
            ],
          ),
          const SizedBox(height: 10),
          Text(order.customer, style: const TextStyle(fontSize: 14, color: Color(0xFF1F2937), fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [
              _InfoChip(label: 'Xe', value: order.licensePlate),
              const SizedBox(width: 8),
              _InfoChip(label: 'Sản phẩm', value: order.product),
            ],
          ),
          const SizedBox(height: 10),
          Text('${order.quantity} tấn', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(order.note, style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;

  const _InfoChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text('$label: $value', style: const TextStyle(fontSize: 13, color: Color(0xFF1F2937))),
    );
  }
}
