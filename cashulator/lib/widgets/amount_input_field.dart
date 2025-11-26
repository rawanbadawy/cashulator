import 'package:flutter/material.dart';

class AmountInputField extends StatefulWidget {
  final double initial;
  final ValueChanged<double> onChanged;

  const AmountInputField({
    super.key,
    required this.initial,
    required this.onChanged,
  });

  @override
  State<AmountInputField> createState() => _AmountInputFieldState();
}

class _AmountInputFieldState extends State<AmountInputField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initial.toString());
  }

  @override
  void didUpdateWidget(covariant AmountInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initial != widget.initial) {
      controller.text = widget.initial.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: const InputDecoration(
        labelText: 'Amount',
        border: OutlineInputBorder(),
      ),
      onChanged: (s) {
        final v = double.tryParse(s.replaceAll(',', '.')) ?? 0;
        widget.onChanged(v);
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
