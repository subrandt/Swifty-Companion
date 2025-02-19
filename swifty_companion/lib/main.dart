import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'config/theme.dart';
import 'config/routes.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  try {
    await dotenv.load(fileName: 'config.env');
  } catch (e) {
    print('Error loading config.env: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swifty Companion',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routes: Routes.getRoutes(),
      initialRoute: Routes.search,
    );
  }
}
