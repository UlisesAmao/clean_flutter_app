import 'package:clean_app/features/demo/demo_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DemoController>(
      init: DemoController(),
      builder: (controller) => Scaffold(
        body: Center(
          child: Text("Por favor ingrese con otro perfil")
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}