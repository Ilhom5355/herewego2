import 'package:shared_preferences/shared_preferences.dart';

// class Prefs {
//   //User ID sini saqlash
//   static Future<bool> saveUserId(String user_id) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.setString('user_id', user_id);
//   }
//
//   //User ID sini oilb ishlatish
//   static Future<String> loadUserId() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString("user_id");
//     return token;
//   }
//
//   //User ni o`chirib tashlash
//   static Future<bool> removeUserId() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.remove("user_id");
//   }
// }

class Prefs{

  // id saqlash
  static Future <bool> saveUserId(String user_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('user_id', user_id);
  }

  // olib ishlatish
  static Future <String?> loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('user_id');
    return token;
  }

  // id o`chirib tashlash
  static Future<bool> removeUserId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('user_id');
  }
}