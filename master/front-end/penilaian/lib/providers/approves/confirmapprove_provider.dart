import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penilaian/config.dart';
import 'package:penilaian/models/approves/confirmapprove_model.dart';

class ConfirmApproveProvider with ChangeNotifier {
  var config = Config.url;

  Future<ConfirmApproveModel> confirmToUser(String alsTo, String status,
      String id, String idPeriode, String nik, String ctt) async {
    try {
      var body = {
        'als_to': alsTo,
        'status': status,
        'id': id,
        'idperiode': idPeriode,
        'nik': nik,
        'ctt': ctt,
      };

      var response = await http.post(
        '$config/penilaian/web/api/post/konfirmasipengajuan',
        body: body,
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        return ConfirmApproveModel.fromJson(
          jsonDecode(response.body),
        );
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
