import 'dart:convert';

import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/repository/child_repository.dart';
import 'package:clean_app/data/repository/qr_repository.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/widgets/snackbars/snackbar_get_utils.dart';
import 'package:get/get.dart';

class HomeFatherController extends GetxController {

  var usuarioLogged = User().obs;
  var listChildren = List<Child>.empty().obs;
  String tokenStored = "";
  var showQRLoading = false.obs;
  var showQR = false.obs;
  var qrPrincipal = "".obs;

  @override
  void onInit(){
    super.onInit();
    getUserLogged();
    getChildren();
  }

  @override
  void onReady(){
    super.onReady();
    showSnackbarMessage();
  }

  Future<User?> getUserLogged() async {
    UserRepository repo = UserRepositoryImpl();
    var currentUser = await repo.getCurrentUser();
    if(currentUser!=null){
      usuarioLogged.value = currentUser;
    }
    return currentUser;
  }

  void showSnackbarMessage() {
    if(Get.arguments!=null) {
      var valuesSnackbar = json.decode(Get.arguments);
      if(valuesSnackbar["isSuccess"] == true) {
          showSuccessSnackbar(valuesSnackbar["title"], valuesSnackbar["message"]);
      }
    }
  }
  
  Future<List<Child>?> getChildren() async {
    UserRepository repoUsuario = UserRepositoryImpl();
    tokenStored = await repoUsuario.getToken();
    ChildRepository repo = ChildRepositoryImpl();
    var idApoderado = usuarioLogged.value.id;
    List<Child>? list = await repo.getListChild(tokenStored, idApoderado);
    if(list!=null){
      listChildren.value = list;
    }
    return list;
  }

  Future<String?> getQRPrincipal() async {
    showQRLoading.value = true;
    QRRepository qrRespository = QRRepositoryImpl();
    var idApoderado = usuarioLogged.value.id;
    var qr = await qrRespository.getQRPrincipal(idApoderado);
    showQR.value = true;
    showQRLoading.value = false;
    if(qr!=null){
      qrPrincipal.value = qr;
    }
    return qr;
  }

}