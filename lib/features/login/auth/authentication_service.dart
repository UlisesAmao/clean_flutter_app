import 'dart:convert';

import 'package:clean_app/data/converters/user_model_from_user_response.dart';
import 'package:clean_app/data/model/user.dart';
import 'package:clean_app/data/repository/user_repository.dart';
import 'package:clean_app/data/response/api_result_response.dart';
import 'package:clean_app/data/response/auth/authentication_data.dart';
import 'package:clean_app/data/response/path_services.dart';
import 'package:clean_app/navigation/app_routes.dart';
import 'package:clean_app/services/dio_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationService extends GetxService {

  Future<User?> getCurrentUser();
  Future<User> signInEmailAndPassword(String username, String password, bool rememberAccount);
  Future<void> signOut();

}

class AuthenticationServiceImpl extends AuthenticationService {
  static var client = http.Client();

  @override
  Future<User> signInEmailAndPassword(String username, String password, bool rememberAccount) async {
    
    HttpDioService httpService = HttpDioService();
    httpService.init();

    var userLogged = User();
    var url = pathServer+stage+loginService;

    
    try {
      var response = await httpService.request(
        url: url,
        method: Method.POST,
        params: {
          "username": username,
          "password": password
        }
      );
      if(response.statusCode == 200){
        UserRepository repo = UserRepositoryImpl();
        var apiResultResponse = ApiResultResponse.fromJson(response.data);
        var dataResponse = AuthenticationData.fromJson(apiResultResponse.data);
        if(rememberAccount){
          repo.rememberAccount(true);
          repo.rememberUser(username);
          repo.rememberPassword(password);
        } else {
          repo.clearDataRemember();
        }
        //if(dataResponse.reseteo == false){
        if(dataResponse.reseteo){
          //await repo.saveUser(dataResponse.userBd);
          await repo.saveAuxiliarUser(dataResponse.userBd);
          await repo.saveToken(dataResponse.authenticationResult.idToken);
          await repo.saveRefreshToken(dataResponse.authenticationResult.refreshToken);
          userLogged = getUserFromUserBD(dataResponse.userBd);
          userLogged.reseteo = true;
          Get.offAndToNamed(AppLinks.FORGOT_PAGE, arguments: [json.encode({"userDb": dataResponse.userBd, "token": dataResponse.authenticationResult.idToken, "refresh": dataResponse.authenticationResult.refreshToken})]);
        } else {
          await repo.saveToken(dataResponse.authenticationResult.idToken);
          await repo.saveRefreshToken(dataResponse.authenticationResult.refreshToken);
          userLogged = getUserFromUserBD(dataResponse.userBd);
          await repo.saveUser(dataResponse.userBd);
        }

        /**/
      } else {
        throw AuthenticationException(message: 'Wrong username or password');
      }
    } catch (e){
      throw AuthenticationException(message: 'Wrong username or password');
    }

    return userLogged;
  }

  
  @override
  Future<User?> getCurrentUser() async {
    UserRepository repo = UserRepositoryImpl();
    return await repo.getCurrentUser();
    //await Future.delayed(Duration(seconds: 2));
    //return null;
  }

  
  @override
  Future<void> signOut() async {
    // TODO: implement signOut
    //throw UnimplementedError();
  }
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({this.message = 'Unknown error occurred. '});
}