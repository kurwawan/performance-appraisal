import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penilaian/config.dart';
import 'package:penilaian/models/approves/confirmapprove_model.dart';
import 'package:penilaian/models/results/hasilkerja_model.dart';
import 'package:penilaian/models/results/hasilkerjac_model.dart';
import 'package:penilaian/pages/approves/confirm_success.dart';
import 'package:penilaian/pages/approves/user_approve.dart';
import 'package:penilaian/providers/approves/confirmapprove_provider.dart';
import 'package:penilaian/providers/approves/statusconfirm_provider.dart';
import 'package:penilaian/providers/results/hasilkerja_provider.dart';
import 'package:penilaian/providers/results/hasilkerjac_provider.dart';
import 'package:penilaian/providers/results/statushasilkerja_provider.dart';
import 'package:penilaian/providers/results/statushasilkerjac_provider.dart';
import 'package:penilaian/theme.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ConfirmPage extends StatefulWidget {
  // const ConfirmPage({ Key? key }) : super(key: key);
  final String tguById;
  final String tgu;
  final String id;
  final String atasan;
  final String jbAtasan;
  final String bawahan;
  final String jbBawahan;
  final String idPeriode;
  final String nik;
  final String alsFrom;
  final String a1;
  final String a2;
  final String a3;
  final String a4;
  final String c4;
  final String ctt;
  final String mingguN;
  final String tglAwal;
  final String tglAkhir;
  final String periode;
  final String a1Old;
  final String a2Old;
  final String a3Old;
  final String a4Old;
  final String cttOld;

  ConfirmPage({
    Key key,
    this.tguById,
    this.tgu,
    this.id,
    this.atasan,
    this.jbAtasan,
    this.bawahan,
    this.jbBawahan,
    this.idPeriode,
    this.nik,
    this.alsFrom,
    this.a1,
    this.a2,
    this.a3,
    this.a4,
    this.c4,
    this.ctt,
    this.mingguN,
    this.tglAwal,
    this.tglAkhir,
    this.periode,
    this.a1Old,
    this.a2Old,
    this.a3Old,
    this.a4Old,
    this.cttOld,
  }) : super(key: key);

  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  bool isTolak = false;
  bool isSave = false;
  bool isReject = false;
  bool isLoad = false;

  TextEditingController alsTolakController = new TextEditingController();

  var baseUrl = Config.url;

  String avlNilaiC4 = '';
  Future getHasilKerjaCById(String nik, String idPeriode) async {
    try {
      String url = "$baseUrl/penilaian/web/api/get/hasilkerjaplusbyid?nik=" +
          nik +
          "&idperiode=" +
          idPeriode;

      final response = await http.get(url);

      if (response.body.toString() == '[]') {
        print('nilai C4 kosong');
        avlNilaiC4 = '';
      } else {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          /* print(data);
          valC4Controller.text = data[0]['c_4']; */
          avlNilaiC4 = data[0]['c4'];
          print(avlNilaiC4);
        } else {
          return null;
        }
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isLoad = true;
    getHasilKerjaCById(widget.nik, widget.idPeriode).whenComplete(() {
      setState(() {
        isLoad = false;
      });
    }).catchError((e) {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ListUserApprove(
              tgu: widget.tgu,
            ),
          ),
        );
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 5,
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(),
                  SizedBox(
                    height: 10,
                  ),
                  namaAjuan(),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 20,
                    thickness: 8,
                  ),
                  isLoad
                      ? Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xff0D2137),
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            keteranganWaktu(),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              height: 20,
                              thickness: 8,
                            ),
                            alasanAjuan(),
                            Divider(
                              height: 20,
                              thickness: 8,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            nilaiLama(),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              height: 20,
                              thickness: 8,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            nilaiAjuan(),
                            SizedBox(
                              height: 15,
                            ),
                            confirmButton(),
                            Visibility(
                              visible: isTolak,
                              child: buttonTolak(),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Approve',
              style: titleTextStyle,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Konfirmasi Pengajuan',
              style: subTitleTextStyle,
            ),
          ],
        ),
        Spacer(),
        Icon(
          Icons.account_circle_rounded,
          size: 50,
        ),
      ],
    );
  }

  Widget namaAjuan() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Atasan',
                  style: hasilKerjaTextStyle,
                ),
                Text(
                  'Jabatan',
                  style: hasilKerjaTextStyle,
                ),
                Text(
                  'Bawahan',
                  style: hasilKerjaTextStyle,
                ),
                Text(
                  'Jabatan',
                  style: hasilKerjaTextStyle,
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ':',
                  style: hasilKerjaTextStyle,
                ),
                Text(
                  ':',
                  style: hasilKerjaTextStyle,
                ),
                Text(
                  ':',
                  style: hasilKerjaTextStyle,
                ),
                Text(
                  ':',
                  style: hasilKerjaTextStyle,
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.atasan,
                    overflow: TextOverflow.ellipsis,
                    style: subInfoNilaiTextStyle,
                  ),
                  Text(
                    widget.jbAtasan,
                    overflow: TextOverflow.ellipsis,
                    style: subInfoNilaiTextStyle,
                  ),
                  Text(
                    widget.bawahan,
                    overflow: TextOverflow.ellipsis,
                    style: subInfoNilaiTextStyle,
                  ),
                  Text(
                    widget.jbBawahan,
                    overflow: TextOverflow.ellipsis,
                    style: subInfoNilaiTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget keteranganWaktu() {
    return Column(
      children: [
        Center(
          child: Text(
            'Keterangan Waktu',
            style: hasilKerjaTextStyle,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tahun',
                  style: valHasilKerjaTextStyle,
                ),
                Text(
                  'Periode',
                  style: valHasilKerjaTextStyle,
                ),
                Text(
                  'Minggu Ke',
                  style: valHasilKerjaTextStyle,
                ),
                Text(
                  'Tgl. Awal Minggu',
                  style: valHasilKerjaTextStyle,
                ),
                Text(
                  'Tgl. Akhir Minggu',
                  style: valHasilKerjaTextStyle,
                ),
              ],
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ':',
                  style: valHasilKerjaTextStyle,
                ),
                Text(
                  ':',
                  style: valHasilKerjaTextStyle,
                ),
                Text(
                  ':',
                  style: valHasilKerjaTextStyle,
                ),
                Text(
                  ':',
                  style: valHasilKerjaTextStyle,
                ),
                Text(
                  ':',
                  style: valHasilKerjaTextStyle,
                ),
              ],
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.periode.substring(10, 14),
                  style: ketTitleNilaiTextStyle,
                ),
                Text(
                  widget.periode.substring(8, 10),
                  style: ketTitleNilaiTextStyle,
                ),
                Text(
                  widget.mingguN,
                  style: ketTitleNilaiTextStyle,
                ),
                Text(
                  widget.tglAwal,
                  style: ketTitleNilaiTextStyle,
                ),
                Text(
                  widget.tglAkhir,
                  style: ketTitleNilaiTextStyle,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget alasanAjuan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'Alasan Pengajuan',
            style: hasilKerjaTextStyle,
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: /* Colors.red[900] */ Color(0xffD6CFC7),
            borderRadius: BorderRadius.all(
              new Radius.circular(6.0),
            ),
          ),
          child: Text(
            widget.alsFrom,
            style: ketTitleNilaiTextStyle,
          ),
        ),
      ],
    );
  }

  Widget nilaiLama() {
    return Column(
      children: [
        Center(
          child: Text(
            'Nilai Hasil Kerja Sebelumnya',
            style: hasilKerjaTextStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: /* Colors.red[900] */ Color(0xffD6CFC7),
            borderRadius: BorderRadius.all(
              new Radius.circular(6.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'A1',
                              style: valHasilKerjaTextStyle,
                            ),
                            Text(
                              'A3',
                              style: valHasilKerjaTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Text(
                              ':',
                              style: valHasilKerjaTextStyle,
                            ),
                            Text(
                              ':',
                              style: valHasilKerjaTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Container(
                              child: Text(
                                widget.a1Old,
                                style: ketTitleNilaiOldTextStyle,
                              ),
                            ),
                            Text(
                              widget.a3Old,
                              style: ketTitleNilaiOldTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'A2',
                              style: valHasilKerjaTextStyle,
                            ),
                            Text(
                              'A4',
                              style: valHasilKerjaTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Text(
                              ':',
                              style: valHasilKerjaTextStyle,
                            ),
                            Text(
                              ':',
                              style: valHasilKerjaTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Container(
                              child: Text(
                                widget.a2Old,
                                style: ketTitleNilaiOldTextStyle,
                              ),
                            ),
                            Text(
                              widget.a4Old,
                              style: ketTitleNilaiOldTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.c4 == '' ? false : true,
                    child: Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'C4',
                                style: valHasilKerjaTextStyle,
                              ),
                              Text(
                                '',
                                style: valHasilKerjaTextStyle,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              Text(
                                ':',
                                style: valHasilKerjaTextStyle,
                              ),
                              Text(
                                '',
                                style: valHasilKerjaTextStyle,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              Container(
                                child: Text(
                                  avlNilaiC4.toString(),
                                  style: ketTitleNilaiOldTextStyle,
                                ),
                              ),
                              Text(
                                '',
                                style: ketTitleNilaiTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Keterangan :',
                style: valHasilKerjaTextStyle,
              ),
              Text(
                widget.cttOld == '' ? '-' : widget.cttOld,
                style: ketTitleNilaiOldTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget nilaiAjuan() {
    return Column(
      children: [
        Center(
          child: Text(
            'Pengajuan Nilai Hasil Kerja',
            style: hasilKerjaTextStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: /* Colors.red[900] */ Color(0xffD6CFC7),
            borderRadius: BorderRadius.all(
              new Radius.circular(6.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'A1',
                              style: valHasilKerjaTextStyle,
                            ),
                            Text(
                              'A3',
                              style: valHasilKerjaTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Text(
                              ':',
                              style: valHasilKerjaTextStyle,
                            ),
                            Text(
                              ':',
                              style: valHasilKerjaTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Container(
                              child: Text(
                                widget.a1,
                                style: ketTitleNilaiTextStyle,
                              ),
                            ),
                            Text(
                              widget.a3,
                              style: ketTitleNilaiTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'A2',
                              style: valHasilKerjaTextStyle,
                            ),
                            Text(
                              'A4',
                              style: valHasilKerjaTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Text(
                              ':',
                              style: valHasilKerjaTextStyle,
                            ),
                            Text(
                              ':',
                              style: valHasilKerjaTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Container(
                              child: Text(
                                widget.a2,
                                style: ketTitleNilaiTextStyle,
                              ),
                            ),
                            Text(
                              widget.a4,
                              style: ketTitleNilaiTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.c4 == '' ? false : true,
                    child: Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'C4',
                                style: valHasilKerjaTextStyle,
                              ),
                              Text(
                                '',
                                style: valHasilKerjaTextStyle,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              Text(
                                ':',
                                style: valHasilKerjaTextStyle,
                              ),
                              Text(
                                '',
                                style: valHasilKerjaTextStyle,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              Container(
                                child: Text(
                                  widget.c4,
                                  style: ketTitleNilaiTextStyle,
                                ),
                              ),
                              Text(
                                '',
                                style: ketTitleNilaiTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Keterangan :',
                style: valHasilKerjaTextStyle,
              ),
              Text(
                widget.ctt == '' ? '-' : widget.ctt,
                style: ketTitleNilaiTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget confirmButton() {
    var confirmApproveProvider = Provider.of<ConfirmApproveProvider>(context);
    var statusConfirmProvider = Provider.of<StatusConfirmProvider>(context);

    var hasilKerjaProvider = Provider.of<HasilKerjaProvider>(context);
    var statusHasilKerjaProvider =
        Provider.of<StatusHasilKerjaProvider>(context);

    var hasilKerjaCProvider = Provider.of<HasilKerjaCProvider>(context);
    var statusHasilKerjaCProvider =
        Provider.of<StatusHasilKerjaCProvider>(context);

    return Visibility(
      visible: isReject ? false : true,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              height: 50,
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor:
                      isTolak == false ? Colors.red[900] : Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: isSave
                    ? null
                    : () {
                        if (isTolak == false) {
                          setState(() {
                            isTolak = true;
                          });
                        } else {
                          setState(() {
                            isTolak = false;
                          });
                        }
                      },
                child: Text(
                  isTolak == false ? 'Tolak' : 'Cancel',
                  style: buttonTextStyle,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            flex: 1,
            child: Container(
              height: 50,
              width: double.infinity,
              child: isSave
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xff1F5F5B),
                        ),
                      ),
                    )
                  : TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            isTolak ? Color(0xfff4f2ed) : Color(0xff1F5F5B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: isTolak
                          ? null
                          : () async {
                              // print('not null');
                              setState(() {
                                isSave = true;
                              });

                              ConfirmApproveModel confirmApprove =
                                  await confirmApproveProvider.confirmToUser(
                                alsTolakController.text,
                                '1',
                                widget.id,
                                widget.idPeriode,
                                widget.nik,
                                widget.ctt,
                              );

                              HasilKerjaModel hasilKerja =
                                  await hasilKerjaProvider.updateHasilKerja(
                                widget.idPeriode,
                                widget.nik,
                                widget.a1,
                                widget.a2,
                                widget.a3,
                                widget.a4,
                                widget.ctt,
                                widget.tguById,
                              );

                              if (widget.c4 != '') {
                                HasilKerjaCModel updateHasilKerjaC =
                                    await hasilKerjaCProvider.updateHasilKerjaC(
                                  widget.idPeriode,
                                  widget.nik,
                                  widget.c4,
                                );

                                statusHasilKerjaCProvider.hasilkerjac =
                                    updateHasilKerjaC;
                              }

                              statusConfirmProvider.confirmapprove =
                                  confirmApprove;
                              statusHasilKerjaProvider.hasilkerja = hasilKerja;

                              setState(() {
                                isSave = false;
                              });
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ConfirmSuccessPage(),
                                ),
                              );
                            },
                      child: Text(
                        'Setuju',
                        style: GoogleFonts.poppins(
                          color: isTolak ? Color(0xffc9bfa6) : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonTolak() {
    var confirmApproveProvider = Provider.of<ConfirmApproveProvider>(context);
    var statusConfirmProvider = Provider.of<StatusConfirmProvider>(context);

    void showError(String message) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[900],
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Divider(
          height: 20,
          thickness: 8,
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alasan Tolak Pengajuan :',
              style: valHasilKerjaTextStyle,
            ),
          ],
        ),
        SizedBox(
          height: 2,
        ),
        TextFormField(
          controller: alsTolakController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
            fillColor: Color(0xffF1F0F5),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: Color(0xff4141A4),
              ),
            ),
            hintText: 'Isi alasan',
            hintStyle: TextStyle(
              fontSize: 14,
              color: Color(0xffB3B5C4),
            ),
          ),
          style: TextStyle(
            color: Color(0xff4141A4),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 50,
          width: double.infinity,
          child: isReject
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.red[900],
                    ),
                  ),
                )
              : TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (alsTolakController.text.isEmpty) {
                      showError('Alasan tolak ajuan wajib di isi');
                    } else {
                      setState(() {
                        isReject = true;
                      });

                      ConfirmApproveModel confirmApprove =
                          await confirmApproveProvider.confirmToUser(
                        alsTolakController.text,
                        '0',
                        widget.id,
                        widget.idPeriode,
                        widget.nik,
                        widget.ctt,
                      );

                      statusConfirmProvider.confirmapprove = confirmApprove;

                      setState(() {
                        isReject = false;
                      });

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ConfirmSuccessPage(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Tolak Pengajuan',
                    style: buttonTextStyle,
                  ),
                ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
