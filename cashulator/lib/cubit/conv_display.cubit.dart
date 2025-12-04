import 'package:cashulator/models/exchange_rate.Dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvDisplayState {
  final String fromCurrency;
  final String toCurrency;
  final String fromAmount;
  final String toAmount;

  const ConvDisplayState({
    this.fromCurrency = 'EGP',
    this.toCurrency = 'USD',
    this.fromAmount = '0',
    this.toAmount = '0',
  });

  ConvDisplayState copyWith({
    String? fromCurrency,
    String? toCurrency,
    String? fromAmount,
    String? toAmount,
  }) {
    return ConvDisplayState(
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      fromAmount: fromAmount ?? this.fromAmount,
      toAmount: toAmount ?? this.toAmount,
    );
  }
}

class ConvDisplayCubit extends Cubit<ConvDisplayState> {
  ConvDisplayCubit() : super(const ConvDisplayState());

  void changeFromCurrency(String value) {
    emit(state.copyWith(fromCurrency: value));
  }

  void changeToCurrency(String value) {
    emit(state.copyWith(toCurrency: value));
  }

  void swap() {
    emit(
      ConvDisplayState(
        fromCurrency: state.toCurrency,
        toCurrency: state.fromCurrency,
        fromAmount: state.toAmount,
        toAmount: state.fromAmount,
      ),
    );
  }


  void setFromAmount(String value) {
    emit(
      state.copyWith(
        fromAmount: value,
      ),
    );
  }

  void clearFromAmount() {
    emit(
      state.copyWith(
        fromAmount: '0',
        toAmount: '0',
      ),
    );
  }

  void appendDigit(String digit) {
    String current = state.fromAmount;

    if (current == '0') {
      current = digit;
    } else {
      current = current + digit;
    }

    setFromAmount(current);
  }

  void addDot() {
    final current = state.fromAmount;
    if (current.contains('.')) return;

    String next;
    if (current.isEmpty || current == '0') {
      next = '0.';
    } else {
      next = '$current.';
    }
    setFromAmount(next);
  }


  void convert(ExchangeRateDto dto) {
    final amount = double.tryParse(state.fromAmount) ?? 0;
    if (amount == 0) {
      emit(state.copyWith(toAmount: '0'));
      return;
    }

    final fromRate = dto.rates.getByCode(state.fromCurrency);
    final toRate = dto.rates.getByCode(state.toCurrency);

    if (fromRate == 0) {
      emit(state.copyWith(toAmount: '0'));
      return;
    }

    final result = amount * (toRate / fromRate);
    emit(
      state.copyWith(
        toAmount: result.toStringAsFixed(2),
      ),
    );
  }
}
