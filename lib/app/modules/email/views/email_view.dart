import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/email_controller.dart';

class EmailView extends GetView<EmailController> {
  const EmailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EmailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EmailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
