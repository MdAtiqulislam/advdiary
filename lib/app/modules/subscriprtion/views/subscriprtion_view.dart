import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/subscriprtion_controller.dart';

class SubscriprtionView extends GetView<SubscriprtionController> {
  const SubscriprtionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SubscriprtionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SubscriprtionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
