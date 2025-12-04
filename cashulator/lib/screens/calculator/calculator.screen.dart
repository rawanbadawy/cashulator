import 'package:cashulator/cubit/calc_Display.cubit.dart';
import 'package:cashulator/cubit/calc_history.cubit.dart';
import 'package:cashulator/widgets/calculatorWidgets/calc_history.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:cashulator/widgets/commonWidgets/keypad.widget.dart';
import 'package:cashulator/widgets/calculatorWidgets/calculatorDisplay.widget.dart';
import 'package:cashulator/widgets/commonWidgets/options.widget.dart';

import 'package:cashulator/cubit/first_operator.cubit.dart';
import 'package:cashulator/cubit/second_operator.cubit.dart';
import 'package:cashulator/cubit/operation.cubit.dart';
import 'package:cashulator/cubit/calc.cubit.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firstOperatorCubit = context.read<FirstOperatorCubit>();
    final secondOperatorCubit = context.read<SecondOperatorCubit>();
    final operationCubit = context.read<OperationCubit>();
    final calcCubit = context.read<CalcCubit>();
    final calcHistoryCubit = context.read<CalcHistoryCubit>();
    final calcDisplayCubit = context.read<CalcDisplayCubit>();

    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: CalculatorDisplayWidget(
                  firstOperatorCubit: firstOperatorCubit,
                  secondOperatorCubit: secondOperatorCubit,
                  operationCubit: operationCubit,
                  calcCubit: calcCubit,
                ),
              ),
              const SizedBox(height: 12),
              OptionsWidget(
                isCalc: true,
                calcDisplayCubit: calcDisplayCubit,
                calcHistoryCubit: calcHistoryCubit,
              ),
              const SizedBox(height: 10),
              BlocBuilder<CalcDisplayCubit, bool>(
                builder: (context, isCalcMode) {
                  return isCalcMode
                      ? KeypadWidget(
                          isCalc: true,
                          firstOperatorCubit: firstOperatorCubit,
                          secondOperatorCubit: secondOperatorCubit,
                          operationCubit: operationCubit,
                          calcCubit: calcCubit,
                          calcHistoryCubit: calcHistoryCubit,
                        )
                      : CalcHistoryWidget(calcHistoryCubit: calcHistoryCubit);
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF22C55E),
        onTap: (i) {
          if (i == 0) return;
          if (i == 1) {
            context.go('/convertor');
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
