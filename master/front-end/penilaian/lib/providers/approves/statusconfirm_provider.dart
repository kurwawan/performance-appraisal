import 'package:flutter/widgets.dart';
import 'package:penilaian/models/approves/confirmapprove_model.dart';

class StatusConfirmProvider with ChangeNotifier {
  ConfirmApproveModel _confirmApprove;

  ConfirmApproveModel get confirmapprove => _confirmApprove;

  set confirmapprove(ConfirmApproveModel newConfirmapprove) {
    _confirmApprove = newConfirmapprove;
    notifyListeners();
  }
}
