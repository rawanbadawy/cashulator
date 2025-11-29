// lib/cubit/amount.cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

class AmountCubit extends Cubit<double> {
  AmountCubit(super.initial);

  void updateFromText(String text) {
    final value = double.tryParse(text.replaceAll(',', '.')) ?? 0;
    emit(value);
  }

  void set(double value) {
    emit(value);
  }
}
