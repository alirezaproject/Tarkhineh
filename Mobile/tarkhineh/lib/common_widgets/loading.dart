import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  final String? message;
  const AppLoading({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(strokeWidth: 5, valueColor: const AlwaysStoppedAnimation(Color(0xFF2F6E4F))),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: const TextStyle(fontFamily: "Estedad", fontSize: 14, color: Color(0xFF2F6E4F)),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
