import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './trabalho_2_controller.dart';

class Trabalho2 extends GetView<Trabalho2Controller> {
  const Trabalho2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('T2 - Questão 4'), centerTitle: true),
    );
  }
}
