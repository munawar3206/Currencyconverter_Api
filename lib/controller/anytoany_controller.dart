import 'package:currencyxchanger/services/api_services.dart';
import 'package:flutter/material.dart';

class AnyToAnyProvider extends ChangeNotifier {
  TextEditingController amountController = TextEditingController();
  String dropdownValue1 = 'AED';
  String dropdownValue2 = 'INR';
  String answer = 'Converted Currency :';

  void changedropdownvalueone(String? value) {
    dropdownValue1 = value!;
    notifyListeners();
  }

  void resetdropdownvalueone() {
    dropdownValue1 = answer;
    notifyListeners();
  }

  void changedropdownvaluetwo(String? value) {
    dropdownValue2 = value!;
    notifyListeners();
  }

  void resetdropdownvaluetwo() {
    dropdownValue2 = answer;
    notifyListeners();
  }

  void convertCurrency(
      rates, String amount, String fromCurrency, String toCurrency) {
    answer =
        '${ExchangeRates().convertany(rates, amount, fromCurrency, toCurrency)} $toCurrency';
    notifyListeners();
  }
}
