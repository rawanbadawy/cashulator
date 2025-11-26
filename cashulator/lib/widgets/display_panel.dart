import 'package:flutter/material.dart';

class DisplayPanel extends StatelessWidget {
  final String expression;
  final String result;

  const DisplayPanel({
    super.key,
    required this.expression,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            expression.isEmpty ? ' ' : expression,
            style: TextStyle(
              fontSize: 20,
              color: c.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          Text(
            result,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: c.onSurface,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
