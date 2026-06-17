import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/app_state.dart';
import '../widgets/status_badge.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  void _submit() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    final state = context.read<AppState>();
    final success = await state.login(
      _emailController.text,
      _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (success) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      setState(() {
        _error = 'Vui lòng kiểm tra tài khoản và mật khẩu.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              const Text('Zeni', style: TextStyle(fontSize: 38, fontWeight: FontWeight.w800, color: Color(0xFF0052CC))),
              const SizedBox(height: 12),
              const Text('Đơn giản hóa cuộc sống số của bạn', style: TextStyle(fontSize: 16, color: Color(0xFF1F2937))),
              const SizedBox(height: 34),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [BoxShadow(color: const Color.fromRGBO(0, 0, 0, 0.08), blurRadius: 18, spreadRadius: 1)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Đăng nhập', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 18),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Mật khẩu', border: OutlineInputBorder()),
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 14),
                      Text(_error!, style: const TextStyle(color: Color(0xFFEF4444))),
                    ],
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0052CC),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('ĐĂNG NHẬP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Consumer<AppState>(builder: (context, state, child) {
                      return StatusBadge(
                        label: state.firebaseReady ? 'Firebase sẵn sàng' : 'Chế độ demo không dùng Firebase',
                        color: state.firebaseReady ? const Color(0xFF22C55E) : const Color(0xFFFBBF24),
                      );
                    }),
                  ],
                ),
              ),
              const Spacer(),
              const Text('Zeni App • Quản lý cân xe + báo cáo vận hành', style: TextStyle(color: Color(0xFF6B7280), fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
