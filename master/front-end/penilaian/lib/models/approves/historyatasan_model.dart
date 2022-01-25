class HistoryAtasanModel {
  String nik;
  String ats;
  String ajbAts;
  String atasan;

  HistoryAtasanModel({
    this.nik,
    this.ats,
    this.ajbAts,
    this.atasan,
  });

  HistoryAtasanModel.fromJson(Map<String, dynamic> json) {
    nik = json['nik'];
    ats = json['ats'];
    ajbAts = json['ajb_ats'];
    atasan = json['atasan'];
  }

  Map<String, dynamic> toJson() {
    return {
      'nik': nik,
      'ats': ats,
      'ajb_ats': ajbAts,
      'atasan': atasan,
    };
  }
}
