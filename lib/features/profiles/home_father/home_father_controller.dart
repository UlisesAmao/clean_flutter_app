import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/repository/child_repository.dart';
import 'package:clean_app/data/repository/qr_repository.dart';
import 'package:clean_app/data/repository/user_repository.dart';
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

  Future<User?> getUserLogged() async {
    UserRepository repo = UserRepositoryImpl();
    var currentUser = await repo.getCurrentUser();
    if(currentUser!=null){
      usuarioLogged.value = currentUser;
    }
    return currentUser;
  }
  
  Future<List<Child>?> getChildren() async {
    UserRepository repoUsuario = UserRepositoryImpl();
    tokenStored = await repoUsuario.getToken();
    ChildRepository repo = ChildRepositoryImpl();
    var idApoderado = usuarioLogged.value.id;
    idApoderado = 5;
    List<Child>? list = await repo.getListChild(tokenStored, idApoderado);
    if(list!=null){
      listChildren.value = list;
    }
    return list;
  }

  Future<String?> getQRPrincipal() async {
    showQRLoading.value = true;
    QRRepository qrRespository = QRRepositoryImpl();
    var qr = await qrRespository.getQRPrincipal();
    showQR.value = true;
    showQRLoading.value = false;
    if(qr!=null){
      qrPrincipal.value = qr;
    }
    return qr;
  }

}