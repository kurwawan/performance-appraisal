class HistoryDetailPeriodeModel {
  String id;
  String idPeriode;
  String tgu;
  String status;
  String alsFrom;
  String alsTo;
  String a1;
  String a2;
  String a3;
  String a4;
  String c4;

  HistoryDetailPeriodeModel({
    this.id,
    this.idPeriode,
    this.tgu,
    this.status,
    this.alsFrom,
    this.alsTo,
    this.a1,
    this.a2,
    this.a3,
    this.a4,
    this.c4,
  });

  HistoryDetailPeriodeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idPeriode = json['iddetilperiode'];
    tgu = json['tgu'];
    status = json['status'];
    alsFrom = json['als_from'];
    alsTo = json['als_to'];
    a1 = json['a1'];
    a2 = json['a2'];
    a3 = json['a3'];
    a4 = json['a4'];
    c4 = json['c4'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'iddetilperiode': idPeriode,
      'tgu': tgu,
      'status': status,
      'als_from': alsFrom,
      'als_to': alsTo,
      'a1': a1,
      'a2': a2,
      'a3': a3,
      'a4': a4,
      'c4': c4,
    };
  }
}
