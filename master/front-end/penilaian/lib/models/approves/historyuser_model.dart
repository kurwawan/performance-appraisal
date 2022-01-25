class HistoryUserModel {
  String id;
  String nmp;
  String idPeriode;
  String tgu;
  String status;
  String nmPeriode;
  String mingguN;
  String tglAwalMinggu;
  String tglAkhirMinggu;
  String alsFrom;
  String alsTo;

  HistoryUserModel({
    this.id,
    this.nmp,
    this.idPeriode,
    this.tgu,
    this.status,
    this.nmPeriode,
    this.mingguN,
    this.tglAwalMinggu,
    this.tglAkhirMinggu,
    this.alsFrom,
    this.alsTo,
  });

  HistoryUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nmp = json['nmp'];
    idPeriode = json['iddetilperiode'];
    tgu = json['tgu'];
    status = json['status'];
    nmPeriode = json['nmperiode'];
    mingguN = json['minggu_n'];
    tglAwalMinggu = json['tglawalminggu'];
    tglAkhirMinggu = json['tglakhirminggu'];
    alsFrom = json['als_from'];
    alsTo = json['als_to'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nmp': nmp,
      'iddetilperiode': idPeriode,
      'tgu': tgu,
      'status': status,
      'nmperiode': nmPeriode,
      'minggu_n': mingguN,
      'tglawalminggu': tglAwalMinggu,
      'tglakhirminggu': tglAkhirMinggu,
      'als_from': alsFrom,
      'als_to': alsTo,
    };
  }
}
