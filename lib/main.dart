import 'package:clean_app/features/login/auth/authentication_controller.dart';
import 'package:clean_app/features/login/auth/authentication_service.dart';
import 'package:clean_app/features/login/auth/authentication_state.dart';
import 'package:clean_app/features/login/login_page.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:clean_app/features/demo/demo_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  initialize();
  runApp(MyApp());
}

void initialize(){
  //Load all controllers
  Get.lazyPut(() => AuthenticationController(Get.put(FakeAuthenticationService())),);
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AuthenticationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Clean App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: AppRoutes.pages,
      debugShowCheckedModeBanner: false,
      home: Obx(() {
        if(controller.state is Authenticated){
          return LoginPage();
        }
        if(controller.state is UnAuthenticated){
          return DemoPage();
        }
        return DemoPage();
      }),
    );
  }
}