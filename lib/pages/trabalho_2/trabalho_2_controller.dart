import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Trabalho2Controller extends GetxController {
  final integral = [
    {'numero': '2', 'expoente': '', 'x': 'x', 'operacao': ''},
    {'numero': '1', 'expoente': '', 'x': '', 'operacao': '+'},
    {'numero': '', 'expoente': '', 'x': 'x', 'operacao': '/'},
  ].obs;
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

  void createIntegral(String value) {
    bool exp = false;
    Map<String, String> parteDaEquacao = {'numero': '', 'expoente': '', 'x': '', 'operacao': ''};
    List<Map<String, String>> equacoes = [];

    // if (value.length > 1 && (value[value.length - 1] == '+' || value[value.length - 1] == '-')) {
    //   if (value[value.length - 2] == '+' || value[value.length - 2] == '-') {
    //     integral.value = value.substring(0, value.length - 2) + value.substring(value.length - 1);
    //   }
    // } else {
    //   integral.value = value;
    // }

    for (int i = 0; i < value.length; i++) {
      if (value[i] != 'x' && value[i] != 'X' && value[i] != '+' && value[i] != '/' && value[i] != '-') {
        if (exp) {
          parteDaEquacao['expoente'] = parteDaEquacao['expoente']! + value[i];
        } else {
          parteDaEquacao['numero'] = parteDaEquacao['numero']! + value[i];
        }
      } else if (value[i] == 'x' || value[i] == 'X') {
        parteDaEquacao['x'] = 'x';
        exp = true;
      } else if (value[i] == '-' || value[i] == '+' || value[i] == '/') {
        if (i == 0) {
          parteDaEquacao['operacao'] = value[i];
        } else {
          equacoes.add(parteDaEquacao);
          parteDaEquacao = {'numero': '', 'expoente': '', 'x': '', 'operacao': value[i]};
          exp = false;
        }
      }

      //Sempre atualizar
      if (value.length - 1 == i) {
        equacoes.add(parteDaEquacao);
        parteDaEquacao = {'numero': '', 'expoente': '', 'x': '', 'operacao': value[i]};
        exp = false;
      }
    }

    print(equacoes);
    integral.value = equacoes;
    print(integral.value);
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
