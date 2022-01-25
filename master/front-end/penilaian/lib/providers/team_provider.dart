import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penilaian/config.dart';
import 'package:penilaian/models/checking/checkteam_model.dart';
import 'package:penilaian/models/team_model.dart';

class TeamProvider with ChangeNotifier {
  var config = Config.url;

  Future<List<TeamModel>> getTeams(String nip, String idperiode) async {
    try {
      var response = await http.get(
          '$config/penilaian/web/api/get/listteam?nip=$nip&idperiode=$idperiode');

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        List<TeamModel> teams = [];
        List parsedJson = jsonDecode(response.body);

        parsedJson.forEach((team) {
          teams.add(
            TeamModel.fromJson(team),
          );
        });

        return teams;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<TeamModel>> getAllTeams(String nip, String idperiode) async {
    try {
      var response = await http.get(
          '$config/penilaian/web/api/get/updatelistteam?nip=$nip&idperiode=$idperiode');

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        List<TeamModel> teams = [];
        List parsedJson = jsonDecode(response.body);

        parsedJson.forEach((team) {
          teams.add(
            TeamModel.fromJson(team),
          );
        });

        return teams;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<CheckTeamModel>> getCheckTeams(
      String nip, String idperiode, String ajb) async {
    try {
      var response = await http.get(
          '$config/penilaian/web/api/get/checklistteam?nip=$nip&idperiode=$idperiode&ajb=$ajb');

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        List<CheckTeamModel> teams = [];
        List parsedJson = jsonDecode(response.body);

        parsedJson.forEach((team) {
          teams.add(
            CheckTeamModel.fromJson(team),
          );
        });

        return teams;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
