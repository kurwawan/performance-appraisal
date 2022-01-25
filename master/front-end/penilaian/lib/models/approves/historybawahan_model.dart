class HistoryBawahanModel {
  String nik;
  String nmp;
  String atasan;

  HistoryBawahanModel({
    this.nik,
    this.nmp,
    this.atasan,
  });

  HistoryBawahanModel.fromJson(Map<String, dynamic> json) {
    nik = json['nik'];
    nmp = json['nmp'];
    atasan = json['atasan'];
  }

  Map<String, dynamic> toJson() {
    return {
      'nik': nik,
      'nmp': nmp,
      'atasan': atasan,
    };
  }
}
