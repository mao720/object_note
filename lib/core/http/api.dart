import 'package:dio/dio.dart';
import 'package:object_note/core/http/http.dart';
import 'package:object_note/core/utils/constants.dart';
import 'package:object_note/core/utils/device_util.dart';
import 'package:object_note/modal/note.dart';
import 'package:object_note/modal/results.dart';
import 'package:object_note/modal/user.dart';

import '../../modal/label.dart';

class Api {
  static Future<User> login(String username, String password) async {
    var data = {
      'username': username,
      'password': password,
    };
    var deviceName = await DeviceUtil.getDeviceName();
    var options = Options(
      headers: {Constants.headerInstallationName: deviceName},
    );
    var value = await Http().post('login', data: data, options: options);
    return User.fromJson(value);
  }

  static Future logout() async {
    return await Http().post('logout');
  }

  static Future<User> getUser(String id) async {
    var value = await Http().get('users/$id');
    return User.fromJson(value);
  }

  static Future updateUser(String id, {String avatarUrl = ''}) async {
    var data = {'avatar': avatarUrl};
    return await Http().put('users/$id', data: data);
  }

  static Future<List<Note>> getNotes() async {
    var value = await Http().get('classes/note');
    return (Results.fromJson(value).results ?? [])
        .map((e) => Note.fromJson(e))
        .toList();
  }

  static Future createNote(Note note) async {
    return await Http().post('classes/note', data: note.toJson());
  }

  static Future updateNote(Map note, String id) async {
    return await Http().put('classes/note/$id', data: note);
  }

  static Future deleteNote(String id) async {
    return await Http().delete('classes/note/$id');
  }

  static Future createLabel(Label label) async {
    return await Http().post('classes/label', data: label.toJson());
  }

  static Future<bool> isLabelExist(Label label) async {
    var value = await Http().get('classes/label', queryParameters: {
      'where': {'name': label.name},
    });
    var results = Results.fromJson(value).results;
    return results != null && results.isNotEmpty;
  }

  static Future<List<Label>> getLabels(String userId) async {
    var value = await Http().get('classes/label');
    return (Results.fromJson(value).results ?? [])
        .map((e) => Label.fromJson(e))
        .toList();
  }

  static Future deleteLabel(String id) async {
    return await Http().delete('classes/label/$id');
  }

  static Future uploadToOSS(String filePath, String name) async {
    return await Http().uploadToOSS(filePath, name);
  }

  static Future uploadToOSSWeb(List<int> intList, String name) async {
    return await Http().uploadToOSSWeb(intList, name);
  }
}
