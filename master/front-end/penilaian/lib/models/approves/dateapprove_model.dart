class DateApproveModel {
  String tgu;
  DateApproveModel({
    this.tgu,
  });

  DateApproveModel.fromJson(Map<String, dynamic> json) {
    tgu = json['tgu'];
  }

  Map<String, dynamic> toJson() {
    return {
      'tgu': tgu,
    };
  }
}
