class ConfirmApproveModel {
  String status;

  ConfirmApproveModel({
    this.status,
  });

  ConfirmApproveModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
    };
  }
}
