import 'package:clean_app/data/model/child.dart';
import 'package:clean_app/data/response/child/child_response.dart';

List<Child> getListChildResponseToListChild(List<ChildResponse> list){
  
  List<Child> listChild = [];
  list.forEach((childData) {
    var child =  Child();
    child.id = childData.id;
    child.nombres = childData.nombres;
    child.apPaterno = childData.apPaterno;
    child.apMaterno = childData.apMaterno;
    child.numDocumento = childData.numeroDocumento;
    child.isChecked = false;
    child.grado = childData.grado;
    listChild.add(child);
  });

  return listChild;
}