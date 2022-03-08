// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './pages/home_page.dart';
import './pages/trabalho_1.dart';
import './pages/trabalho_2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primaryColor: Colors.deepPurple, brightness: Brightness.dark, primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/trabalho1', page: () => const Trabalho1()),
        GetPage(name: '/trabalho2', page: () => const Trabalho2()),
      ],
    );
  }
}
