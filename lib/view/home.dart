import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:currencyxchanger/controller/home_controller.dart';
import 'package:currencyxchanger/component/anytoany.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      });

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
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
                            child: CircularProgressIndicator(color: Colors.white,),
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
   showDialogBox() => showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text("No Connection"),
            content: const Text('Please check Internet'),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context, "Cancel");
                    setState(() => isAlertSet = false);
                    isDeviceConnected =
                        await InternetConnectionChecker().hasConnection;
                    if (!isDeviceConnected) {
                      showDialogBox();
                      setState(
                        () => isAlertSet = true,
                      );
                    }
                    ;
                  },
                  child: Text("OK")),
            ],
          ));
}
