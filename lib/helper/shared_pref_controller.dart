import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys { lang }

class SharedPrefController {
  static final SharedPrefController _instance =
      SharedPrefController._internal();
  late SharedPreferences _sharedPreferences;

  SharedPrefController._internal();

  factory SharedPrefController() {
    return _instance;
  }

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  setToken(String token) async {
    await _sharedPreferences.setString('token', token);
  }

  String? getToken() {
    return _sharedPreferences.getString('token');
  }


  setIsLogin(bool isLogin) async {
    await _sharedPreferences.setBool('isLogin', isLogin);
  }

  bool? getLogin() {
    return _sharedPreferences.getBool('isLogin');
  }

  setSeen(String key,bool isLogin) async {
    await _sharedPreferences.setBool(key, isLogin);
  }

  bool? getSeen(String key) {
    return _sharedPreferences.getBool(key);
  }

  setData(key,value)async{
    await _sharedPreferences.setString(key, value);
  }

  String? getData(key){
    return _sharedPreferences.getString(key);
  }

  clear(){
    return _sharedPreferences.clear();
  }

}
