import 'package:cashulator/cubit/calc.cubit.dart';
import 'package:cashulator/cubit/calc_Display.cubit.dart';
import 'package:cashulator/cubit/calc_history.cubit.dart';
import 'package:cashulator/cubit/first_operator.cubit.dart';
import 'package:cashulator/cubit/operation.cubit.dart';
import 'package:cashulator/cubit/second_operator.cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cashulator/widgets/convertorWidgets/convertorDisplay.widget.dart';
import 'package:cashulator/widgets/commonWidgets/keypad.widget.dart';
import 'package:cashulator/widgets/commonWidgets/options.widget.dart';

class ConvertorScreen extends StatefulWidget {
  const ConvertorScreen({super.key});

  @override
  State<ConvertorScreen> createState() => _ConvertorScreenState();
}

class _ConvertorScreenState extends State<ConvertorScreen> {
  String fromCurrency = 'EGP';
  String toCurrency = 'USD';
  String fromAmount = '0.00';
  String toAmount = '0.00';

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final dividerColor =
        dark ? const Color(0xFF1E1E1E) : const Color(0xFFE6E6E6);

    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
            bottom: kBottomNavigationBarHeight +
                MediaQuery.of(context).viewPadding.bottom +
                16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),

              ConvertorDisplayWidget(
                fromCurrency: fromCurrency,
                toCurrency: toCurrency,
                fromAmount: fromAmount,
                toAmount: toAmount,
                onFromChanged: (val) {
                  if (val == null) return;
                  setState(() {
                    fromCurrency = val;
                  });
                },
                onToChanged: (val) {
                  if (val == null) return;
                  setState(() {
                    toCurrency = val;
                  });
                },
                onSwap: () {
                  setState(() {
                    final temp = fromCurrency;
                    fromCurrency = toCurrency;
                    toCurrency = temp;

                    final tempAmount = fromAmount;
                    fromAmount = toAmount;
                    toAmount = tempAmount;
                  });
                },
              ),

              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: const [
                    Icon(Icons.history, size: 20),
                    SizedBox(width: 16),
                    Icon(Icons.straighten, size: 20),
                    SizedBox(width: 16),
                    Icon(Icons.check_box_outlined, size: 20),
                    Spacer(),
                    Icon(Icons.open_in_full, size: 20),
                  ],
                ),
              ),
              Container(height: 1, color: dividerColor),
              const SizedBox(height: 10),

              OptionsWidget(
                isCalc: false,
                calcDisplayCubit: CalcDisplayCubit(),
                calcHistoryCubit: CalcHistoryCubit(),
              ),

              KeypadWidget(
                isCalc: false,
                firstOperatorCubit: FirstOperatorCubit(),
                secondOperatorCubit: SecondOperatorCubit(),
                operationCubit: OperationCubit(),
                calcCubit: CalcCubit(),
                calcHistoryCubit: CalcHistoryCubit(),
                convertAmount: fromAmount,
                onConvertAmountChanged: (newAmount) {
                  setState(() {
                    fromAmount = newAmount;
                    
                    toAmount = newAmount;
                  });
                },
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xFF22C55E),
        onTap: (i) {
          if (i == 1) {
            return;
          } else if (i == 0) {
            context.go('/');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_outlined),
            label: 'Calculate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange),
            label: 'Convert',
          ),
        ],
      ),
    );
  }
}
