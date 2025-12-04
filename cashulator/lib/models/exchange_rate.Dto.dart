import 'dart:convert';

import 'package:cashulator/models/rates.Dto.dart';

class ExchangeRateDto {
  final String provider;
  final String warningUpgradeToV6;
  final String terms;
  final String base;
  final DateTime? date;
  final int timeLastUpdated;
  final RatesDto rates;

  ExchangeRateDto({
    required this.provider,
    required this.warningUpgradeToV6,
    required this.terms,
    required this.base,
    required this.date,
    required this.timeLastUpdated,
    required this.rates,
  });

  factory ExchangeRateDto.fromMap(Map<String, dynamic> map) {
    final upgrade = map['WARNING_UPGRADE_TO_V6'] ??
        map['warning_upgrade_to_v6'] ??
        '';

    return ExchangeRateDto(
      provider: map['provider'] as String,
      warningUpgradeToV6: upgrade.toString(),
      terms: map['terms'] as String,
      base: map['base'] as String,
      date: DateTime.tryParse(map['date'] as String),
      timeLastUpdated: map['time_last_updated'] as int,
      rates: RatesDto.fromMap(map['rates'] as Map<dynamic, dynamic>),
    );
  }

  factory ExchangeRateDto.fromJson(String source) {
    final Map<String, dynamic> map =
        json.decode(source) as Map<String, dynamic>;
    return ExchangeRateDto.fromMap(map);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExchangeRateDto &&
        other.provider == provider &&
        other.warningUpgradeToV6 == warningUpgradeToV6 &&
        other.terms == terms &&
        other.base == base &&
        other.date == date &&
        other.timeLastUpdated == timeLastUpdated &&
        other.rates == rates;
  }

  @override
  int get hashCode {
    return provider.hashCode ^
        warningUpgradeToV6.hashCode ^
        terms.hashCode ^
        base.hashCode ^
        date.hashCode ^
        timeLastUpdated.hashCode ^
        rates.hashCode;
  }
}
