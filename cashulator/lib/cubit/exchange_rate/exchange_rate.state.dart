import 'package:cashulator/models/exchange_rate.Dto.dart';

class ExchangeRateState {
  final ExchangeRateDto?exchangeRateDto;

  ExchangeRateState({ this.exchangeRateDto});

  @override
  bool operator ==(Object other) {
 if (identical(this, other)) return true;
 return other is ExchangeRateState && 
 other.exchangeRateDto == exchangeRateDto;

  }

   @override
    int get hashCode { 
      return exchangeRateDto.hashCode;

}

}

class ExchangeRateLoading extends ExchangeRateState{
  ExchangeRateLoading({required super.exchangeRateDto});
  
}

class ExchangeRateError extends ExchangeRateState {
  final dynamic error;
  final String message;
  
  ExchangeRateError({
    required this.message,
    required this.error
  }): super(exchangeRateDto: null);

}
class ExchangeRateSuccess extends ExchangeRateState {
 @override

  final ExchangeRateDto exchangeRateDto;

 ExchangeRateSuccess(this.exchangeRateDto): super(exchangeRateDto: exchangeRateDto);
  
}
