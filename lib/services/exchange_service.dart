import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/rates.dart';

class ExchangeService {
  static const _timeout = Duration(seconds: 10);

  static const String _usdUrl =
      'https://ve.dolarapi.com/v1/dolares/oficial';
  static const String _eurUrl =
      'https://ve.dolarapi.com/v1/euros';
  static const String _copUrl =
      'https://ve.dolarapi.com/v1/monedas/cop';

  Future<ExchangeRate> getRates() async {
  try {
    final response = await http
        .get(Uri.parse('https://api.exchangerate-api.com/v4/latest/USD'))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception('HTTP error ${response.statusCode}');
    }

    final data = jsonDecode(response.body);

    final usdToVes = (data['rates']['VES'] as num).toDouble();
    final usdToCop = (data['rates']['COP'] as num).toDouble();

    // EUR usando USD como puente
    final eurToUsd = 1 / (data['rates']['EUR'] as num);
    final eurToVes = eurToUsd * usdToVes;

    return ExchangeRate(
      usdToVes: usdToVes,
      eurToVes: eurToVes,
      vesToCop: usdToCop / usdToVes,
      timestamp: DateTime.now(),
    );
  } catch (e) {
    debugPrint('❌ ERROR RED/API REAL: $e');
    rethrow;
  }
}
}