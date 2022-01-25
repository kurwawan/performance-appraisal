class UserApproveModel {
  String id;
  String idPeriode;
  String nik;
  String ats;
  String ajbAts;
  String bukan;
  String a1;
  String a2;
  String a3;
  String a4;
  String ctt;
  String c4;
  String tgu;
  String alsFrom;
  String alsTo;
  String status;
  String bawahan;
  String jbtBwh;
  String alv;
  String atasan;
  String jbtAts;
  String mingguN;
  String tglAwalMinggu;
  String tglAkhirMinggu;
  String nmPeriode;
  String a1Old;
  String a2Old;
  String a3Old;
  String a4Old;
  String cttOld;

  UserApproveModel({
    this.id,
    this.idPeriode,
    this.nik,
    this.ats,
    this.ajbAts,
    this.bukan,
    this.a1,
    this.a2,
    this.a3,
    this.a4,
    this.ctt,
    this.c4,
    this.tgu,
    this.alsFrom,
    this.alsTo,
    this.status,
    this.bawahan,
    this.jbtBwh,
    this.alv,
    this.atasan,
    this.jbtAts,
    this.mingguN,
    this.tglAwalMinggu,
    this.tglAkhirMinggu,
    this.nmPeriode,
    this.a1Old,
    this.a2Old,
    this.a3Old,
    this.a4Old,
    this.cttOld,
  });

  UserApproveModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idPeriode = json['iddetilperiode'];
    nik = json['nik'];
    ats = json['ats'];
    ajbAts = json['ajb_ats'];
    bukan = json['bukan'];
    a1 = json['a1'];
    a2 = json['a2'];
    a3 = json['a3'];
    a4 = json['a4'];
    ctt = json['ctt'];
    c4 = json['c4'];
    tgu = json['tgu'];
    alsFrom = json['als_from'];
    alsTo = json['als_to'];
    status = json['status'];
    bawahan = json['bawahan'];
    jbtBwh = json['jbt_bwh'];
    alv = json['alv'];
    atasan = json['atasan'];
    jbtAts = json['jbt_ats'];
    mingguN = json['minggu_n'];
    tglAwalMinggu = json['tglawalminggu'];
    tglAkhirMinggu = json['tglakhirminggu'];
    nmPeriode = json['nmperiode'];
    a1Old = json['a_1'];
    a2Old = json['a_2'];
    a3Old = json['a_3'];
    a4Old = json['a_4'];
    cttOld = json['ctt_old'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'iddetilperiode': idPeriode,
      'nik': nik,
      'ats': ats,
      'ajb_ats': ajbAts,
      'bukan': bukan,
      'a1': a1,
      'a2': a2,
      'a3': a3,
      'a4': a4,
      'ctt': ctt,
      'c4': c4,
      'tgu': tgu,
      'als_from': alsFrom,
      'als_to': alsTo,
      'status': status,
      'bawahan': bawahan,
      'jbt_bwh': jbtBwh,
      'alv': alv,
      'atasan': atasan,
      'jbt_ats': jbtAts,
      'minggu_n': mingguN,
      'tglawalminggu': tglAwalMinggu,
      'tglakhirminggu': tglAkhirMinggu,
      'nmperiode': nmPeriode,
      'a_1': a1Old,
      'a_2': a2Old,
      'a_3': a3Old,
      'a_4': a4Old,
      'ctt_old': cttOld,
    };
  }
}
