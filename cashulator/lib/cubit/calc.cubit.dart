import 'package:cashulator/cubit/calc_history.cubit.dart';
import 'package:cashulator/models/calculator_history.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalcCubit extends Cubit<double> {
  CalcCubit() : super(0);

  String _clean(String? text) {
    return text?.replaceAll('(', '').replaceAll(')', '') ?? '';
  }

  void setResult({
    required String first,
    required String? second,
    required String? operation,
    required CalcHistoryCubit calcHistoryCubit,
  }) {
    final double a = double.tryParse(_clean(first)) ?? 0;
    final double b = double.tryParse(_clean(second)) ?? 0;

    double result = 0;

    if (operation == '+') {
      result = a + b;
    } else if (operation == '−') {
      result = a - b;
    } else if (operation == '×') {
      result = a * b;
    } else if (operation == '÷') {
      result = b == 0 ? 0 : a / b;
    }

    emit(result);
    calcHistoryCubit.addToHistory(entry: 
      CalculatorHistoryModel(
       expression: '$first ${operation ?? ''} ${second ?? ''}',
        result: result.toString(),
      ),
    );
  }

  void clear() {
    emit(0);
  }
}
