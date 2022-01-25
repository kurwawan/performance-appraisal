class HasilKerjaCModel {
  String status;

  HasilKerjaCModel({
    this.status,
  });

  HasilKerjaCModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
    };
  }
}
