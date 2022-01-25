import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penilaian/config.dart';
import 'package:penilaian/models/approves/historyatasan_model.dart';

class HistoryAtasanProvider with ChangeNotifier {
  var config = Config.url;

  Future<List<HistoryAtasanModel>> getHistory() async {
    try {
      var response =
          await http.get('$config/penilaian/web/api/get/historyatasan');

      if (response.statusCode == 200) {
        List<HistoryAtasanModel> approveHistories = [];
        List parsedJson = jsonDecode(response.body);

        parsedJson.forEach((approveHistory) {
          approveHistories.add(
            HistoryAtasanModel.fromJson(approveHistory),
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
