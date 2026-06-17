import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../services/app_state.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerController = TextEditingController();
  final _licenseController = TextEditingController();
  final _driverController = TextEditingController();
  final _productController = TextEditingController();
  final _quantityController = TextEditingController();
  final _noteController = TextEditingController();
  String _selectedArea = 'Nội thành';

  void _saveOrder() {
    if (!_formKey.currentState!.validate()) return;
    final state = context.read<AppState>();
    final order = Order(
      id: 'LH-${DateTime.now().millisecondsSinceEpoch}',
      customer: _customerController.text.trim(),
      licensePlate: _licenseController.text.trim(),
      product: _productController.text.trim(),
      quantity: double.tryParse(_quantityController.text.trim()) ?? 0,
      status: OrderStatus.waiting,
      note: _noteController.text.trim().isEmpty ? 'Chờ cân' : _noteController.text.trim(),
      createdAt: DateTime.now(),
    );
    state.addOrder(order);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo lệnh mới'),
        backgroundColor: const Color(0xFF0052CC),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildField(label: 'Khách hàng', controller: _customerController),
                const SizedBox(height: 14),
                _buildField(label: 'Biển số xe', controller: _licenseController),
                const SizedBox(height: 14),
                _buildField(label: 'Lái xe', controller: _driverController),
                const SizedBox(height: 14),
                _buildField(label: 'Loại sản phẩm', controller: _productController, hintText: 'Ví dụ: PCB30, PCB40'),
                const SizedBox(height: 14),
                _buildField(label: 'Số lượng dự kiến (tấn)', controller: _quantityController, keyboardType: TextInputType.number),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  initialValue: _selectedArea,
                  decoration: const InputDecoration(labelText: 'Địa bàn', border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(value: 'Nội thành', child: Text('Nội thành')),
                    DropdownMenuItem(value: 'Ngoại thành', child: Text('Ngoại thành')),
                    DropdownMenuItem(value: 'Vùng lân cận', child: Text('Vùng lân cận')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedArea = value);
                    }
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _noteController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Ghi chú',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _saveOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0052CC),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('LƯU LỆNH', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) => value == null || value.trim().isEmpty ? 'Vui lòng nhập $label' : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
