import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penilaian/config.dart';
import 'package:penilaian/models/week_model.dart';

class WeekProvider with ChangeNotifier {
  var config = Config.url;

  Future<List<WeekModel>> getWeeks(String nip) async {
    try {
      var response =
          await http.get('$config/penilaian/web/api/get/listweek?nip=$nip');

      /* print(response.statusCode);
      print(response.body); */

      if (response.statusCode == 200) {
        List<WeekModel> weeks = [];
        List parsedJson = jsonDecode(response.body);

        parsedJson.forEach((week) {
          weeks.add(
            WeekModel.fromJson(week),
          );
        });

        return weeks;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<WeekModel>> getAllWeeks(String nip) async {
    try {
      var response = await http
          .get('$config/penilaian/web/api/get/updatelistweek?nip=$nip');

      /* print(response.statusCode);
      print(response.body); */

      if (response.statusCode == 200) {
        List<WeekModel> weeks = [];
        List parsedJson = jsonDecode(response.body);

        parsedJson.forEach((week) {
          weeks.add(
            WeekModel.fromJson(week),
          );
        });

        return weeks;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<WeekModel>> getCheckWeeks(String nip, String ajb) async {
    try {
      var response = await http
          .get('$config/penilaian/web/api/get/checklistweek?nip=$nip&ajb=$ajb');

      /* print(response.statusCode);
      print(response.body); */

      if (response.statusCode == 200) {
        List<WeekModel> weeks = [];
        List parsedJson = jsonDecode(response.body);

        parsedJson.forEach((week) {
          weeks.add(
            WeekModel.fromJson(week),
          );
        });

        return weeks;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
