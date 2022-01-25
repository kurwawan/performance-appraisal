import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penilaian/config.dart';
import 'package:penilaian/models/approves/historybawahan_model.dart';

class HistoryBawahanProvider with ChangeNotifier {
  var config = Config.url;

  Future<List<HistoryBawahanModel>> getHistory(
      String ats, String ajbAts) async {
    try {
      var response = await http.get(
          '$config/penilaian/web/api/get/historybawahan?ats=' +
              ats +
              '&ajb_ats=' +
              ajbAts);

      if (response.statusCode == 200) {
        List<HistoryBawahanModel> approveHistories = [];
        List parsedJson = jsonDecode(response.body);

        parsedJson.forEach((approveHistory) {
          approveHistories.add(
            HistoryBawahanModel.fromJson(approveHistory),
          );
        });
        return approveHistories;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
