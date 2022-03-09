// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Trabalho1 extends StatefulWidget {
  const Trabalho1({Key? key}) : super(key: key);

  @override
  State<Trabalho1> createState() => _Trabalho1State();
}

class _Trabalho1State extends State<Trabalho1> {
  //Controller da função e do intervalo
  TextEditingController funcaoController = TextEditingController(text: 'x3-x-1');
  TextEditingController intervaloController1 = TextEditingController(text: '-5');
  TextEditingController intervaloController2 = TextEditingController(text: '5');
  TextEditingController toleranciaController = TextEditingController(text: '0.001');

  Map parteDaEquacao = {};
  List equacoes = [
    {'numero': '', 'expoente': '', 'x': '', 'operacao': ''}
  ];
  bool exp = false;
  String _suaFuncao = 'Sua função:';

  int _passos = -1;
  double _x = -123456789;
  double _fx = -123456789;
  double _a = -123456789;
  double _b = -123456789;

  @override
  void initState() {
    super.initState();

    manipulaEquacao('x3-x-1');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.green[600],
          title: const Text('T1 - Questão 5'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    funcaoController.text = 'x3-x-1';
                    intervaloController1.text = '-5';
                    intervaloController2.text = '5';
                    toleranciaController.text = '0.001';
                    manipulaEquacao();
                  });
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        // backgroundColor: Colors.black,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Text(
                  _suaFuncao,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 12, 10, 0),
                  child: Wrap(children: [
                    for (int i = 0; i < equacoes.length; i++) ...[
                      Text(equacoes[i]['operacao'] ?? '', style: const TextStyle(fontSize: 32)),
                      Text(equacoes[i]['numero'] ?? '', style: const TextStyle(fontSize: 32)),
                      Text(equacoes[i]['x'] ?? '', style: const TextStyle(fontSize: 32)),
                      Text(equacoes[i]['expoente'] ?? '', style: const TextStyle(fontSize: 16)),
                    ],
                  ]),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            const Text('Função:'),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller: funcaoController,
                                onChanged: (text) {
                                  if (text.length > 1 && (text[text.length - 1] == '+' || text[text.length - 1] == '-')) {
                                    if (text[text.length - 2] == '+' || text[text.length - 2] == '-') {
                                      funcaoController.text = text.substring(0, text.length - 2) + text.substring(text.length - 1);
                                      FocusScope.of(context).unfocus();
                                    }
                                  }
                                  manipulaEquacao();
                                },
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9-+xX]'))],
                              ),
                            ),
                            IconButton(
                              onPressed: () => setState(() {
                                funcaoController.clear();
                                manipulaEquacao();
                              }),
                              tooltip: 'Apagar',
                              icon: const Icon(
                                Icons.clear,
                              ),
                              splashRadius: 12,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text('Tolerância:'),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 127,
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller: toleranciaController,
                                keyboardType: const TextInputType.numberWithOptions(),
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*[.]?[0-9]*'))],
                              ),
                            ),
                            IconButton(
                              onPressed: () => setState(() {
                                toleranciaController.clear();
                              }),
                              tooltip: 'Apagar',
                              icon: const Icon(Icons.clear),
                              splashRadius: 12,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text('Intervalo:'),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 60,
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller: intervaloController1,
                                keyboardType: const TextInputType.numberWithOptions(),
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-9-][0-9]*'))],
                              ),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 60,
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller: intervaloController2,
                                keyboardType: const TextInputType.numberWithOptions(),
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-9-][0-9]*'))],
                              ),
                            ),
                            IconButton(
                              onPressed: () => setState(() {
                                intervaloController1.clear();
                                intervaloController2.clear();
                              }),
                              tooltip: 'Apagar',
                              icon: const Icon(
                                Icons.clear,
                              ),
                              splashRadius: 12,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              child: const Text('Falsa Posição'),
                              onPressed: () => calcularFalsaPosicao(),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              child: const Text('Newton'),
                              onPressed: () => calcularNewton(),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _a > -123456789 ? Text('Passos dados: $_passos') : Container(),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _a > -123456789
                                ? _b > -123456789
                                    ? Text('a1: $_a')
                                    : Text('x_i: $_a')
                                : Container(),
                            _b > -123456789 ? const SizedBox(width: 20) : Container(),
                            _b > -123456789 ? Text('b1: $_b') : Container(),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _x > -123456789 ? Text('x: $_x') : Container(),
                        const SizedBox(height: 20),
                        _a > -123456789 ? Text('F(x): $_fx') : Container(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void manipulaEquacao([equacao]) {
    setState(() {
      if (funcaoController.text.isNotEmpty) {
        _suaFuncao = 'Sua função:';
      } else {
        _suaFuncao = 'Entre com uma função';
      }
      equacoes.clear();
      resetParteDaEquacao();

      for (int i = 0; i < funcaoController.text.length; i++) {
        if (funcaoController.text[i] != 'x' &&
            funcaoController.text[i] != 'X' &&
            funcaoController.text[i] != '+' &&
            funcaoController.text[i] != '-') {
          if (exp) {
            parteDaEquacao['expoente'] = parteDaEquacao['expoente'] + funcaoController.text[i];
          } else {
            parteDaEquacao['numero'] = parteDaEquacao['numero'] + funcaoController.text[i];
          }
        } else if (funcaoController.text[i] == 'x' || funcaoController.text[i] == 'X') {
          parteDaEquacao['x'] = 'x';
          exp = true;
        } else if (funcaoController.text[i] == '-' || funcaoController.text[i] == '+') {
          if (i == 0) {
            parteDaEquacao['operacao'] = funcaoController.text[i];
          } else {
            equacoes.add(parteDaEquacao);
            resetParteDaEquacao();
            parteDaEquacao['operacao'] = funcaoController.text[i];
            exp = false;
          }
        }

        //Sempre atualizar
        if (funcaoController.text.length - 1 == i) {
          equacoes.add(parteDaEquacao);
          resetParteDaEquacao();
          parteDaEquacao['operacao'] = funcaoController.text[i];
          exp = false;
        }
      }
    });
  }

  void resetParteDaEquacao() {
    parteDaEquacao = {'numero': '', 'expoente': '', 'x': '', 'operacao': ''};
    exp = false;
  }

  double getResultadoFuncao(double i) {
    double resultado = 0;
    for (var j = 0; j < equacoes.length; j++) {
      var valor = equacoes[j]['x'] == ''
          ? (equacoes[j]['numero'] == '' ? 0 : int.parse(equacoes[j]['numero']))
          : (equacoes[j]['numero'] == '' ? 1 : int.parse(equacoes[j]['numero'])) *
              pow(i, equacoes[j]['expoente'] == '' ? 1 : int.parse(equacoes[j]['expoente']));
      if (equacoes[j]['operacao'] == '-') {
        valor *= -1;
      }
      resultado += valor;
    }

    return resultado;
  }

  //Derivada 1 (não estou usando biblioteca, mas fazendo "na mão")
  double getResultadoDerivada1(double i) {
    double resultado = 0;
    for (var j = 0; j < equacoes.length; j++) {
      var valor = equacoes[j]['x'] == ''
          ? 0
          : (equacoes[j]['numero'] == '' ? 1 : int.parse(equacoes[j]['numero'])) *
              (equacoes[j]['expoente'] == '' ? 1 : int.parse(equacoes[j]['expoente'])) *
              pow(i, equacoes[j]['expoente'] == '' ? 0 : (int.parse(equacoes[j]['expoente']) - 1));
      if (equacoes[j]['operacao'] == '-') {
        valor *= -1;
      }
      resultado += valor;
    }
    return resultado;
  }

  //Derivada 2 (não estou usando biblioteca, mas fazendo "na mão")
  double getResultadoDerivada2(double i) {
    double resultado = 0;
    for (var j = 0; j < equacoes.length; j++) {
      var valor = equacoes[j]['x'] == ''
          ? 0
          : (equacoes[j]['numero'] == '' ? 1 : int.parse(equacoes[j]['numero'])) *
              (equacoes[j]['expoente'] == ''
                  ? 0
                  : int.parse(equacoes[j]['expoente']) < 2
                      ? 0
                      : (int.parse(equacoes[j]['expoente']) - 1) * int.parse(equacoes[j]['expoente'])) *
              pow(
                  i,
                  equacoes[j]['expoente'] == ''
                      ? 0
                      : int.parse(equacoes[j]['expoente']) < 2
                          ? 0
                          : (int.parse(equacoes[j]['expoente']) - 2));
      if (equacoes[j]['operacao'] == '-') {
        valor *= -1;
      }
      resultado += valor;
    }
    return resultado;
  }

  double getAouB(String letra) {
    int intervalo1 = int.parse(intervaloController1.text);
    int intervalo2 = int.parse(intervaloController2.text);

    int trocaSinal = -123456789;
    bool anteriorPositivo = false;

    for (var i = intervalo1; i <= intervalo2; i++) {
      double resultado = getResultadoFuncao(i.toDouble());
      bool positive = resultado > 0;

      if (i == intervalo1) {
        anteriorPositivo = positive;
      } else {
        if (anteriorPositivo != positive) {
          trocaSinal = i;
          anteriorPositivo = positive;
        }
      }
    }

    if (letra == 'a') {
      return (trocaSinal - 1).toDouble();
    } else if (letra == 'b') {
      return trocaSinal.toDouble();
    } else {
      return -123456789;
    }
  }

  void calcularFalsaPosicao() {
    FocusScope.of(context).unfocus();
    double a = getAouB('a');
    double b = a + 1;

    _a = a;
    _b = b;

    bool executar = true;
    int N = 1;
    while (executar) {
      double fa = getResultadoFuncao(a);
      double fb = getResultadoFuncao(b);

      double x_ns = (a * fb - b * fa) / (fb - fa);
      double fx_ns = getResultadoFuncao(x_ns);

      double fafx_ns = fa * fx_ns;
      double fbfx_ns = fb * fx_ns;

      double erro = fx_ns.abs();

      //Todos os passos
      // print('\n---------------------------\nN : ${N} \na : $a\nb : $b\nfa : $fa\nfb : $fb\nx_ns : $x_ns\nf(x_ns) : $fx_ns\nf(a)*f(x_ns) : $fafx_ns \nf(x_ns)*f(b) : $fbfx_ns\n-\n');
      if (erro < double.parse(toleranciaController.text)) {
        executar = false;

        setState(() {
          _passos = N;
          _x = x_ns;
          _fx = fx_ns;
        });
      }

      if (fafx_ns > fbfx_ns) {
        a = x_ns;
      } else {
        b = x_ns;
      }

      N++;
      if (N == 250) {
        setState(() {
          _suaFuncao = 'Mais de 250 passos... Interrompido!';
        });
        executar = false;
      }
    }
  }

  void calcularNewton() {
    FocusScope.of(context).unfocus();
    double a = getAouB('a');
    double b = a + 1;

    double fa = getResultadoFuncao(a);
    double fb = getResultadoFuncao(b);

    double f2a = getResultadoDerivada2(a);
    double f2b = getResultadoDerivada2(b);

    double x_i = -123456789;

    if (fa * f2a > fb * f2b) {
      _a = a;
      x_i = a;
    } else {
      _a = b;
      x_i = b;
    }

    setState(() {
      _b = -123456789;
    });

    bool executar = true;
    int N = 1;

    while (executar) {
      double fx_i = getResultadoFuncao(x_i);
      double f1x_i = getResultadoDerivada1(x_i);
      double x_i1 = x_i - fx_i / f1x_i;

      double erro = (x_i1 - x_i).abs();

      //Todos os passos
      // print(
      //     '\n---------------------------\nN : ${N} \nx_i : $x_i\nf(x_i) : $fx_i\nf1(x_i) : $f1x_i\nx_i+1 : $x_i1\ne_ideal : ${toleranciaController.text}\ne_real : $erro');
      if (erro < double.parse(toleranciaController.text)) {
        executar = false;
        setState(() {
          _passos = N;
          _x = x_i;
          _fx = fx_i;
        });
      }

      x_i = x_i1;

      N++;
      if (N == 250) {
        setState(() {
          _suaFuncao = 'Mais de 250 passos... Interrompido!';
        });
        executar = false;
      }
    }
  }
}
