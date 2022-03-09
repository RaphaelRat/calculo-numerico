import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './trabalho_2_controller.dart';

class Trabalho2 extends GetView<Trabalho2Controller> {
  const Trabalho2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('T2 - Questão 4'), centerTitle: true),
        body: Column(
          children: [
            Obx(
              () => controller.integral.value.isEmpty
                  // Image.asset('assets/integral.png'),
                  ? Container()
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                      width: double.infinity,
                      height: 80,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).primaryColor,
                        border: Border.all(width: 1, color: Theme.of(context).focusColor),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Image.asset('assets/integral.png'), Text(controller.integral.value)],
                      ),
                    ),
            ),
            TextField(
              onChanged: (value) {
                controller.integral.value = value;
              },
            )
          ],
        ),
      ),
    );
  }
}
