import 'package:object_note/core/http/http.dart';
import 'package:object_note/modal/user.dart';

class Api {
  static Future<User> login(String username, String password) async {
    var data = {
      'username': username,
      'password': password,
    };
    var value = await Http().post('login', data: data);
    return User.fromJson(value);
  }

  static Future logout() async {
    return await Http().post('logout');
  }
}
