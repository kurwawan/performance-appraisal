class TeamModel {
  String idDetilPeriode;
  String ats;
  String nikb;
  String nmp;
  String alv;
  String jbtb;
  String mingguN;
  String kdPeriode;

  TeamModel({
    this.idDetilPeriode,
    this.ats,
    this.nikb,
    this.nmp,
    this.alv,
    this.jbtb,
    this.mingguN,
    this.kdPeriode,
  });

  TeamModel.fromJson(Map<String, dynamic> json) {
    idDetilPeriode = json['iddetilperiode'];
    ats = json['ats'];
    nikb = json['nikb'];
    nmp = json['nmp'];
    alv = json['alv'];
    jbtb = json['jbtb'];
    mingguN = json['minggu_n'];
    kdPeriode = json['kdperiode'];
  }

  Map<String, dynamic> toJson() {
    return {
      'iddetilperiode': idDetilPeriode,
      'ats': ats,
      'nikb': nikb,
      'nmp': nmp,
      'alv': alv,
      'jbtb': jbtb,
      'minggu_n': mingguN,
      'kdPeriode': kdPeriode,
    };
  }
}
