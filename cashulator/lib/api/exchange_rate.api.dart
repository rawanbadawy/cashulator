import 'package:cashulator/models/exchange_rate.Dto.dart';
import 'package:cashulator/service/network.service.dart';

class ExchangeRateApi {
  ExchangeRateApi._();

  static Future<ExchangeRateDto> getexchangeRate() async {
    try {
      final response = await NetworkClientService.get('/latest/USD', {});
      return ExchangeRateDto.fromMap(response as Map<String, dynamic>);
    } catch (error) {
      rethrow;
    }
  }
}
