class HasilKerjaModel {
  String status;

  HasilKerjaModel({
    this.status,
  });

  HasilKerjaModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
    };
  }
}
