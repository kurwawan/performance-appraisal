class HistoryPeriodeModel {
  String idPeriode;
  String mingguN;
  String tglAwalMinggu;
  String tglAkhirMinggu;
  String nmPeriode;

  HistoryPeriodeModel({
    this.idPeriode,
    this.mingguN,
    this.tglAwalMinggu,
    this.tglAkhirMinggu,
    this.nmPeriode,
  });

  HistoryPeriodeModel.fromJson(Map<String, dynamic> json) {
    idPeriode = json['iddetilperiode'];
    mingguN = json['minggu_n'];
    tglAwalMinggu = json['tglawalminggu'];
    tglAkhirMinggu = json['tglakhirminggu'];
    nmPeriode = json['nmperiode'];
  }

  Map<String, dynamic> toJson() {
    return {
      'iddetilperiode': idPeriode,
      'minggu_n': mingguN,
      'tglawalminggu': tglAwalMinggu,
      'tglakhirminggu': tglAkhirMinggu,
      'nmperiode': nmPeriode,
    };
  }
}
