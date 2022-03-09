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
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: const Text(
                    'App desenvolvido por Raphael Abreu para a disciplina de Cálculo Numérico em Computadores da UFSC (Universidade Federal de Santa Catarina)',
                  ),
                  actions: [
                    TextButton(
                      onPressed: Get.back,
                      child: const Text('Fechar'),
                    ),
                  ],
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
