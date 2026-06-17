import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../firebase_options.dart';
import '../models/order.dart';
import 'ai_service.dart';

class ChatMessage {
  final String author;
  final String text;
  final DateTime createdAt;

  ChatMessage({
    required this.author,
    required this.text,
    required this.createdAt,
  });
}

class AppState extends ChangeNotifier {
  bool firebaseReady = false;
  bool isLoggedIn = false;
  String userName = 'Quản lý';

  List<Order> orders = [
    Order(
      id: 'LH-20260617-001',
      customer: 'Công ty Tiên Sơn',
      licensePlate: '29A-12345',
      product: 'Xi măng PCB40',
      quantity: 28.5,
      status: OrderStatus.waiting,
      note: 'Giao hàng theo tuyến nội bộ',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Order(
      id: 'LH-20260617-002',
      customer: 'Công ty ABC',
      licensePlate: '75C-67890',
      product: 'Xi măng PCB30',
      quantity: 32.0,
      status: OrderStatus.weighedIn,
      note: 'Xe cân vào tại 09:14',
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    Order(
      id: 'LH-20260616-019',
      customer: 'Cửa hàng X',
      licensePlate: '43B-11122',
      product: 'Xi măng Tiên Sơn',
      quantity: 15.0,
      status: OrderStatus.completed,
      note: 'Đã hoàn tất giao hàng',
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    ),
  ];

  final List<ChatMessage> messages = [
    ChatMessage(
      author: 'Zeni AI',
      text: 'Xin chào! Tôi là trợ lý Zeni. Hãy hỏi tôi về báo cáo, lệnh cân hoặc hỗ trợ vận hành.',
      createdAt: DateTime.now(),
    ),
  ];

  int get todaysOrders => orders.where((order) {
        return order.createdAt.day == DateTime.now().day &&
            order.createdAt.month == DateTime.now().month &&
            order.createdAt.year == DateTime.now().year;
      }).length;

  double get todaysQuantity => orders
      .where((order) {
        return order.createdAt.day == DateTime.now().day &&
            order.createdAt.month == DateTime.now().month &&
            order.createdAt.year == DateTime.now().year;
      })
      .fold(0.0, (value, order) => value + order.quantity);

  int get waitingOrders =>
      orders.where((order) => order.status == OrderStatus.waiting).length;

  int get activeVehicles =>
      orders.where((order) => order.status != OrderStatus.completed).length;

  Future<void> initialize() async {
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      try {
        await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
        firebaseReady = true;
      } catch (_) {
        firebaseReady = false;
      }
    }
  }

  Future<bool> login(String email, String password) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      return false;
    }
    if (firebaseReady) {
      try {
        // TODO: Connect Firebase Authentication here.
        await Future<void>.delayed(const Duration(milliseconds: 300));
      } catch (_) {
        return false;
      }
    }
    userName = email.split('@').first;
    isLoggedIn = true;
    notifyListeners();
    return true;
  }

  void logout() {
    isLoggedIn = false;
    notifyListeners();
  }

  void addOrder(Order order) {
    orders.insert(0, order);
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    final sent = ChatMessage(author: userName, text: text, createdAt: DateTime.now());
    messages.add(sent);
    notifyListeners();
    final response = await AiService.reply(text);
    messages.add(ChatMessage(author: 'Zeni AI', text: response, createdAt: DateTime.now()));
    notifyListeners();
  }
}
