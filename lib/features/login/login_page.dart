import 'package:clean_app/constants/constants.dart';
import 'package:clean_app/features/login/auth/authentication_controller.dart';
import 'package:clean_app/features/login/auth/authentication_service.dart';
import 'package:clean_app/features/login/login_controller.dart';
import 'package:clean_app/widgets/background_color.dart';
import 'package:clean_app/widgets/buttons/rounded_button.dart';
import 'package:clean_app/widgets/inputs/rounded_input_field.dart';
import 'package:clean_app/widgets/inputs/rounded_input_pass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
    
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) => Scaffold(
        body: BackgroundColor(
          colorBackground: colorBackgroundWhite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [    
                SizedBox(height: size.height * 0.10),
                SvgPicture.asset(
                  "assets/images/rocket_app.svg",
                  height: size.height * 0.25,
                ),
                SizedBox(height: size.height * 0.10),
                RoundedInputField(
                  hintText: "Correo Electronico",
                  icon: Icons.account_circle_rounded,
                  onChanged: (value) {},
                ),
                RoundedPasswordField(
                  icon: Icons.lock,
                  onChanged: (value) {},
                  showPassword: controller.passVisibility,
                  functionTapIcon: () {
                    controller.changePassVisibility();
                  },
                ),
                RoundedButton(text: "Iniciar Sesión", color: accentColor, press: () => {}),
                SizedBox(height: size.height * 0.10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}