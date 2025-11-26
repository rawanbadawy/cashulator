import 'package:cashulator/models/calculator_history.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalcHistoryCubit extends Cubit<List<CalculatorHistoryModel>> {
  CalcHistoryCubit() : super([]);
  
void addToHistory({required CalculatorHistoryModel entry}) {
    final currentHistory = List<CalculatorHistoryModel>.from(state);
    currentHistory.insert(0, entry); 
    emit(currentHistory);
  }

  void clearHistory() {
    emit([]);
  }

}

