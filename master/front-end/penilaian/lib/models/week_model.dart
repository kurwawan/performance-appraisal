class WeekModel {
  String mingguN;
  String tglAwalMinggu;
  String tglAkhirMinggu;
  String nmPeriode;
  String idDetilPeriode;

  WeekModel({
    this.mingguN,
    this.tglAwalMinggu,
    this.tglAkhirMinggu,
    this.nmPeriode,
    this.idDetilPeriode,
  });

  WeekModel.fromJson(Map<String, dynamic> json) {
    mingguN = json['minggu_n'];
    tglAwalMinggu = json['tglawalminggu'];
    tglAkhirMinggu = json['tglakhirminggu'];
    nmPeriode = json['nmperiode'];
    idDetilPeriode = json['iddetilperiode'];
  }

  Map<String, dynamic> toJson() {
    return {
      'minggu_n': mingguN,
      'tglawalminggu': tglAwalMinggu,
      'tglakhirminggu': tglAkhirMinggu,
      'nmperiode': nmPeriode,
      'iddetilperiode': idDetilPeriode,
    };
  }
}
