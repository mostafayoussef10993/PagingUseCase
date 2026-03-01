import 'package:flutter/material.dart';

class AuthErrorMessage extends StatelessWidget {
  final String? error;

  const AuthErrorMessage({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    if (error == null || error!.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(error!, style: TextStyle(color: Colors.red.shade800)),
          ),
        ],
      ),
    );
  }
}
