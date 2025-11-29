// lib/widgets/amount_input_field.dart
import 'package:cashulator/cubit/amount.cubit.dart';
import 'package:flutter/material.dart';

class AmountInputField extends StatefulWidget {
  final double initial;
  final ValueChanged<double> onChanged;
  final AmountCubit amountCubit;

  const AmountInputField({
    super.key,
    required this.initial,
    required this.onChanged,
    required this.amountCubit,
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
    widget.amountCubit.set(widget.initial);
  }

  @override
  void didUpdateWidget(covariant AmountInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initial != widget.initial) {
      controller.text = widget.initial.toString();
      widget.amountCubit.set(widget.initial);
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
        widget.amountCubit.updateFromText(s);
        widget.onChanged(widget.amountCubit.state);
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
