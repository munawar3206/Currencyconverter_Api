import 'package:currencyxchanger/models/allcurrencies.dart';
import 'package:http/http.dart' as http;

import '../models/rates_model.dart';

class ExchangeRates {
  Future<RatesModel> getRates() async {
    final response = await http.get(
      Uri.parse(
          'https://openexchangerates.org/api/latest.json?app_id=1900991f4f544429901d58b4374e5321'),
    );

    if (response.statusCode == 200) {
      final result = ratesModelFromJson(response.body);
      return result;
    } else {
      throw Exception('Failed to load currency rates');
    }
  }

  Future<Map<String, String>> getCurrencies() async {
    var response = await http.get(
      Uri.parse(
          'https://openexchangerates.org/api/currencies.json'),
    );

    if (response.statusCode == 200) {
      final allCurrencies = allCurrenciesFromJson(response.body);
      return allCurrencies;
    } else {
      throw Exception('Failed to load currency codes');
    }
  }



  String convertany(
    Map<String, double> exchangeRates,
    String amount,
    String currencybase,
    String currencyfinal,
  ) {
    if (!exchangeRates.containsKey(currencybase) ||
        !exchangeRates.containsKey(currencyfinal)) {
      return "Invalid currency selection";
    }

    String output = (double.parse(amount) /
            exchangeRates[currencybase]! *
            exchangeRates[currencyfinal]!)
        .toStringAsFixed(2)
        .toString();

    return output;
  }
}
