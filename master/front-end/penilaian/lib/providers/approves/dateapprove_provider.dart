import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penilaian/config.dart';
import 'package:penilaian/models/approves/dateapprove_model.dart';

class DateApproveProvider with ChangeNotifier {
  var config = Config.url;

  Future<List<DateApproveModel>> getApproveDays() async {
    try {
      var response =
          await http.get('$config/penilaian/web/api/get/listdateapprove');

      if (response.statusCode == 200) {
        List<DateApproveModel> approveDays = [];
        List parsedJson = jsonDecode(response.body);

        parsedJson.forEach((approveDay) {
          approveDays.add(
            DateApproveModel.fromJson(approveDay),
          );
        });

        return approveDays;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
