import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lapor_book/firebase_options.dart';
import 'package:lapor_book/pages/dashboard_page.dart';
import 'package:lapor_book/pages/login_page.dart';
import 'package:lapor_book/pages/register_page.dart';
import 'package:lapor_book/pages/splash_page.dart';
import 'package:lapor_book/pages/tambah_lapor_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Aplikasi Lapor Book",
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/addlapor': (context) => const AddFormPage()
        // -- page yang lain ---
      }));
}
