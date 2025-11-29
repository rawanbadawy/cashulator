// lib/widgets/commonWidgets/keypad.widget.dart
import 'package:cashulator/cubit/calc_history.cubit.dart';
import 'package:flutter/material.dart';
import 'package:cashulator/widgets/commonWidgets/keypad_button.widget.dart';
import 'package:cashulator/cubit/first_operator.cubit.dart';
import 'package:cashulator/cubit/second_operator.cubit.dart';
import 'package:cashulator/cubit/operation.cubit.dart';
import 'package:cashulator/cubit/calc.cubit.dart';

class KeypadWidget extends StatelessWidget {
  const KeypadWidget({
    super.key,
    required this.isCalc,
    required this.firstOperatorCubit,
    required this.secondOperatorCubit,
    required this.operationCubit,
    required this.calcCubit,
    required this.calcHistoryCubit,
    this.convertAmount,
    this.onConvertAmountChanged,
  });

  final bool isCalc;
  final FirstOperatorCubit firstOperatorCubit;
  final SecondOperatorCubit secondOperatorCubit;
  final OperationCubit operationCubit;
  final CalcCubit calcCubit;
  final CalcHistoryCubit calcHistoryCubit;

  // used only in convertor screen (old logic, still kept simple)
  final String? convertAmount;
  final ValueChanged<String>? onConvertAmountChanged;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    final Color opBg =
        dark ? const Color(0xFF2A2A2A) : const Color(0xFFEFEFEF);
    final Color numBg =
        dark ? const Color(0xFF1E1E1E) : const Color(0xFFF2F2F2);
    final Color clearBg = const Color(0xFFFF5A5A);
    final Color equalBg = const Color(0xFF22C55E);
    final Color opFg = const Color(0xFF22C55E);
    final Color numFg =
        dark ? const Color(0xFFD1D5DB) : const Color(0xFF6B7280);

    if (isCalc) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            // Row 1: C () % ÷
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeypadButtonWidget(
                  bgcolor: clearBg,
                  frcolor: Colors.white,
                  content: 'C',
                  onTap: () {
                    firstOperatorCubit.clear();
                    secondOperatorCubit.clear();
                    operationCubit.clear();
                    calcCubit.clear();
                  },
                ),
                const SizedBox(width: 4),
                KeypadButtonWidget(
                  bgcolor: opBg,
                  frcolor: opFg,
                  content: '()',
                  onTap: () {
                    final op = operationCubit.state;
                    if (op == null || op.isEmpty) {
                      firstOperatorCubit.toggleBrackets();
                    } else {
                      secondOperatorCubit.toggleBrackets();
                    }
                  },
                ),
                const SizedBox(width: 4),
                KeypadButtonWidget(
                  bgcolor: opBg,
                  frcolor: opFg,
                  content: '%',
                  onTap: () {
                    final op = operationCubit.state;
                    if (op == null || op.isEmpty) {
                      firstOperatorCubit.toPercent();
                    } else {
                      secondOperatorCubit.toPercent();
                    }
                  },
                ),
                const SizedBox(width: 4),
                KeypadButtonWidget(
                  bgcolor: opBg,
                  frcolor: opFg,
                  content: '÷',
                  onTap: () {
                    if (firstOperatorCubit.state.isEmpty) return;
                    operationCubit.setOperation(operation: '÷');
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Row 2: 7 8 9 ×
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (final digit in ['7', '8', '9'])
                  Row(
                    children: [
                      KeypadButtonWidget(
                        bgcolor: numBg,
                        frcolor: numFg,
                        content: digit,
                        onTap: () {
                          if (operationCubit.state == null ||
                              operationCubit.state!.isEmpty) {
                            firstOperatorCubit.add(value: digit);
                          } else {
                            secondOperatorCubit.add(value: digit);
                          }
                        },
                      ),
                      const SizedBox(width: 4),
                    ],
                  ),
                KeypadButtonWidget(
                  bgcolor: opBg,
                  frcolor: opFg,
                  content: '×',
                  onTap: () {
                    if (firstOperatorCubit.state.isEmpty) return;
                    operationCubit.setOperation(operation: '×');
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Row 3: 4 5 6 −
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (final digit in ['4', '5', '6'])
                  Row(
                    children: [
                      KeypadButtonWidget(
                        bgcolor: numBg,
                        frcolor: numFg,
                        content: digit,
                        onTap: () {
                          if (operationCubit.state == null ||
                              operationCubit.state!.isEmpty) {
                            firstOperatorCubit.add(value: digit);
                          } else {
                            secondOperatorCubit.add(value: digit);
                          }
                        },
                      ),
                      const SizedBox(width: 4),
                    ],
                  ),
                KeypadButtonWidget(
                  bgcolor: opBg,
                  frcolor: opFg,
                  content: '−',
                  onTap: () {
                    if (firstOperatorCubit.state.isEmpty) return;
                    operationCubit.setOperation(operation: '−');
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Row 4: 1 2 3 +
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (final digit in ['1', '2', '3'])
                  Row(
                    children: [
                      KeypadButtonWidget(
                        bgcolor: numBg,
                        frcolor: numFg,
                        content: digit,
                        onTap: () {
                          if (operationCubit.state == null ||
                              operationCubit.state!.isEmpty) {
                            firstOperatorCubit.add(value: digit);
                          } else {
                            secondOperatorCubit.add(value: digit);
                          }
                        },
                      ),
                      const SizedBox(width: 4),
                    ],
                  ),
                KeypadButtonWidget(
                  bgcolor: opBg,
                  frcolor: opFg,
                  content: '+',
                  onTap: () {
                    if (firstOperatorCubit.state.isEmpty) return;
                    operationCubit.setOperation(operation: '+');
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Row 5: +/- 0 . =
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeypadButtonWidget(
                  bgcolor: opBg,
                  frcolor: numFg,
                  content: '+/-',
                  onTap: () {
                    final op = operationCubit.state;
                    if (op == null || op.isEmpty) {
                      firstOperatorCubit.toggleSign();
                    } else {
                      secondOperatorCubit.toggleSign();
                    }
                  },
                ),
                const SizedBox(width: 4),
                KeypadButtonWidget(
                  bgcolor: numBg,
                  frcolor: numFg,
                  content: '0',
                  onTap: () {
                    if (operationCubit.state == null ||
                        operationCubit.state!.isEmpty) {
                      firstOperatorCubit.add(value: '0');
                    } else {
                      secondOperatorCubit.add(value: '0');
                    }
                  },
                ),
                const SizedBox(width: 4),
                KeypadButtonWidget(
                  bgcolor: opBg,
                  frcolor: numFg,
                  content: '.',
                  onTap: () {
                    final op = operationCubit.state;
                    if (op == null || op.isEmpty) {
                      firstOperatorCubit.addDot();
                    } else {
                      secondOperatorCubit.addDot();
                    }
                  },
                ),
                const SizedBox(width: 4),
                KeypadButtonWidget(
                  bgcolor: equalBg,
                  frcolor: Colors.white,
                  content: '=',
                  onTap: () {
                    calcCubit.setResult(
                      first: firstOperatorCubit.state,
                      second: secondOperatorCubit.state,
                      operation: operationCubit.state,
                      calcHistoryCubit: calcHistoryCubit,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }

    // SIMPLE OLD CONVERTOR KEYPAD (still uses callback)
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
                  if (onConvertAmountChanged != null) {
                    onConvertAmountChanged!('0');
                  }
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
                    if (onConvertAmountChanged == null) return;
                    final current = convertAmount ?? '0';
                    String next;
                    if (current == '0') {
                      next = digit;
                    } else {
                      next = current + digit;
                    }
                    onConvertAmountChanged!(next);
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
                    if (onConvertAmountChanged == null) return;
                    final current = convertAmount ?? '0';
                    String next;
                    if (current == '0') {
                      next = digit;
                    } else {
                      next = current + digit;
                    }
                    onConvertAmountChanged!(next);
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
                    if (onConvertAmountChanged == null) return;
                    final current = convertAmount ?? '0';
                    String next;
                    if (current == '0') {
                      next = digit;
                    } else {
                      next = current + digit;
                    }
                    onConvertAmountChanged!(next);
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
                  if (onConvertAmountChanged == null) return;
                  final current = convertAmount ?? '0';
                  String next;
                  if (current == '0') {
                    next = '0';
                  } else {
                    next = current + '0';
                  }
                  onConvertAmountChanged!(next);
                },
              ),
              KeypadButtonWidget(
                bgcolor: opBg,
                frcolor: numFg,
                content: '.',
                onTap: () {
                  if (onConvertAmountChanged == null) return;
                  final current = convertAmount ?? '0';
                  if (current.contains('.')) return;
                  String next;
                  if (current.isEmpty) {
                    next = '0.';
                  } else {
                    next = '$current.';
                  }
                  onConvertAmountChanged!(next);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
