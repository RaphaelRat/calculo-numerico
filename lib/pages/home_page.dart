import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cálculo Numérico'),
        actions: [
          IconButton(
            onPressed: () {
              Get.isDarkMode ? Get.changeTheme(ThemeData.light()) : Get.changeTheme(ThemeData.dark());
            },
            icon: const Icon(Icons.wb_incandescent),
          ),
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                titlePadding: const EdgeInsets.only(top: 18),
                title: 'DEC7142',
                content: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'App desenvolvido por Raphael Abreu para a disciplina de Cálculo Numérico em Computadores da UFSC (Universidade Federal de Santa Catarina)',
                  ),
                ),
                cancel: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                  ),
                  child: const Text('Fechar'),
                  onPressed: () => Get.back(),
                ),
              );
            },
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: () => Get.toNamed('trabalho1'), child: const Text('Trabalho 1')),
            ElevatedButton(onPressed: () => Get.toNamed('trabalho2'), child: const Text('Trabalho 2')),
          ],
        ),
      ),
    );
  }
}
