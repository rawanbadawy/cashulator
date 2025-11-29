class ConvertorHistoryModel {
  final String id;
  final String fromCurrency;
  final String toCurrency;
  final double amount;
  final double convertedAmount;
  final DateTime timestamp;

  ConvertorHistoryModel({
    required this.id,
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
    required this.convertedAmount,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromCurrency': fromCurrency,
      'toCurrency': toCurrency,
      'amount': amount,
      'convertedAmount': convertedAmount,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory ConvertorHistoryModel.fromJson(Map<String, dynamic> json) {
    return ConvertorHistoryModel(
      id: json['id'],
      fromCurrency: json['fromCurrency'],
      toCurrency: json['toCurrency'],
      amount: json['amount'],
      convertedAmount: json['convertedAmount'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}