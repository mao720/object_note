import 'package:object_note/core/http/http.dart';
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
    var value = await Http().post('login', data: data);
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

  static Future<List<Note>> getNotes(String userId) async {
    var value = await Http().get('classes/note', queryParameters: {
      'where': {'userId': userId},
    });
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
      'where': {'userId': label.userId, 'name': label.name},
    });
    var results = Results.fromJson(value).results;
    return results != null && results.isNotEmpty;
  }

  static Future<List<Label>> getLabels(String userId) async {
    var value = await Http().get('classes/label', queryParameters: {
      'where': {'userId': userId},
    });
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
