import 'package:cashulator/api/exchange_rate.api.dart';
import 'package:cashulator/models/exchange_rate.Dto.dart';

class ExchangeRateService{
  ExchangeRateService._();

  static Future<ExchangeRateDto> getexchangeRate() async {

    return await ExchangeRateApi.getexchangeRate();
     }

}