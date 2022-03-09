import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Trabalho2Controller extends GetxController {
  final integral = '2x+1/x'.obs;
  final funcao = '2x+1/x'.obs;
  final a = 1.0.obs;
  final b = 2.0.obs;
  final n = 10.obs;
  double? h;

  void trapeziosClicked() {
    h = (b.value - a.value) / n.value;
    var xi = a.value;
    var fxi = 0.0;
    var ci = 0;
    var ciFxi = 0.0;
    var t = 0.0;
    var soma = 0.0;

    for (var i = 0; i <= n.value; i++) {
      if (i == 0) {
        ci = 1;
      } else if (i == n.value) {
        ci = 1;
        xi += h!;
      } else {
        ci = 2;
        xi += h!;
      }
      fxi = 2 * xi + 1 / xi;
      ciFxi = ci * fxi;
      soma += ciFxi;
      print(' i: $i\t xi: $xi\t f(xi): $fxi\t ci: $ci\t ci*f(xi)$ciFxi');
    }
    t = h! / 2 * soma;
    print('t: $t \t Soma: $soma');
    Get.defaultDialog(
      content: Text('Soma: ${soma.toStringAsFixed(4)}\nT(h$n): ${t.toStringAsFixed(4)}'),
      title: 'Regra dos Trapézios',
      cancel: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
        ),
        child: const Text('Fechar'),
        onPressed: () => Get.back(),
      ),
    );
  }

  void simpsonClicked() {
    h = (b.value - a.value) / n.value;
    var xi = a.value;
    var fxi = 0.0;
    var ci = 0;
    var ciFxi = 0.0;
    var s = 0.0;
    var soma = 0.0;

    for (var i = 0; i <= n.value; i++) {
      if (i == 0) {
        ci = 1;
      } else if (i == n.value) {
        ci = 1;
        xi += h!;
      } else if (i % 2 == 0) {
        ci = 2;
        xi += h!;
      } else {
        ci = 4;
        xi += h!;
      }
      fxi = 2 * xi + 1 / xi;
      ciFxi = ci * fxi;
      soma += ciFxi;
      print(' i: $i\t xi: $xi\t  f(xi): $fxi\t ci: $ci\t ci*f(xi)$ciFxi');
    }
    s = h! / 3 * soma;
    print('s: $s \t Soma: $soma');
    Get.defaultDialog(
      content: Text('Soma: ${soma.toStringAsFixed(4)}\nS(h$n): ${s.toStringAsFixed(4)}'),
      title: 'Regra de Simpon',
      cancel: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
        ),
        child: const Text('Fechar'),
        onPressed: () => Get.back(),
      ),
    );
  }
}
