import 'package:cashulator/cubit/conv_display.cubit.dart';
import 'package:cashulator/widgets/commonWidgets/keypad_button.widget.dart';
import 'package:flutter/material.dart';

class ConvertorKeypadWidget extends StatelessWidget {
  const ConvertorKeypadWidget({
    super.key,
    required this.currentText,
    required this.convDisplayCubit,
  });

  final String currentText;
  final ConvDisplayCubit convDisplayCubit;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    final Color opBg =
        dark ? const Color(0xFF2A2A2A) : const Color(0xFFEFEFEF);
    final Color numBg =
        dark ? const Color(0xFF1E1E1E) : const Color(0xFFF2F2F2);
    final Color clearBg = const Color(0xFFFF5A5A);
    final Color numFg =
        dark ? const Color(0xFFD1D5DB) : const Color(0xFF6B7280);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          // Row 1: Big C
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KeypadButtonWidget(
                bgcolor: clearBg,
                frcolor: Colors.white,
                content: 'C',
                width: 300,
                height: 74,
                onTap: () {
                  convDisplayCubit.clearFromAmount();
                },
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Row 2: 7 8 9
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (final digit in ['7', '8', '9'])
                KeypadButtonWidget(
                  bgcolor: numBg,
                  frcolor: numFg,
                  content: digit,
                  onTap: () {
                    convDisplayCubit.appendDigit(digit);
                  },
                ),
            ],
          ),
          const SizedBox(height: 10),

          // Row 3: 4 5 6
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (final digit in ['4', '5', '6'])
                KeypadButtonWidget(
                  bgcolor: numBg,
                  frcolor: numFg,
                  content: digit,
                  onTap: () {
                    convDisplayCubit.appendDigit(digit);
                  },
                ),
            ],
          ),
          const SizedBox(height: 10),

          // Row 4: 1 2 3
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (final digit in ['1', '2', '3'])
                KeypadButtonWidget(
                  bgcolor: numBg,
                  frcolor: numFg,
                  content: digit,
                  onTap: () {
                    convDisplayCubit.appendDigit(digit);
                  },
                ),
            ],
          ),
          const SizedBox(height: 10),

          // Row 5: 0 .
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              KeypadButtonWidget(
                bgcolor: numBg,
                frcolor: numFg,
                content: '0',
                onTap: () {
                  convDisplayCubit.appendDigit('0');
                },
              ),
              KeypadButtonWidget(
                bgcolor: opBg,
                frcolor: numFg,
                content: '.',
                onTap: () {
                  convDisplayCubit.addDot();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
