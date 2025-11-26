import 'package:flutter_bloc/flutter_bloc.dart';

class SecondOperatorCubit extends Cubit<String?> {
  SecondOperatorCubit() : super(null);

  void add({required String value}) {
    final current = state ?? '';
    emit(current + value);
  }

  void set({required String value}) {
    emit(value);
  }

  void clear() {
    emit(null);
  }

  void toggleSign() {
    final current = state ?? '';
    if (current.isEmpty) return;

    if (current.startsWith('-')) {
      emit(current.substring(1));
    } else {
      emit('-$current');
    }
  }

  void toggleBrackets() {
    final current = state ?? '';
    if (current.isEmpty) return;

    if (current.startsWith('(') && current.endsWith(')') && current.length > 2) {
      emit(current.substring(1, current.length - 1));
    } else {
      emit('($current)');
    }
  }
}
