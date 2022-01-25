class UserModel {
  String nip;
  String ni2;
  String ket;
  String nmp;
  String jbt;
  String ajb;
  String adp;
  String alv;

  UserModel({
    this.nip,
    this.ni2,
    this.ket,
    this.nmp,
    this.jbt,
    this.ajb,
    this.adp,
    this.alv,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    nip = json['nip'];
    ni2 = json['nip2'];
    ket = json['ket'];
    nmp = json['nmp'];
    jbt = json['jbt'];
    ajb = json['ajb'];
    adp = json['adp'];
    alv = json['alv'];
  }

  Map<String, dynamic> toJson() {
    return {
      'nip': nip,
      'ni2': ni2,
      'ket': ket,
      'nmp': nmp,
      'jbt': jbt,
      'ajb': ajb,
      'adp': adp,
      'alv': alv,
    };
  }
}
