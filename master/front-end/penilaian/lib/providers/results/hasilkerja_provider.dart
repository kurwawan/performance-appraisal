import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penilaian/config.dart';
import 'package:penilaian/models/results/hasilkerja_model.dart';

class HasilKerjaProvider with ChangeNotifier {
  var config = Config.url;

  Future<HasilKerjaModel> updateHasilKerja(
      String idperiode,
      String nik,
      String a1,
      String a2,
      String a3,
      String a4,
      String ket,
      String tgu) async {
    try {
      var body = {
        'idperiode': idperiode,
        'nik': nik,
        'a_1': a1,
        'a_2': a2,
        'a_3': a3,
        'a_4': a4,
        'ctt': ket,
        'tgu': tgu,
      };

      var response = await http.post(
        '$config/penilaian/web/api/post/hasilkerja',
        body: body,
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        return HasilKerjaModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<HasilKerjaModel> insertTempHasilKerja(
    String idperiode,
    String nik,
    String ats,
    String ajbAts,
    String a1,
    String a2,
    String a3,
    String a4,
    String ctt,
    String c4,
    String alsFrom,
  ) async {
    try {
      var body = {
        'idperiode': idperiode,
        'nik': nik,
        'ats': ats,
        'ajb_ats': ajbAts,
        'a1': a1,
        'a2': a2,
        'a3': a3,
        'a4': a4,
        'ctt': ctt,
        'c4': c4,
        'als_from': alsFrom,
      };

      var response = await http.post(
        '$config/penilaian/web/api/post/inserttemp',
        body: body,
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        return HasilKerjaModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<HasilKerjaModel> insertTempSecondHasilKerja(
    String idperiode,
    String nik,
    String ats,
    String ajbAts,
    String a1,
    String a2,
    String a3,
    String a4,
    String c4,
  ) async {
    try {
      var body = {
        'idperiode': idperiode,
        'nik': nik,
        'ats': ats,
        'ajb_ats': ajbAts,
        'a1': a1,
        'a2': a2,
        'a3': a3,
        'a4': a4,
        'c4': c4,
      };

      var response = await http.post(
        '$config/penilaian/web/api/post/insertsecondtemp',
        body: body,
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        return HasilKerjaModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
