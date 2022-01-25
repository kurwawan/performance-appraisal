import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penilaian/config.dart';
import 'package:penilaian/models/results/hasilkerjac_model.dart';

class HasilKerjaCProvider with ChangeNotifier {
  var config = Config.url;

  Future<HasilKerjaCModel> insertHasilKerjaC(
      String kdperiode, String nik, String idperiode, String c4) async {
    try {
      var body = {
        'kdperiode': kdperiode,
        'nik': nik,
        'idperiode': idperiode,
        'c_4': c4,
      };

      var response = await http.post(
        '$config/penilaian/web/api/post/inserthasilkerjac',
        body: body,
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        return HasilKerjaCModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<HasilKerjaCModel> updateHasilKerjaC(
      String idperiode, String nik, String c4) async {
    try {
      var body = {
        'idperiode': idperiode,
        'nik': nik,
        'c_4': c4,
      };

      var response = await http.post(
        '$config/penilaian/web/api/post/updatehasilkerjac',
        body: body,
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        return HasilKerjaCModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
