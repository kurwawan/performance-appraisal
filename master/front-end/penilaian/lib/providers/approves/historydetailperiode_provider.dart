import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penilaian/config.dart';
import 'package:penilaian/models/approves/historydetailperiode_model.dart';
import 'package:penilaian/models/approves/historyuser_model.dart';

class HistoryDetailPeriodeProvider with ChangeNotifier {
  var config = Config.url;

  Future<List<HistoryDetailPeriodeModel>> getHistory(
      String nik, String idPeriode) async {
    try {
      var response = await http.get(
          '$config/penilaian/web/api/get/historydetailperiode?nik=' +
              nik +
              '&idperiode=' +
              idPeriode);

      if (response.statusCode == 200) {
        List<HistoryDetailPeriodeModel> approveHistories = [];
        List parsedJson = jsonDecode(response.body);

        parsedJson.forEach((approveHistory) {
          approveHistories.add(
            HistoryDetailPeriodeModel.fromJson(approveHistory),
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

  Future<List<HistoryDetailPeriodeModel>> getNilaiLama(
      String nik, String idPeriode) async {
    try {
      var response = await http.get(
          '$config/penilaian/web/api/get/historydetailnilaiawal?nik=' +
              nik +
              '&idperiode=' +
              idPeriode);

      if (response.statusCode == 200) {
        List<HistoryDetailPeriodeModel> approveHistories = [];
        List parsedJson = jsonDecode(response.body);

        parsedJson.forEach((approveHistory) {
          approveHistories.add(
            HistoryDetailPeriodeModel.fromJson(approveHistory),
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

  Future<List<HistoryUserModel>> getAllStatus(String nik) async {
    try {
      var response = await http
          .get('$config/penilaian/web/api/get/listhistory?nik=' + nik);

      if (response.statusCode == 200) {
        List<HistoryUserModel> approveHistories = [];
        List parsedJson = jsonDecode(response.body);

        parsedJson.forEach((approveHistory) {
          approveHistories.add(
            HistoryUserModel.fromJson(approveHistory),
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
