import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penilaian/config.dart';
import 'package:penilaian/models/results/sikappost_model.dart';

class SikapPostProvider with ChangeNotifier {
  var config = Config.url;

  Future<SikapPostModel> insertSikap(
      String idperiode, String nik, String kdp, String ket) async {
    try {
      var body = {
        'idperiode': idperiode,
        'nik': nik,
        'kdp': kdp,
        'catat1': ket,
      };

      var response = await http.post(
        '$config/penilaian/web/api/post/insertsikap',
        body: body,
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        return SikapPostModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<SikapPostModel> deleteSikap(String idperiode, String nik) async {
    try {
      var body = {
        'idperiode': idperiode,
        'nik': nik,
      };

      var response = await http.post(
        '$config/penilaian/web/api/post/deletesikap',
        body: body,
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        return SikapPostModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<SikapPostModel> updateBukan(String idperiode, String nik) async {
    try {
      var body = {
        'idperiode': idperiode,
        'nik': nik,
      };

      var response = await http.post(
        '$config/penilaian/web/api/post/updatebukan',
        body: body,
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        return SikapPostModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
