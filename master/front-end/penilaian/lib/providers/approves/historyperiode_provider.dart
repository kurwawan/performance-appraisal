import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penilaian/config.dart';
import 'package:penilaian/models/approves/historyperiode_model.dart';

class HistoryPeriodeProvider with ChangeNotifier {
  var config = Config.url;

  Future<List<HistoryPeriodeModel>> getHistory(String nik) async {
    try {
      var response = await http
          .get('$config/penilaian/web/api/get/historyperiode?nik=' + nik);

      if (response.statusCode == 200) {
        List<HistoryPeriodeModel> approveHistories = [];
        List parsedJson = jsonDecode(response.body);

        parsedJson.forEach((approveHistory) {
          approveHistories.add(
            HistoryPeriodeModel.fromJson(approveHistory),
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
