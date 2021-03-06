import 'dart:convert';

import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/repository/qr_repository.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/features/login/auth/authentication_controller.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class HomeSupervisorController extends GetxController {
  final AuthenticationController _authenticationController = Get.find();

  var usuarioLogged = User().obs;
  var isLoadingScreen = false.obs;
  var valueQR = "".obs;

  void scanQR() async {
    valueQR.value = await FlutterBarcodeScanner.scanBarcode('#ff6666', "Cancelar", false, ScanMode.QR);
  }

   @override
  void onInit(){
    super.onInit();
    getUserLogged();
  }

  Future<User?> getUserLogged() async {
    UserRepository repo = UserRepositoryImpl();
    var currentUser = await repo.getCurrentUser();
    if(currentUser!=null){
      usuarioLogged.value = currentUser;
    }
    return currentUser;
  }

  void goToInfoAuth(String barcodeScanRes){
    valueQR.value = barcodeScanRes;
    Get.toNamed(AppLinks.INFO_AUTH, arguments: [json.encode((valueQR.value))]);
  }

  Future<void> closeSession() async {
    UserRepository repoUsuario = UserRepositoryImpl();
    QRRepository repoQR = QRRepositoryImpl();
    await repoUsuario.clearDataUser();
    await repoQR.clearQR();
    _authenticationController.signOut();
  }
}