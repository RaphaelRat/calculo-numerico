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
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      width: double.infinity,
                      height: 112,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade300,
                        border: Border.all(width: 1, color: Theme.of(context).focusColor),
                      ),
                      child: controller.integral.value.isEmpty
                          ? const Center(
                              child: Text(
                                'Sua integral aqui',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(controller.a.value),
                                    SizedBox(height: 54, child: Image.asset('assets/integral.png')),
                                    Text(controller.b.value),
                                  ],
                                ),
                                Text(
                                  '${controller.funcao.value} dx',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                VerticalDivider(color: Theme.of(context).focusColor),
                                const SizedBox(width: 16),
                                Text('n = ${controller.n.value}'),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Entre com a integral:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _myTextField(context, hintText: '2x+1/x', onChanged: (value) => controller.funcao.value = value),
                  const SizedBox(height: 12),
                  const Text('Entre com o intervalo:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text('a:', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(child: _myTextField(context, hintText: '0', onChanged: (value) => controller.a.value = value)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('b:', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(child: _myTextField(context, hintText: '1', onChanged: (value) => controller.b.value = value)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Entre com o valor de n:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _myTextField(context, hintText: '10', onChanged: (value) => controller.n.value = value),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Regra dos Trapézios'),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Regra do Simpson'),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextField _myTextField(BuildContext context, {Function(String value)? onChanged, String? hintText}) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).focusColor, width: 3.0, style: BorderStyle.solid),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).focusColor, width: 1.0),
        ),
        hintText: hintText,
      ),
      onChanged: onChanged,
    );
  }
}
