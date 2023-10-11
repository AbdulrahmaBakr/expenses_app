import 'package:expenses_app/view/expenses_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

var ownColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromRGBO(120, 1, 255, 1));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ExpensesScreen(),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ownColorScheme,
        appBarTheme: const AppBarTheme()
            .copyWith(backgroundColor: ownColorScheme.inversePrimary),
      ),
    );
  }
}
