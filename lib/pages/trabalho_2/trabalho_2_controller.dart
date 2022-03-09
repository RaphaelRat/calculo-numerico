import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:math';

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
      // fxi = 2 * xi + 1 / xi;
      fxi = getResultadoFuncao(xi);
      ciFxi = ci * fxi;
      soma += ciFxi;
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
      // fxi = 2 * xi + 1 / xi;
      fxi = getResultadoFuncao(xi);
      ciFxi = ci * fxi;
      soma += ciFxi;
      // print(' i: $i\t xi: $xi\t  f(xi): $fxi\t ci: $ci\t ci*f(xi)$ciFxi');
    }
    s = h! / 3 * soma;
    // print('s: $s \t Soma: $soma');
    Get.defaultDialog(
      content: Text('Soma: ${soma.toStringAsFixed(4)}\nS(h$n): ${s.toStringAsFixed(4)}'),
      title: 'Regra de Simpson',
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

    integral.value = equacoes.isEmpty
        ? [
            {'numero': '2', 'expoente': '', 'x': 'x', 'operacao': ''},
            {'numero': '1', 'expoente': '', 'x': '', 'operacao': '+'},
            {'numero': '', 'expoente': '', 'x': 'x', 'operacao': '/'},
          ]
        : equacoes;
  }

  double getResultadoFuncao(double i) {
    double resultado = 0;
    num dividendo = 0;
    for (var j = 0; j < integral.length; j++) {
      var valor = integral[j]['x'] == ''
          ? (integral[j]['numero'] == '' ? 0 : int.parse(integral[j]['numero']!))
          : (integral[j]['numero'] == '' ? 1 : int.parse(integral[j]['numero']!)) *
              pow(i, integral[j]['expoente'] == '' ? 1 : int.parse(integral[j]['expoente']!));

      if (integral.length >= j + 2 && valor != 0) {
        if (integral[j + 1]['operacao'] == '/') {
          if (integral[j]['operacao'] == '-') {
            dividendo = -valor;
          } else {
            dividendo = valor;
          }
        } else if (integral[j]['operacao'] == '-') {
          valor *= -1;
          resultado += valor;
        } else if (integral[j]['operacao'] == '/') {
          valor = dividendo / valor;
          dividendo = 0;
          resultado += valor;
        } else {
          resultado += valor;
        }
      } else if (integral[j]['operacao'] == '-') {
        valor *= -1;
        resultado += valor;
      } else if (integral[j]['operacao'] == '/') {
        valor = dividendo / valor;
        dividendo = 0;
        resultado += valor != double.infinity && valor != -double.infinity ? valor : 0;
      } else {
        resultado += valor;
      }
    }

    return resultado;
  }

  double getResultadoFuncao2(double value) {
    num dividendo = 0.0;
    double resultado = 0;
    for (var j = 0; j < integral.length; j++) {
      var valor = integral[j]['x'] == ''
          ? (integral[j]['numero'] == '' ? 0 : int.parse(integral[j]['numero']!))
          : (integral[j]['numero'] == '' ? 1 : int.parse(integral[j]['numero']!)) *
              pow(value, integral[j]['expoente'] == '' ? 1 : int.parse(integral[j]['expoente']!));

      if (integral[j]['operacao'] == '-') {
        valor *= -1;
        resultado += valor;
      } else if (integral[j]['operacao'] == '+') {
        resultado += valor;
      } else if (integral[j]['operacao'] == '/') {
        valor = dividendo / valor;
        valor = valor == double.infinity ? 0 : valor;
        resultado += valor;
        dividendo = 0;
      } else if (j < integral.length - 1) {
        if (integral[j + 1]['operacao'] == '/') {
          dividendo = valor;
        } else {
          resultado += valor;
        }
      } else {
        resultado += valor;
      }
    }

    return resultado;
  }
}
