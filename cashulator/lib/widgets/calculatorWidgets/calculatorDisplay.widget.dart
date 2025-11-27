import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cashulator/widgets/display_panel.dart';
import 'package:cashulator/cubit/first_operator.cubit.dart';
import 'package:cashulator/cubit/second_operator.cubit.dart';
import 'package:cashulator/cubit/operation.cubit.dart';
import 'package:cashulator/cubit/calc.cubit.dart';

class CalculatorDisplayWidget extends StatelessWidget {
  const CalculatorDisplayWidget({
    super.key,
    required this.firstOperatorCubit,
    required this.secondOperatorCubit,
    required this.operationCubit,
    required this.calcCubit,
  });

  final FirstOperatorCubit firstOperatorCubit;
  final SecondOperatorCubit secondOperatorCubit;
  final OperationCubit operationCubit;
  final CalcCubit calcCubit;

  String _buildExpression({
    required String first,
    required String? second,
    required String? op,
  }) {
    if (op == null || op.isEmpty) {
      return first.isEmpty ? '0' : first;
    }

    if (second == null || second.isEmpty) {
      return '$first $op';
    }

    return '$first $op $second';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<FirstOperatorCubit, String>(
          bloc: firstOperatorCubit,
          builder: (context, firstState) {
            return BlocBuilder<SecondOperatorCubit, String?>(
              bloc: secondOperatorCubit,
              builder: (context, secondState) {
                return BlocBuilder<OperationCubit, String?>(
                  bloc: operationCubit,
                  builder: (context, opState) {
                    return BlocBuilder<CalcCubit, double>(
                      bloc: calcCubit,
                      builder: (context, resultState) {
                        final expression = _buildExpression(
                          first: firstState,
                          second: secondState,
                          op: opState,
                        );

                        final resultText =
                            (resultState == 0 && expression == '0')
                                ? ''
                                : resultState.toString();

                        return DisplayPanel(
                          expression: expression,
                          result: resultText,
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
