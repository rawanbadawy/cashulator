import 'package:cashulator/cubit/exchange_rate/exchange_rate.state.dart';
import 'package:cashulator/service/exchange_rate.service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ExchangeRateCubit extends Cubit<ExchangeRateState?> {
  ExchangeRateCubit() : super(null);

Future<void> fetchExchangeRate(String baseCurrency, String targetCurrency) async {
  emit(ExchangeRateLoading(exchangeRateDto: null));
try {
  final response = await ExchangeRateService.getexchangeRate();
  emit(ExchangeRateSuccess(response));
} catch(error){
  emit(ExchangeRateError(
    message: 'Failed to load exchange rates. Please check your connection.',
    error: error,
  ));
}
}
}