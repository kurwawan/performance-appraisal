import 'package:flutter/widgets.dart';
import 'package:penilaian/models/results/hasilkerja_model.dart';

class StatusHasilKerjaProvider with ChangeNotifier {
  HasilKerjaModel _hasilKerja;

  HasilKerjaModel get hasilkerja => _hasilKerja;

  set hasilkerja(HasilKerjaModel newHasilkerja) {
    _hasilKerja = newHasilkerja;
    notifyListeners();
  }
}
