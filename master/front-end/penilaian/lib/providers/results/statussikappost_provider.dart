import 'package:flutter/widgets.dart';
import 'package:penilaian/models/results/sikappost_model.dart';

class StatusSikapPostProvider with ChangeNotifier {
  SikapPostModel _sikapPost;

  SikapPostModel get sikappost => _sikapPost;

  set sikappost(SikapPostModel newSikappost) {
    _sikapPost = newSikappost;
    notifyListeners();
  }
}
