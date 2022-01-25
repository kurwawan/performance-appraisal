class CheckTeamModel {
  String nip;
  String ket;
  String nmp;
  String jbt;
  String ajb;
  String adp;

  CheckTeamModel({
    this.nip,
    this.ket,
    this.nmp,
    this.jbt,
    this.ajb,
    this.adp,
  });

  CheckTeamModel.fromJson(Map<String, dynamic> json) {
    nip = json['nip'];
    ket = json['ket'];
    nmp = json['nmp'];
    jbt = json['jbt'];
    ajb = json['ajb'];
    adp = json['adp'];
  }

  Map<String, dynamic> toJson() {
    return {
      'nip': nip,
      'ket': ket,
      'nmp': nmp,
      'jbt': jbt,
      'ajb': ajb,
      'adp': adp,
    };
  }
}
