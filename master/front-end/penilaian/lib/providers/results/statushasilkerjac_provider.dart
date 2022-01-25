import 'package:flutter/widgets.dart';
import 'package:penilaian/models/results/hasilkerjac_model.dart';

class StatusHasilKerjaCProvider with ChangeNotifier {
  HasilKerjaCModel _hasilKerjaC;

  HasilKerjaCModel get hasilkerjac => _hasilKerjaC;

  set hasilkerjac(HasilKerjaCModel newHasilkerjac) {
    _hasilKerjaC = newHasilkerjac;
    notifyListeners();
  }
}
