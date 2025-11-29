import 'package:flutter_bloc/flutter_bloc.dart';

class FirstOperatorCubit extends Cubit<String> {
  FirstOperatorCubit() : super('');
String _current() => state ?? '';

  void add({required String value}) {
    emit(state + value);
  }

  void set({required String value}) {
    emit(value);
  }

  void clear() {
    emit('');
  }

  void toggleSign() {
    if (state.startsWith('-')) {
      emit(state.substring(1));
    } else if (state.isNotEmpty) {
      emit('-$state');
    }
  }

  void toggleBrackets() {
    if (state.isEmpty) return;

    
    if (state.startsWith('(') && state.endsWith(')') && state.length > 2) {
      emit(state.substring(1, state.length - 1));
    } else {
      emit('($state)');
    }
  }
  void addDot() {
    final current = _current();
    if (current.contains('.')) return;

    if (current.isEmpty) {
      emit('0.');
    } else {
      emit('$current.');
    }
  }
    void toPercent() {
    if (state.isEmpty) return;
    final value = double.tryParse(state);
    if (value == null) return;
    final percent = value / 100.0;
    emit(percent.toString());
  }
}
