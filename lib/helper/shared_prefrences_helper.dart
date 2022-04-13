

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrencesHelper {
  SharedPrefrencesHelper._();

  SharedPreferences? sharedPrefrences ;

  static SharedPrefrencesHelper sharedPrefrencesHelper =
      SharedPrefrencesHelper._();


  initSharedPrefrences() async {
    sharedPrefrences = await SharedPreferences.getInstance();
  }

  setToken(String token) async {
    await sharedPrefrences!.setString('token', token);
  }

  String? getToken() {
    return sharedPrefrences!.getString('token');
  }

  setType(String type) async {
    await sharedPrefrences!.setString('type', type);
  }

  String? getType() {
    return sharedPrefrences!.getString('type');
  }

  setPassword(String password) async {
    await sharedPrefrences!.setString('password', password);
  }

  String? getPassword() {
    return sharedPrefrences!.getString('password');
  }

  setCodeCountry(String password) async {
    await sharedPrefrences!.setString('codeCountry', password);
  }

  String? getCodeCountry() {
    return sharedPrefrences!.getString('codeCountry');
  }

  setIsLogin(bool isLogin) async {
    await sharedPrefrences!.setBool('isLogin', isLogin);
  }

  bool? getLogin() {
    return sharedPrefrences!.getBool('isLogin');
  }

  setSeen(String key,bool isLogin) async {
    await sharedPrefrences!.setBool(key, isLogin);
  }

  bool? getSeen(String key) {
    return sharedPrefrences!.getBool(key);
  }

  setData(key,value)async{
    await sharedPrefrences!.setString(key, value);
  }

  String? getData(key){
    return sharedPrefrences!.getString(key);
  }

  clear(){
    return sharedPrefrences!.clear();
  }


}
