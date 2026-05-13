import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/pembayaran_page.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Bus Booking App',

      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),

      // 🚀 START APP DARI LOGIN
      home: const SplashScreen(),

      // 📦 ROUTING TAMBAHAN
      onGenerateRoute: (settings) {
        switch (settings.name) {

          case '/home':
            return MaterialPageRoute(
              builder: (_) => const HomePage(),
            );

          case '/payment':
            final args = settings.arguments as Map;

            return MaterialPageRoute(
              builder: (_) => PembayaranPage(
                booking: args['booking'],
              ),
            );

          default:
            return MaterialPageRoute(
              builder: (_) => const LoginPage(),
            );
        }
      },
    );
  }
}