import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:penilaian/config.dart';
import 'package:penilaian/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  var config = Config.url;
  var spNip = '';

  Future<UserModel> login(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var jsonData;
    try {
      var body = {
        'username': username,
        'password': password,
      };

      var response;

      response = await http.post(
        '$config/penilaian/web/api/post/login',
        body: body,
      );

      print(response.statusCode);
      print(response.body.toString());

      if (response.statusCode == 200) {
        jsonData = json.decode(response.body);
        String status = jsonData['status'];
        String nip = jsonData['nip'];

        if (nip != null) {
          sharedPreferences.setString("nip", nip.toString());
        }

        if (status == 'true') {
          return UserModel.fromJson(jsonDecode(response.body));
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
