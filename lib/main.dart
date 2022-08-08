import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scaner_qr/src/pages/maps.dart';
import 'package:scaner_qr/src/provider/scan_provider.dart';
import 'package:scaner_qr/src/provider/ui_provider.dart';

import 'src/pages/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.purple;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomeScreen(),
          'maps': (_) => const MapsScreen()
        },
        theme: ThemeData(
          primaryColor: primaryColor,
          appBarTheme: const AppBarTheme(
            color: primaryColor,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: primaryColor,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: primaryColor,
          ),
        ),
      ),
    );
  }
}
