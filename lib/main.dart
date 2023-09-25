import 'package:currencyxchanger/controller/anytoany_controller.dart';
import 'package:currencyxchanger/controller/home_controller.dart';
import 'package:currencyxchanger/view/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => CurrencyProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => AnyToAnyProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
