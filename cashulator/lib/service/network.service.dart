import 'package:dio/dio.dart';

class NetworkClientService {
  NetworkClientService._internal();
  static final NetworkClientService _instance =
      NetworkClientService._internal();
  factory NetworkClientService() => _instance;

  static late Dio _client;
  static late String baseUrl;
  static const String endpointSignatureKey = 'endpointSignature';

  static Future<void> init() async {
    _client = Dio(
      BaseOptions(
        baseUrl: 'https://api.exchangerate-api.com/v4', 
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        validateStatus: (status) =>
            status != null && status >= 200 && status < 300,
        followRedirects: true,
        maxRedirects: 5,
      ),
    );
  }

  static Future post(String endpoint, Map<String, dynamic> data) async {
    Response response = await _client.post(endpoint, data: data);
    return response.data;
  }

  static Future get(String endpoint, Map<String, dynamic> queryParameters) async {
    Response response = await _client.get(
      endpoint,
      queryParameters: queryParameters,
    );
    return response.data;
  }
}
