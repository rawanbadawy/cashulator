import 'package:cashulator/models/convertor_history.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvHistoryCubit extends Cubit<List<ConvertorHistoryModel>> {
  ConvHistoryCubit() : super([]);

  void addToHistory({required ConvertorHistoryModel entry}) {
    final currentHistory = List<ConvertorHistoryModel>.from(state);
    currentHistory.insert(0, entry);
    emit(currentHistory);
  }

  void clearHistory() {
    emit([]);
  }
}