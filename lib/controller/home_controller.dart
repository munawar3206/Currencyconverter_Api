import 'package:currencyxchanger/models/rates_model.dart';
import 'package:currencyxchanger/services/api_services.dart';


import 'package:flutter/material.dart';

class CurrencyProvider extends ChangeNotifier {
  late RatesModel _result;
  late Map _allCurrencies;

  CurrencyProvider() {
    _result = RatesModel(
        rates: {}, base: '', disclaimer: '', license: '', timestamp: 0);
    _allCurrencies = {};
    refreshData();
  }

  RatesModel get result => _result;

  Map get allCurrencies => _allCurrencies;


  get convertedValue => null;

  Future<void> refreshData() async {
    _result = await ExchangeRates(). getRates();
    _allCurrencies = await  ExchangeRates(). getCurrencies();
    notifyListeners();
  }

  void updateConversionResult(convertedValue) {}
}


