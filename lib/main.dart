import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // Hilangkan banner debug
      title: 'MiLab', // Judul aplikasi
      initialRoute: AppPages.INITIAL, // Rute awal (default ke BottomNavbar)
      getPages: AppPages.routes, // Daftar rute dari AppPages
      theme: ThemeData(
        primarySwatch: Colors.orange, // Warna tema utama
        fontFamily: 'Roboto', // Font default (opsional)
        visualDensity: VisualDensity.adaptivePlatformDensity, // Tata letak adaptif
      ),
      defaultTransition: Transition.downToUp, // Transisi dari bawah ke atas
      locale: const Locale('en', 'US'), // Bahasa default (opsional)
      fallbackLocale: const Locale('en', 'US'), // Locale cadangan
    );
  }
}
