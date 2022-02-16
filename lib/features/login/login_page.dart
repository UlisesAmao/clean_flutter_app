import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/constants/dimensions.dart';
import 'package:clean_app/constants/text_constants.dart';
import 'package:clean_app/features/login/auth/authentication_controller.dart';
import 'package:clean_app/features/login/auth/authentication_service.dart';
import 'package:clean_app/features/login/login_controller.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:clean_app/utils/function_utils.dart';
import 'package:clean_app/widgets/background_color.dart';
import 'package:clean_app/widgets/buttons/rounded_button.dart';
import 'package:clean_app/widgets/inputs/rounded_input_form_field_normal.dart';
import 'package:clean_app/widgets/inputs/rounded_input_form_field_pass.dart';
import 'package:clean_app/widgets/labels/label_tap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
    
  @override
  Widget build(BuildContext context) {
    
    Future.delayed(Duration.zero, () => showAlert(context));

    Size size = MediaQuery.of(context).size;
    
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: BackgroundColor(
            colorBackground: colorBackgroundWhite,
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: controller.isSubmitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                //autovalidateMode:AutovalidateMode.onUserInteraction,
                key: controller.loginFormkey,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [    
                  SizedBox(height: size.height * 0.02),
                  Image.asset("assets/images/app_logo.png", height: size.height * 0.5),
                  RoundedTextFormFieldNormal(
                    onChanged: (value) {},
                    controller: controller.emailController, 
                    leftIcon: Icons.account_circle_rounded,
                    validatorFunction: (value) => controller.validateEmail(value),
                    valueData: controller.email,
                  ),
                  const SizedBox(height: dimenMedium),
                  RoundedTextFormFieldPass(
                    onChanged: (value) {},
                    functionTapIcon: () => controller.changePassVisibility(), 
                    showPassword: controller.passVisibility,
                    controller: controller.passwordController, 
                    leftIcon: Icons.lock,
                    validatorFunction: (value) => controller.validatePassword(value),
                    valueData: controller.password,
                  ),
                  const SizedBox(height: dimenMedium),
                  controller.isLoading? CircularProgressIndicator() : RoundedButton(
                    text: loginPageButtonLogin,
                    color: accentColor, 
                    press: () => controller.checkLogin() 
                    //controller.checkLogin
                  ),
                  SizedBox(height: size.height * 0.05),
                  TextLabelTap(
                    press: () => {
                      //openBrowser("https://villamaria.edu.pe/")
                      Get.toNamed(AppLinks.RESET_PASSWORD)
                    },
                    textLabel: loginPageTextTapForgotPass
                  ), 
                  SizedBox(height: size.height * 0.01),
                  TextLabelTap(
                    press: () => {
                      Get.toNamed(AppLinks.REGISTER_CHARGER)
                    },
                    textLabel: loginPageTextTapNewAccountPickup
                  ), 
                  SizedBox(height: size.height * 0.10),
                  /*
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => {
                          Get.offAndToNamed(AppLinks.HOME_FATHER)
                        }, 
                        icon: Icon(Icons.supervised_user_circle_sharp)
                      ),
                      IconButton(
                        onPressed: () => {
                          Get.offAndToNamed(AppLinks.HOME_CHARGE)
                        }, 
                        icon: Icon(Icons.access_alarm_sharp)
                      ),
                      IconButton(
                        onPressed: () => {
                          Get.offAndToNamed(AppLinks.HOME_SUPERVISOR)
                        }, 
                        icon: Icon(Icons.check_box)
                      )
                    ],
                  )*/
                ],
              ),
              )
            ),
          ),
        )
      ),
    );
  }

  void showAlert(BuildContext context) {
    if(GetPlatform.isDesktop){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Aviso"),
            content: Text("Esta aplicación está preparada para dispostivos móviles, por favor dirigase en el siguiente Link"),
            actions: [
              TextButton(onPressed: () {
                openBrowser("https://villamaria.edu.pe/");
              }, child: const Text("Android"),)
            ],
          )
      );
    }
  }
}