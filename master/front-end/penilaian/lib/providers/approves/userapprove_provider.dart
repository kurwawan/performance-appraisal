import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penilaian/config.dart';
import 'package:penilaian/models/approves/userapprove_model.dart';

class UserApproveProvider with ChangeNotifier {
  var config = Config.url;

  Future<List<UserApproveModel>> getApproveUsers(String tgu) async {
    try {
      var response = await http
          .get('$config/penilaian/web/api/get/listuserapprove?tgu=' + tgu);

      // print(response.body);

      if (response.statusCode == 200) {
        List<UserApproveModel> approveUsers = [];
        List parsedJson = jsonDecode(response.body);

        parsedJson.forEach((approveUser) {
          approveUsers.add(
            UserApproveModel.fromJson(approveUser),
          );
        });

        return approveUsers;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
