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
  final funcaoController = TextEditingController();

  @override
  void onClose() {
    funcaoController.dispose();
    super.onClose();
  }

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

  void createIntegral() {
    bool exp = false;
    Map<String, String> parteDaEquacao = {'numero': '', 'expoente': '', 'x': '', 'operacao': ''};
    List<Map<String, String>> equacoes = [];

    for (int i = 0; i < funcaoController.text.length; i++) {
      if (funcaoController.text[i] != 'x' &&
          funcaoController.text[i] != 'X' &&
          funcaoController.text[i] != '+' &&
          funcaoController.text[i] != '/' &&
          funcaoController.text[i] != '-') {
        if (exp) {
          parteDaEquacao['expoente'] = parteDaEquacao['expoente']! + funcaoController.text[i];
        } else {
          parteDaEquacao['numero'] = parteDaEquacao['numero']! + funcaoController.text[i];
        }
      } else if (funcaoController.text[i] == 'x' || funcaoController.text[i] == 'X') {
        parteDaEquacao['x'] = 'x';
        exp = true;
      } else if (funcaoController.text[i] == '-' || funcaoController.text[i] == '+' || funcaoController.text[i] == '/') {
        if (i == 0) {
          parteDaEquacao['operacao'] = funcaoController.text[i];
        } else {
          equacoes.add(parteDaEquacao);
          parteDaEquacao = {'numero': '', 'expoente': '', 'x': '', 'operacao': funcaoController.text[i]};
          exp = false;
        }
      }

      //Sempre atualizar
      if (funcaoController.text.length - 1 == i) {
        equacoes.add(parteDaEquacao);
        parteDaEquacao = {'numero': '', 'expoente': '', 'x': '', 'operacao': funcaoController.text[i]};
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
