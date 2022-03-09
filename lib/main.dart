import 'package:calc_numerico/pages/trabalho_2/trabalho_2_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './pages/home_page.dart';
import './pages/trabalho_1/trabalho_1.dart';
import './pages/trabalho_2/trabalho_2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/trabalho1', page: () => const Trabalho1()),
        GetPage(
          name: '/trabalho2',
          page: () => const Trabalho2(),
          binding: BindingsBuilder(
            () => Get.lazyPut<Trabalho2Controller>(() => Trabalho2Controller()),
          ),
        ),
      ],
    );
  }
}
