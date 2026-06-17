import 'package:flutter/material.dart';

enum OrderStatus { waiting, weighedIn, weighedOut, completed, error }

class Order {
  final String id;
  final String customer;
  final String licensePlate;
  final String product;
  final double quantity;
  final OrderStatus status;
  final String note;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.customer,
    required this.licensePlate,
    required this.product,
    required this.quantity,
    required this.status,
    required this.note,
    required this.createdAt,
  });

  String get statusLabel {
    switch (status) {
      case OrderStatus.waiting:
        return 'CHỜ CÂN';
      case OrderStatus.weighedIn:
        return 'CÂN VÀO';
      case OrderStatus.weighedOut:
        return 'CÂN RA';
      case OrderStatus.completed:
        return 'HOÀN TẤT';
      case OrderStatus.error:
        return 'LỖI';
    }
  }

  Color get statusColor {
    switch (status) {
      case OrderStatus.waiting:
        return const Color(0xFFFBBF24);
      case OrderStatus.weighedIn:
        return const Color(0xFF3B82F6);
      case OrderStatus.weighedOut:
        return const Color(0xFFA855F7);
      case OrderStatus.completed:
        return const Color(0xFF22C55E);
      case OrderStatus.error:
        return const Color(0xFFEF4444);
    }
  }
}
