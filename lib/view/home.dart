import 'package:currencyxchanger/controller/home_controller.dart';
import 'package:currencyxchanger/component/anytoany.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<CurrencyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text(
          'Coinvert',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/m.jpg'), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Form(
                child: Consumer<CurrencyProvider>(
                  builder: (context, value, child) {
                    final currencyData = value.result;
                    final currenciesMap = value.allCurrencies;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (currencyData.rates.isNotEmpty)
                          AnyToAny(
                            currencies: currenciesMap.cast(),
                            rates: currencyData.rates,
                          ),
                        if (currencyData.rates.isEmpty)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
