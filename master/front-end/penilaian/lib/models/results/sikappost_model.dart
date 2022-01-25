class SikapPostModel {
  String status;

  SikapPostModel({
    this.status,
  });

  SikapPostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
    };
  }
}
