// lib/main.dart
import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/contact_page.dart';
import 'theme/app_theme.dart'; 


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routing Demo',
      debugShowCheckedModeBanner: false,

      // Use a named initial route so '/login' is resolvable everywhere.
      initialRoute: '/login',

      // Register all named routes used in the app (including '/login').
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
        '/contact': (context) => const ContactPage(),
      },

      // Optional fallback if an unknown route is requested
      onUnknownRoute: (settings) => MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }
}
