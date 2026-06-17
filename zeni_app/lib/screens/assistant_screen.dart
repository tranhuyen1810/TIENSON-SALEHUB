import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/app_state.dart';

class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  final _controller = TextEditingController();
  bool _isSending = false;

  void _send() async {
    if (_controller.text.trim().isEmpty) return;
    setState(() => _isSending = true);
    await context.read<AppState>().sendMessage(_controller.text.trim());
    _controller.clear();
    setState(() => _isSending = false);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trợ lý AI Zeni'),
        backgroundColor: const Color(0xFF0052CC),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  final message = state.messages[index];
                  final isUser = message.author != 'Zeni AI';
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isUser ? const Color(0xFF0052CC) : const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: const Color.fromRGBO(0, 0, 0, 0.06), blurRadius: 10, spreadRadius: 1)],
                        ),
                        child: Text(
                          message.text,
                          style: TextStyle(color: isUser ? Colors.white : const Color(0xFF1F2937), fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Hỏi Zeni AI về báo cáo, lệnh, hoặc hỗ trợ vận hành...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _isSending ? null : _send,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0052CC),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      minimumSize: const Size(52, 52),
                    ),
                    child: _isSending ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
