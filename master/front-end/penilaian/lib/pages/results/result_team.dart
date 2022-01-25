import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penilaian/config.dart';
import 'package:penilaian/models/results/hasilkerja_model.dart';
import 'package:penilaian/models/results/hasilkerjac_model.dart';
import 'package:penilaian/models/results/sikappost_model.dart';
import 'package:penilaian/pages/list_team.dart';
import 'package:penilaian/pages/results/result_success.dart';
import 'package:penilaian/providers/results/hasilkerja_provider.dart';
import 'package:penilaian/providers/results/hasilkerjac_provider.dart';
import 'package:penilaian/providers/results/sikappost_provider.dart';
import 'package:penilaian/providers/results/statushasilkerja_provider.dart';
import 'package:penilaian/providers/results/statushasilkerjac_provider.dart';
import 'package:penilaian/providers/results/statussikappost_provider.dart';
import 'package:penilaian/providers/user_provider.dart';
import 'package:penilaian/theme.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ResultTeamPage extends StatefulWidget {
  // const ResultTeamPage({ Key? key }) : super(key: key);
  final String nip;
  final String idPeriode;
  final String mingguN;
  final String nmp;
  final String jbtb;
  final String alv;
  final String nikb;
  final String kodePriode;
  final String categoryResult;

  ResultTeamPage({
    Key key,
    this.nip,
    this.idPeriode,
    this.mingguN,
    this.nmp,
    this.jbtb,
    this.alv,
    this.nikb,
    this.kodePriode,
    this.categoryResult,
  }) : super(key: key);

  @override
  _ResultTeamPageState createState() => _ResultTeamPageState();
}

class _ResultTeamPageState extends State<ResultTeamPage> {
  String radioButtonItem /*  = 'ONE' */;
  int id /*  = 1 */;
  bool isBukan = false;
  bool isVisibleBukan = true;
  bool isKeterangan = false;
  bool isVisibleKet = false;
  bool isVisibleC4 = false;
  String valPoint0,
      valPoint1,
      valPoint2,
      valPoint3,
      valPoint4,
      valPoint5,
      valPoint6,
      valPoint7;
  bool isPoint0 = false,
      isPoint1 = false,
      isPoint2 = false,
      isPoint3 = false,
      isPoint4 = false,
      isPoint5 = false,
      isPoint6 = false,
      isPoint7 = false;

  bool isLoadingValA1 = false,
      isLoadingValA2 = false,
      isLoadingValA3 = false,
      isLoadingValA4 = false,
      isLoadingValC4 = false;
  bool isLoadingP0 = false;

  bool isSave = false;
  bool isLoadingPointSikap = false;
  bool isInfoC4 = false;

  TextEditingController valA1Controller = new TextEditingController();
  TextEditingController valA2Controller = new TextEditingController();
  TextEditingController valA3Controller = new TextEditingController();
  TextEditingController valA4Controller = new TextEditingController();
  TextEditingController valKetHasilKerjaController =
      new TextEditingController();
  TextEditingController valC4Controller = new TextEditingController();

  TextEditingController valAlasanKerjaController = new TextEditingController();

  String tempC4 = '';

  TextEditingController valPoint0Controller = new TextEditingController();
  TextEditingController valPoint1Controller = new TextEditingController();
  TextEditingController valPoint2Controller = new TextEditingController();
  TextEditingController valPoint3Controller = new TextEditingController();
  TextEditingController valPoint4Controller = new TextEditingController();
  TextEditingController valPoint5Controller = new TextEditingController();
  TextEditingController valPoint6Controller = new TextEditingController();
  TextEditingController valPoint7Controller = new TextEditingController();

  var baseUrl = Config.url;

  String oldA1 = '';
  String oldA2 = '';
  String oldA3 = '';
  String oldA4 = '';
  String oldCtt = '';
  Future getHasilKerjaById(String nip, String idPeriode, String nik) async {
    try {
      String url = "$baseUrl/penilaian/web/api/get/hasilkerjabyid?nip=" +
          nip +
          "&idperiode=" +
          idPeriode +
          "&nik=" +
          nik;

      final response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data[0]['a_1'] == null) {
          valA1Controller.text = '';
          oldA1 = '';
          /* setState(() {
            isLoadingValA1 = false;
          }); */
        } else {
          valA1Controller.text = data[0]['a_1'];
          oldA1 = data[0]['a_1'];
        }

        if (data[0]['a_2'] == null) {
          valA2Controller.text = '';
          oldA2 = '';
          /* setState(() {
            isLoadingValA2 = false;
          }); */
        } else {
          valA2Controller.text = data[0]['a_2'];
          oldA2 = data[0]['a_2'];
        }

        if (data[0]['a_3'] == null) {
          valA3Controller.text = '';
          oldA3 = '';
          /* setState(() {
            isLoadingValA3 = false;
          }); */
        } else {
          valA3Controller.text = data[0]['a_3'];
          oldA3 = data[0]['a_3'];
        }

        if (data[0]['a_4'] == null) {
          valA4Controller.text = '';
          oldA4 = '';
          /* setState(() {
            isLoadingValA4 = false;
          }); */
        } else {
          valA4Controller.text = data[0]['a_4'];
          oldA4 = data[0]['a_4'];
        }

        if (data[0]['ctt'] == '') {
          valKetHasilKerjaController.text = '';
          oldCtt = '';
        } else {
          valKetHasilKerjaController.text = data[0]['ctt'];
          oldCtt = data[0]['ctt'];
          setState(() {
            isKeterangan = true;
            isVisibleKet = true;
          });
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  String avlNilaiC4 = '';
  String avlNilaiC_4 = '';
  String oldC4 = '';
  Future getHasilKerjaCById(String nik, String idPeriode) async {
    try {
      String url = "$baseUrl/penilaian/web/api/get/hasilkerjaplusbyid?nik=" +
          nik +
          "&idperiode=" +
          idPeriode;

      final response = await http.get(url);

      if (response.body.toString() == '[]') {
        print('nilai C4 kosong');
        avlNilaiC_4 = '';
        avlNilaiC4 = '';
        oldC4 = '';
      } else {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          print(data);
          valC4Controller.text = data[0]['c_4'];

          avlNilaiC_4 = data[0]['c_4'];
          avlNilaiC4 = data[0]['c4'];
          oldC4 = data[0]['c4'];
          // print(avlNilaiC_4 + ' and ' + avlNilaiC4);
        } else {
          return null;
        }
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  String resultKdp, resultKet;
  var dataSikap;
  Future getSikapByPoint(String idPeriode, String nik, String kdp) async {
    try {
      String url = "$baseUrl/penilaian/web/api/get/sikapbypoint?idperiode=" +
          idPeriode +
          "&nik=" +
          nik +
          "&kdp=" +
          kdp;

      final response = await http.get(url);

      // print(response.statusCode);
      // print(response.body.toString());

      if (response.body.toString() == '[]') {
        print('kosong');
        resultKdp = '';
        resultKet = '';
      } else {
        if (response.statusCode == 200) {
          dataSikap = jsonDecode(response.body);
          resultKdp = dataSikap[0]['kdp'];
          resultKet = dataSikap[0]['catat1'];
          print('HASIL : ' + resultKdp + '  +  ' + resultKet);
        } else {
          return null;
        }
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  String checkAlsFrom = '';
  Future getProsesPengajuanByUser(String nik, String idPeriode) async {
    try {
      String url =
          "$baseUrl/penilaian/web/api/get/checkprosespengajuan?idperiode=$idPeriode&nik=$nik";

      final response = await http.get(url);
      if (response.body.toString() == '[]') {
        print('nilai kosong');
        checkAlsFrom = '';
      } else {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          checkAlsFrom = data[0]['als_from'];
        } else {
          return null;
        }
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  String checkAlsTo = '';
  String checkStatus = '';
  Future getStatusById(String idPeriode, String nik) async {
    try {
      String url =
          "$baseUrl/penilaian/web/api/get/statusbyid?idperiode=$idPeriode&nik=$nik";

      final response = await http.get(url);
      if (response.body.toString() == '[]') {
        print('nilai getStatusById kosong');
        checkAlsTo = '';
        checkStatus = '';
      } else {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          checkAlsTo = data[0]['als_to'];
          checkStatus = data[0]['status'];
          print(checkAlsTo + ' > ' + checkStatus);
        } else {
          return null;
        }
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  String checkStatusSecond = '';
  Future getStatusSecondById(String idPeriode, String nik) async {
    try {
      String url =
          "$baseUrl/penilaian/web/api/get/statussecondbyid?idperiode=$idPeriode&nik=$nik";

      final response = await http.get(url);
      if (response.body.toString() == '[]') {
        print('nilai getStatusById kosong');
        checkStatusSecond = '';
      } else {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          checkStatusSecond = data[0]['status'];
          print('SECOND STATUS : ' + checkStatusSecond);
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

    if (widget.categoryResult != 'add') {
      /* isLoadingValA1 = true;
      isLoadingValA2 = true;
      isLoadingValA3 = true;
      isLoadingValA4 = true; */

      isLoadingValC4 = true;
      getProsesPengajuanByUser(widget.nikb, widget.idPeriode).whenComplete(() {
        getStatusById(widget.idPeriode, widget.nikb).whenComplete(() {
          getHasilKerjaById(widget.nip.toString(), widget.idPeriode.toString(),
                  widget.nikb.toString())
              .whenComplete(() {
            /* isLoadingValA1 = false;
        isLoadingValA2 = false;
        isLoadingValA3 = false;
        isLoadingValA4 = false; */
            getHasilKerjaCById(
                    widget.nikb.toString(), widget.idPeriode.toString())
                .whenComplete(() {
              getStatusSecondById(widget.idPeriode, widget.nikb)
                  .whenComplete(() {
                setState(() {
                  isLoadingValC4 = false;
                  tempC4 = valC4Controller.text;
                  // print('value c4: ' + tempC4);
                  print('Nilai A1 : ' + oldA1);
                  print('second status : ' + checkStatusSecond);
                });
              }).catchError((e) {
                print(e.toString());
              });
            }).catchError((e) {
              print(e.toString());
            });
          }).catchError((e) {
            print(e.toString());
          });
        }).catchError((e) {
          print(e.toString());
        });
      }).catchError((e) {
        print(e.toString());
      });

      /*isLoadingPointSikap = true;
      getSikapByPoint(widget.idPeriode, widget.nikb, 'PR00').whenComplete(() {
        if (resultKdp == null) {
          valPoint0Controller.text = '';
        } else {
          valPoint0Controller.text = resultKet.toString();
        }

        getSikapByPoint(widget.idPeriode, widget.nikb, 'PR01').whenComplete(() {
          if (resultKdp == null) {
            // print('view kosong');
            valPoint1Controller.text = '';
          } else {
            // print('view hasil : ' + resultKdp);
            valPoint1Controller.text = resultKet.toString();
          }
        });

        getSikapByPoint(widget.idPeriode, widget.nikb, 'PR02').whenComplete(() {
          if (resultKdp == null) {
            // print('view kosong');
            valPoint2Controller.text = '';
          } else {
            // print('view hasil : ' + resultKdp);
            valPoint2Controller.text = resultKet.toString();
          }
        });

        getSikapByPoint(widget.idPeriode, widget.nikb, 'PR03').whenComplete(() {
          if (resultKdp == null) {
            // print('view kosong');
            valPoint3Controller.text = '';
          } else {
            // print('view hasil : ' + resultKdp);
            valPoint3Controller.text = resultKet.toString();
          }
        });

        getSikapByPoint(widget.idPeriode, widget.nikb, 'PR04').whenComplete(() {
          if (resultKdp == null) {
            // print('view kosong');
            valPoint4Controller.text = '';
          } else {
            // print('view hasil : ' + resultKdp);
            valPoint4Controller.text = resultKet.toString();
          }
        });

        getSikapByPoint(widget.idPeriode, widget.nikb, 'PR05').whenComplete(() {
          if (resultKdp == null) {
            // print('view kosong');
            valPoint5Controller.text = '';
          } else {
            // print('view hasil : ' + resultKdp);
            valPoint5Controller.text = resultKet.toString();
          }
        });

        getSikapByPoint(widget.idPeriode, widget.nikb, 'PR06').whenComplete(() {
          if (resultKdp == null) {
            // print('view kosong');
            valPoint6Controller.text = '';
          } else {
            // print('view hasil : ' + resultKdp);
            valPoint6Controller.text = resultKet.toString();
          }
        });

        getSikapByPoint(widget.idPeriode, widget.nikb, 'PR07').whenComplete(() {
          if (resultKdp == null) {
            // print('view kosong');
            valPoint7Controller.text = '';
          } else {
            // print('view hasil : ' + resultKdp);
            valPoint7Controller.text = resultKet.toString();
          }
          setState(() {
            isLoadingPointSikap = false;
          });
        });
      }); */
    } else {
      getHasilKerjaCById(widget.nikb, widget.idPeriode);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (widget.categoryResult != 'add') {
      valPoint0Controller.dispose();
      valPoint1Controller.dispose();
      valPoint2Controller.dispose();
      valPoint3Controller.dispose();
      valPoint4Controller.dispose();
      valPoint5Controller.dispose();
      valPoint6Controller.dispose();
      valPoint7Controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      setState(() {
        String temp = widget.alv.toString();
        if (temp == "L09" || temp == "L10" || temp == "L11") {
          isVisibleC4 = false;
          print(isVisibleC4.toString());
        } else {
          isVisibleC4 = true;
          print(isVisibleC4.toString());
        }
      });
    });

    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ListTeamPage(
                nip: widget.nip.toString(),
                idPeriode: widget.idPeriode.toString(),
                mingguN: widget.mingguN.toString(),
                categoryTeam: widget.categoryResult,
              ),
            ),
          );

          return Future.value(false);
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 5,
              left: 16,
              right: 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nama :',
                        style: periodeTextStyle,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 250,
                        child: Text(
                          widget.nmp.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: namaPenilaianTextStyle,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jabatan :',
                        style: periodeTextStyle,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 220,
                        child: Text(
                          widget.jbtb.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: namaPenilaianTextStyle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  isLoadingValC4
                      ? Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xff4141A4),
                              ),
                            ),
                          ),
                        )
                      : checkAlsFrom != ''
                          ? Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: /* Colors.red[900] */ Color(
                                        0xffD6CFC7),
                                    borderRadius: BorderRadius.all(
                                      new Radius.circular(40.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Pengajuan perubahan sedang diproses',
                                    style: prosesApproveTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              child: Column(
                                children: [
                                  /* Container(
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xffFA9F42),
                                      borderRadius: BorderRadius.all(
                                        new Radius.circular(8.0),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Cek jika bukan termasuk team anda ?',
                                            style: cekTextStyle,
                                          ),
                                        ),
                                        Theme(
                                          child: Checkbox(
                                            value: isBukan,
                                            activeColor: Color(0xff4141A4),
                                            onChanged: (value) {
                                              setState(() {
                                                isBukan = value;
                                                if (isBukan == true) {
                                                  isVisibleBukan = false;
                                                } else {
                                                  isVisibleBukan = true;
                                                }
                                              });
                                            },
                                          ),
                                          data: ThemeData(
                                            unselectedWidgetColor:
                                                Colors.white, // Your color
                                          ),
                                        ),
                                      ],
                                    ),
                                  ), */
                                  Visibility(
                                    visible: isVisibleBukan,
                                    child: Column(
                                      children: [
                                        widget.categoryResult == 'add'
                                            ? Container()
                                            : Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 15,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Visibility(
                                                        visible: checkStatus !=
                                                                    '1' &&
                                                                checkStatus !=
                                                                    '0'
                                                            ? false
                                                            : true,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            bottom: 10,
                                                          ),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: checkStatus ==
                                                                      '0'
                                                                  ? Colors
                                                                      .red[900]
                                                                  : Color(
                                                                      0xff1F5F5B),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                new Radius
                                                                        .circular(
                                                                    40.0),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              checkStatus == '0'
                                                                  ? 'Pengajuan di tolak karena :\n' +
                                                                      checkAlsTo
                                                                  : 'Pengajuan sebelumnya telah diterima',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: Color(
                                                                    0xffFFFFFF),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Alasan Perubahan :',
                                                        style:
                                                            valHasilKerjaTextStyle,
                                                      ),
                                                      TextFormField(
                                                        controller:
                                                            valAlasanKerjaController,
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        maxLines: null,
                                                        decoration:
                                                            InputDecoration(
                                                          fillColor:
                                                              Color(0xffF1F0F5),
                                                          filled: true,
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0xff4141A4),
                                                            ),
                                                          ),
                                                          hintText:
                                                              'Isi alasan',
                                                          hintStyle: TextStyle(
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xffB3B5C4),
                                                          ),
                                                        ),
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff4141A4),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        hasilKerja(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        sikap(),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  buttonSave(),
                                ],
                              ),
                            ),
                  SizedBox(
                    height: 20,
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
    if (widget.categoryResult == 'add') {
      return Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Penilaian',
                style: titleTextStyle,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Hasil Kerja dan Sikap',
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
    } else {
      return Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Update',
                style: titleTextStyle,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Hasil Kerja dan Sikap',
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
  }

  Widget hasilKerja() {
    String alvParam = widget.alv.toString();
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '1.   Nilai Hasil Kerja',
          style: hasilKerjaTextStyle,
        ),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 4,
                  right: 4,
                ),
                child: Text(
                  'Penjelasan nilai klik button (i) sebelah kanan.',
                  style: ketTitleNilaiTextStyle,
                ),
              ),
            ),
            Ink(
              decoration: ShapeDecoration(
                color: Color(0xff4141A4),
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.info_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  print(alvParam);
                  if (alvParam == 'L09' ||
                      alvParam == 'L10' ||
                      alvParam == "L11") {
                    setState(() {
                      isInfoC4 = false;
                    });
                  } else {
                    setState(() {
                      isInfoC4 = true;
                    });
                  }
                  _onBottomSheet();
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'A1',
              style: valHasilKerjaTextStyle,
            ),
            SizedBox(
              width: 2.5,
            ),
            Text(
              ':',
              style: valHasilKerjaTextStyle,
            ),
            SizedBox(
              width: 2.5,
            ),
            Expanded(
              child: TextFormField(
                controller: valA1Controller,
                inputFormatters: [
                  WhitelistingTextInputFormatter(
                    RegExp(r"^\d+\d{0,6}"),
                  ),
                  LengthLimitingTextInputFormatter(3),
                  NumericalRangeFormatter(min: 0, max: 100),
                ],
                keyboardType: TextInputType.numberWithOptions(decimal: false),
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
                  hintText:
                      isLoadingValA1 == true ? 'Loading ...' : 'Isi nilai A1',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xffB3B5C4),
                  ),
                ),
                style: TextStyle(
                  color: Color(0xff4141A4),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'A2',
              style: valHasilKerjaTextStyle,
            ),
            SizedBox(
              width: 2.5,
            ),
            Text(
              ':',
              style: valHasilKerjaTextStyle,
            ),
            SizedBox(
              width: 2.5,
            ),
            Expanded(
              child: TextFormField(
                controller: valA2Controller,
                inputFormatters: [
                  WhitelistingTextInputFormatter(
                    RegExp(r"^\d+\d{0,6}"),
                  ),
                  LengthLimitingTextInputFormatter(3),
                  NumericalRangeFormatter(min: 0, max: 100),
                ],
                keyboardType: TextInputType.numberWithOptions(decimal: false),
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
                  hintText:
                      isLoadingValA1 == true ? 'Loading ...' : 'Isi nilai A2',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xffB3B5C4),
                  ),
                ),
                style: TextStyle(
                  color: Color(0xff4141A4),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'A3',
              style: valHasilKerjaTextStyle,
            ),
            SizedBox(
              width: 2.5,
            ),
            Text(
              ':',
              style: valHasilKerjaTextStyle,
            ),
            SizedBox(
              width: 2.5,
            ),
            Expanded(
              child: TextFormField(
                controller: valA3Controller,
                inputFormatters: [
                  WhitelistingTextInputFormatter(
                    RegExp(r"^\d+\d{0,6}"),
                  ),
                  LengthLimitingTextInputFormatter(3),
                  NumericalRangeFormatter(min: 0, max: 100),
                ],
                keyboardType: TextInputType.numberWithOptions(decimal: false),
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
                  hintText:
                      isLoadingValA1 == true ? 'Loading ...' : 'Isi nilai A3',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xffB3B5C4),
                  ),
                ),
                style: TextStyle(
                  color: Color(0xff4141A4),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'A4',
              style: valHasilKerjaTextStyle,
            ),
            SizedBox(
              width: 2.5,
            ),
            Text(
              ':',
              style: valHasilKerjaTextStyle,
            ),
            SizedBox(
              width: 2.5,
            ),
            Expanded(
              child: TextFormField(
                controller: valA4Controller,
                inputFormatters: [
                  WhitelistingTextInputFormatter(
                    RegExp(r"^\d+\d{0,6}"),
                  ),
                  LengthLimitingTextInputFormatter(3),
                  NumericalRangeFormatter(min: 0, max: 100),
                ],
                keyboardType: TextInputType.numberWithOptions(decimal: false),
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
                  hintText:
                      isLoadingValA1 == true ? 'Loading ...' : 'Isi nilai A4',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xffB3B5C4),
                  ),
                ),
                style: TextStyle(
                  color: Color(0xff4141A4),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Visibility(
          visible: isVisibleC4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'C4',
                style: valHasilKerjaTextStyle,
              ),
              SizedBox(
                width: 2.5,
              ),
              Text(
                ':',
                style: valHasilKerjaTextStyle,
              ),
              SizedBox(
                width: 2.5,
              ),
              Expanded(
                child: TextFormField(
                  controller: valC4Controller,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(
                      RegExp(r"^\d+\d{0,6}"),
                    ),
                    LengthLimitingTextInputFormatter(3),
                    NumericalRangeFormatter(min: 0, max: 100),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
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
                    hintText:
                        isLoadingValC4 == true ? 'Loading ...' : 'Isi nilai C4',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color(0xffB3B5C4),
                    ),
                  ),
                  style: TextStyle(
                    color: Color(0xff4141A4),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Text(
              'Isi keterangan ?',
              style: valHasilKerjaTextStyle,
            ),
            Checkbox(
              value: isKeterangan,
              activeColor: Color(0xff4141A4),
              onChanged: (value) {
                setState(() {
                  isKeterangan = value;
                  if (isKeterangan == false) {
                    isVisibleKet = false;
                  } else {
                    isVisibleKet = true;
                  }
                });
              },
            ),
          ],
        ),
        Visibility(
          visible: isVisibleKet,
          child: TextFormField(
            controller: valKetHasilKerjaController,
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
              hintText: 'Isi keterangan',
              hintStyle: TextStyle(
                fontSize: 14,
                color: Color(0xffB3B5C4),
              ),
            ),
            style: TextStyle(
              color: Color(0xff4141A4),
            ),
          ),
        ),
      ],
    );
  }

  Widget sikap() {
    if (widget.categoryResult == 'add') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 20,
            thickness: 8,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '2.   Nilai Sikap',
            style: hasilKerjaTextStyle,
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 4,
                    right: 4,
                  ),
                  child: Text(
                    'Penjelasan nilai klik button (i) sebelah kanan.',
                    style: ketTitleNilaiTextStyle,
                  ),
                ),
              ),
              Ink(
                decoration: ShapeDecoration(
                  color: Color(0xff4141A4),
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.info_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _onBottomSheetSecond();
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isPoint0,
                    activeColor: Color(0xff4141A4),
                    onChanged: (value) {
                      setState(() {
                        isPoint0 = value;

                        if (isPoint0 == false) {
                          valPoint0 = null;
                        } else {
                          valPoint0 = "PR00";
                        }
                        print(valPoint0);
                      });
                    },
                  ),
                  Text(
                    'Tidak melakukan pelanggaran',
                    style: valHasilKerjaTextStyle,
                  ),
                  /* SizedBox(
                    width: 10,
                  ),
                  Text(
                    ':',
                    style: valHasilKerjaTextStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Visibility(
                    visible: isPoint0,
                    child: Expanded(
                      child: TextFormField(
                        controller: valPoint0Controller,
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
                          hintText: 'Isi keterangan',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xffB3B5C4),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xff4141A4),
                        ),
                      ),
                    ),
                  ), */
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isPoint1,
                    activeColor: Color(0xff4141A4),
                    onChanged: (value) {
                      setState(() {
                        isPoint1 = value;
                        if (isPoint1 == false) {
                          valPoint1 = null;
                        } else {
                          valPoint1 = "PR01";
                        }

                        print(valPoint1);
                      });
                    },
                  ),
                  Text(
                    'Point  1',
                    style: valHasilKerjaTextStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    ':',
                    style: valHasilKerjaTextStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Visibility(
                    visible: isPoint1,
                    child: Expanded(
                      child: TextFormField(
                        controller: valPoint1Controller,
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
                          hintText: 'Isi keterangan',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xffB3B5C4),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xff4141A4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '*) Kesediaan menerima perintah',
                      style: ketNilaiTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isPoint2,
                    activeColor: Color(0xff4141A4),
                    onChanged: (value) {
                      setState(() {
                        isPoint2 = value;
                        if (isPoint2 == false) {
                          valPoint2 = null;
                        } else {
                          valPoint2 = "PR02";
                        }
                        print(valPoint2);
                      });
                    },
                  ),
                  Text(
                    'Point 2',
                    style: valHasilKerjaTextStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    ':',
                    style: valHasilKerjaTextStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Visibility(
                    visible: isPoint2,
                    child: Expanded(
                      child: TextFormField(
                        controller: valPoint2Controller,
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
                          hintText: 'Isi keterangan',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xffB3B5C4),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xff4141A4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '*) Pemahaman instruksi',
                      style: ketNilaiTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isPoint3,
                    activeColor: Color(0xff4141A4),
                    onChanged: (value) {
                      setState(() {
                        isPoint3 = value;
                        if (isPoint3 == false) {
                          valPoint3 = null;
                        } else {
                          valPoint3 = "PR03";
                        }
                        print(valPoint3);
                      });
                    },
                  ),
                  Text(
                    'Point 3',
                    style: valHasilKerjaTextStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    ':',
                    style: valHasilKerjaTextStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Visibility(
                    visible: isPoint3,
                    child: Expanded(
                      child: TextFormField(
                        controller: valPoint3Controller,
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
                          hintText: 'Isi keterangan',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xffB3B5C4),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xff4141A4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '*) Semangat kerja',
                      style: ketNilaiTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isPoint4,
                    activeColor: Color(0xff4141A4),
                    onChanged: (value) {
                      setState(() {
                        isPoint4 = value;
                        if (isPoint4 == false) {
                          valPoint4 = null;
                        } else {
                          valPoint4 = "PR04";
                        }
                        print(valPoint4);
                      });
                    },
                  ),
                  Text(
                    'Point 4',
                    style: valHasilKerjaTextStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    ':',
                    style: valHasilKerjaTextStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Visibility(
                    visible: isPoint4,
                    child: Expanded(
                      child: TextFormField(
                        controller: valPoint4Controller,
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
                          hintText: 'Isi keterangan',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xffB3B5C4),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xff4141A4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '*) Indisipliner',
                      style: ketNilaiTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isPoint5,
                    activeColor: Color(0xff4141A4),
                    onChanged: (value) {
                      setState(() {
                        isPoint5 = value;
                        if (isPoint5 == false) {
                          valPoint5 = null;
                        } else {
                          valPoint5 = "PR05";
                        }
                        print(valPoint5);
                      });
                    },
                  ),
                  Text(
                    'Point 5',
                    style: valHasilKerjaTextStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    ':',
                    style: valHasilKerjaTextStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Visibility(
                    visible: isPoint5,
                    child: Expanded(
                      child: TextFormField(
                        controller: valPoint5Controller,
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
                          hintText: 'Isi keterangan',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xffB3B5C4),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xff4141A4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '*) Komunikasi ke atasan',
                      style: ketNilaiTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isPoint6,
                    activeColor: Color(0xff4141A4),
                    onChanged: (value) {
                      setState(() {
                        isPoint6 = value;
                        if (isPoint6 == false) {
                          valPoint6 = null;
                        } else {
                          valPoint6 = "PR06";
                        }
                        print(valPoint6);
                      });
                    },
                  ),
                  Text(
                    'Point 6',
                    style: valHasilKerjaTextStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    ':',
                    style: valHasilKerjaTextStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Visibility(
                    visible: isPoint6,
                    child: Expanded(
                      child: TextFormField(
                        controller: valPoint6Controller,
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
                          hintText: 'Isi keterangan',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xffB3B5C4),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xff4141A4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '*) Masalah antar rekan kerja',
                      style: ketNilaiTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isPoint7,
                    activeColor: Color(0xff4141A4),
                    onChanged: (value) {
                      setState(() {
                        isPoint7 = value;
                        if (isPoint7 == false) {
                          valPoint7 = null;
                        } else {
                          valPoint7 = "PR07";
                        }
                        print(valPoint7);
                      });
                    },
                  ),
                  Text(
                    'Point 7',
                    style: valHasilKerjaTextStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    ':',
                    style: valHasilKerjaTextStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Visibility(
                    visible: isPoint7,
                    child: Expanded(
                      child: TextFormField(
                        controller: valPoint7Controller,
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
                          hintText: 'Isi keterangan',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xffB3B5C4),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xff4141A4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '*) Kesopanan',
                      style: ketNilaiTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Container();
    }
    /*else { 
      return isLoadingPointSikap == true
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xff4141A4),
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2.   Nilai Sikap',
                  style: hasilKerjaTextStyle,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 4,
                          right: 4,
                        ),
                        child: Text(
                          'Penjelasan nilai klik button (i) sebelah kanan.',
                          style: ketTitleNilaiTextStyle,
                        ),
                      ),
                    ),
                    Ink(
                      decoration: ShapeDecoration(
                        color: Color(0xff4141A4),
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.info_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _onBottomSheetSecond();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Point 0',
                      style: valHasilKerjaTextStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      ':',
                      style: valHasilKerjaTextStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: valPoint0Controller,
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
                          hintText: 'Isi keterangan',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xffB3B5C4),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xff4141A4),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Point 1',
                      style: valHasilKerjaTextStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      ':',
                      style: valHasilKerjaTextStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: valPoint1Controller,
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
                          hintText: 'Isi keterangan',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xffB3B5C4),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xff4141A4),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Point 2',
                      style: valHasilKerjaTextStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      ':',
                      style: valHasilKerjaTextStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: valPoint2Controller,
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
                          hintText: 'Isi keterangan',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xffB3B5C4),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xff4141A4),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Point 3',
                      style: valHasilKerjaTextStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      ':',
                      style: valHasilKerjaTextStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: valPoint3Controller,
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
                          hintText: 'Isi keterangan',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xffB3B5C4),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xff4141A4),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Point 4',
                      style: valHasilKerjaTextStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      ':',
                      style: valHasilKerjaTextStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: valPoint4Controller,
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
                          hintText: 'Isi keterangan',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xffB3B5C4),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xff4141A4),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Point 5',
                      style: valHasilKerjaTextStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      ':',
                      style: valHasilKerjaTextStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: valPoint5Controller,
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
                          hintText: 'Isi keterangan',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xffB3B5C4),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xff4141A4),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Point 6',
                      style: valHasilKerjaTextStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      ':',
                      style: valHasilKerjaTextStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: valPoint6Controller,
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
                          hintText: 'Isi keterangan',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xffB3B5C4),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xff4141A4),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Point 7',
                      style: valHasilKerjaTextStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      ':',
                      style: valHasilKerjaTextStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: valPoint7Controller,
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
                          hintText: 'Isi keterangan',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xffB3B5C4),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xff4141A4),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            );
    } */
  }

  Widget buttonSave() {
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

    var hasilKerjaProvider = Provider.of<HasilKerjaProvider>(context);
    var statusHasilKerjaProvider =
        Provider.of<StatusHasilKerjaProvider>(context);

    var hasilKerjaCProvider = Provider.of<HasilKerjaCProvider>(context);
    var statusHasilKerjaCProvider =
        Provider.of<StatusHasilKerjaCProvider>(context);

    var sikapPostProvider = Provider.of<SikapPostProvider>(context);
    var statusSikapPostProvider = Provider.of<StatusSikapPostProvider>(context);

    var userProvider = Provider.of<UserProvider>(context);

    String alvParam = widget.alv.toString();

    return Container(
      width: double.infinity,
      height: 50,
      child: isSave
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xff4141A4),
                ),
              ),
            )
          : TextButton(
              onPressed: () async {
                if (alvParam == 'L09' ||
                    alvParam == 'L10' ||
                    alvParam == 'L11') {
                  if (isBukan == true) {
                    SikapPostModel sikapPostModel;
                    if (widget.categoryResult != 'add') {
                    } else {
                      setState(() {
                        isSave = true;
                      });

                      sikapPostModel = await sikapPostProvider.updateBukan(
                        widget.idPeriode,
                        widget.nikb,
                      );

                      statusSikapPostProvider.sikappost = sikapPostModel;

                      setState(() {
                        isSave = false;
                      });

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ResultSuccessPage(
                            nip: widget.nip,
                            mingguN: widget.mingguN,
                            idPeriode: widget.idPeriode,
                            categorySuccess: widget.categoryResult,
                          ),
                        ),
                      );
                    }
                  } else if (valA1Controller.text.isEmpty ||
                      valA2Controller.text.isEmpty ||
                      valA3Controller.text.isEmpty ||
                      valA4Controller.text.isEmpty) {
                    showError('Nilai masih ada yang kosong');
                  } else if ((isPoint1 == true &&
                          valPoint1Controller.text.isEmpty) ||
                      (isPoint2 == true && valPoint2Controller.text == '') ||
                      (isPoint3 == true && valPoint3Controller.text == '') ||
                      (isPoint4 == true && valPoint4Controller.text == '') ||
                      (isPoint5 == true && valPoint5Controller.text == '') ||
                      (isPoint6 == true && valPoint6Controller.text == '') ||
                      (isPoint7 == true && valPoint7Controller.text == '')) {
                    showError('Nilai masih ada yang kosong');
                  } else {
                    setState(() {
                      isSave = true;
                    });

                    SikapPostModel sikapPostModel;
                    if (widget.categoryResult != 'add') {
                      // tidak di pakai dari sini
                      if (valPoint0Controller.text.isNotEmpty) {
                        if (valPoint1Controller.text.isNotEmpty ||
                            valPoint2Controller.text.isNotEmpty ||
                            valPoint3Controller.text.isNotEmpty ||
                            valPoint4Controller.text.isNotEmpty ||
                            valPoint5Controller.text.isNotEmpty ||
                            valPoint6Controller.text.isNotEmpty ||
                            valPoint7Controller.text.isNotEmpty) {
                          setState(() {
                            isSave = false;
                          });
                          showError('Penilaian nilai sikap salah !');
                        } else if (valPoint1Controller.text.isEmpty ||
                            valPoint2Controller.text.isEmpty ||
                            valPoint3Controller.text.isEmpty ||
                            valPoint4Controller.text.isEmpty ||
                            valPoint5Controller.text.isEmpty ||
                            valPoint6Controller.text.isEmpty ||
                            valPoint7Controller.text.isEmpty) {
                          HasilKerjaModel hasilKerja =
                              await hasilKerjaProvider.updateHasilKerja(
                            widget.idPeriode,
                            widget.nikb,
                            valA1Controller.text,
                            valA2Controller.text,
                            valA3Controller.text,
                            valA4Controller.text,
                            valKetHasilKerjaController.text,
                            '',
                          );

                          sikapPostModel = await sikapPostProvider.deleteSikap(
                            widget.idPeriode,
                            widget.nikb,
                          );

                          sikapPostModel = await sikapPostProvider.insertSikap(
                            widget.idPeriode,
                            widget.nikb,
                            'PR00',
                            valPoint0Controller.text,
                          );

                          setState(() {
                            isSave = false;
                          });

                          statusHasilKerjaProvider.hasilkerja = hasilKerja;
                          statusSikapPostProvider.sikappost = sikapPostModel;

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ResultSuccessPage(
                                nip: widget.nip,
                                mingguN: widget.mingguN,
                                idPeriode: widget.idPeriode,
                                categorySuccess: widget.categoryResult,
                              ),
                            ),
                          );
                        }
                      }
                      // tidak di pakai sampai sini
                      else {
                        if (valAlasanKerjaController.text.isEmpty) {
                          setState(() {
                            isSave = false;
                          });
                          showError('Alasan pengajuan belum di isi');
                        } else {
                          HasilKerjaModel hasilKerjaTemp =
                              await hasilKerjaProvider.insertTempHasilKerja(
                            widget.idPeriode,
                            widget.nikb,
                            userProvider.user.nip.toString(),
                            userProvider.user.ajb.toString(),
                            valA1Controller.text,
                            valA2Controller.text,
                            valA3Controller.text,
                            valA4Controller.text,
                            valKetHasilKerjaController.text,
                            valC4Controller.text,
                            valAlasanKerjaController.text,
                          );

                          HasilKerjaModel hasilNilaiSebelumTemp;
                          if (checkStatusSecond != '2') {
                            hasilNilaiSebelumTemp = await hasilKerjaProvider
                                .insertTempSecondHasilKerja(
                              widget.idPeriode,
                              widget.nikb,
                              userProvider.user.nip.toString(),
                              userProvider.user.ajb.toString(),
                              oldA1,
                              oldA2,
                              oldA3,
                              oldA4,
                              oldC4,
                            );
                          }

                          /* HasilKerjaModel hasilKerja =
                            await hasilKerjaProvider.updateHasilKerja(
                          widget.idPeriode,
                          widget.nikb,
                          valA1Controller.text,
                          valA2Controller.text,
                          valA3Controller.text,
                          valA4Controller.text,
                          valKetHasilKerjaController.text,
                        ); */

                          /* sikapPostModel = await sikapPostProvider.deleteSikap(
                          widget.idPeriode,
                          widget.nikb,
                        );

                        if (valPoint1Controller.text.isNotEmpty ||
                            valPoint2Controller.text.isNotEmpty ||
                            valPoint3Controller.text.isNotEmpty ||
                            valPoint4Controller.text.isNotEmpty ||
                            valPoint5Controller.text.isNotEmpty ||
                            valPoint6Controller.text.isNotEmpty ||
                            valPoint7Controller.text.isNotEmpty) {
                          if (valPoint1Controller.text.isNotEmpty) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              'PR01',
                              valPoint1Controller.text,
                            );
                          }

                          if (valPoint2Controller.text.isNotEmpty) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              'PR02',
                              valPoint2Controller.text,
                            );
                          }

                          if (valPoint3Controller.text.isNotEmpty) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              'PR03',
                              valPoint3Controller.text,
                            );
                          }

                          if (valPoint4Controller.text.isNotEmpty) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              'PR04',
                              valPoint4Controller.text,
                            );
                          }

                          if (valPoint5Controller.text.isNotEmpty) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              'PR05',
                              valPoint5Controller.text,
                            );
                          }

                          if (valPoint6Controller.text.isNotEmpty) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              'PR06',
                              valPoint6Controller.text,
                            );
                          }

                          if (valPoint7Controller.text.isNotEmpty) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              'PR07',
                              valPoint7Controller.text,
                            );
                          }
                        } else {
                          sikapPostModel = await sikapPostProvider.deleteSikap(
                            widget.idPeriode,
                            widget.nikb,
                          );

                          sikapPostModel = await sikapPostProvider.insertSikap(
                            widget.idPeriode,
                            widget.nikb,
                            'PR00',
                            valPoint0Controller.text,
                          );
                        } */

                          setState(() {
                            isSave = false;
                          });

                          print(hasilKerja.toString());

                          statusHasilKerjaProvider.hasilkerja = hasilKerjaTemp;
                          if (checkStatusSecond != '2') {
                            statusHasilKerjaProvider.hasilkerja =
                                hasilNilaiSebelumTemp;
                          }
                          // statusHasilKerjaProvider.hasilkerja = hasilKerja;
                          // statusSikapPostProvider.sikappost = sikapPostModel;

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ResultSuccessPage(
                                nip: widget.nip,
                                mingguN: widget.mingguN,
                                idPeriode: widget.idPeriode,
                                categorySuccess: widget.categoryResult,
                              ),
                            ),
                          );
                        }
                      }
                    } else {
                      if (valPoint0 != null) {
                        if (valPoint1 != null ||
                            valPoint2 != null ||
                            valPoint3 != null ||
                            valPoint4 != null ||
                            valPoint5 != null ||
                            valPoint6 != null ||
                            valPoint7 != null) {
                          // point 0 & point 1-7
                          setState(() {
                            isSave = false;
                          });

                          showError('Penilaian nilai sikap salah !');
                        } else if (valPoint1 == null ||
                            valPoint2 == null ||
                            valPoint3 == null ||
                            valPoint4 == null ||
                            valPoint5 == null ||
                            valPoint6 == null ||
                            valPoint7 == null) {
                          // point 0
                          HasilKerjaModel hasilKerja =
                              await hasilKerjaProvider.updateHasilKerja(
                            widget.idPeriode,
                            widget.nikb,
                            valA1Controller.text,
                            valA2Controller.text,
                            valA3Controller.text,
                            valA4Controller.text,
                            valKetHasilKerjaController.text,
                            '',
                          );

                          sikapPostModel = await sikapPostProvider.insertSikap(
                            widget.idPeriode,
                            widget.nikb,
                            valPoint0,
                            valPoint0Controller.text,
                          );

                          setState(() {
                            isSave = false;
                          });

                          statusHasilKerjaProvider.hasilkerja = hasilKerja;
                          statusSikapPostProvider.sikappost = sikapPostModel;

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ResultSuccessPage(
                                nip: widget.nip,
                                mingguN: widget.mingguN,
                                idPeriode: widget.idPeriode,
                                categorySuccess: widget.categoryResult,
                              ),
                            ),
                          );
                        }
                      } else if (valPoint0 == null) {
                        if (valPoint1 != null ||
                            valPoint2 != null ||
                            valPoint3 != null ||
                            valPoint4 != null ||
                            valPoint5 != null ||
                            valPoint6 != null ||
                            valPoint7 != null) {
                          // point 1-7
                          HasilKerjaModel hasilKerja =
                              await hasilKerjaProvider.updateHasilKerja(
                            widget.idPeriode,
                            widget.nikb,
                            valA1Controller.text,
                            valA2Controller.text,
                            valA3Controller.text,
                            valA4Controller.text,
                            valKetHasilKerjaController.text,
                            '',
                          );

                          if (valPoint1 != null) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              valPoint1,
                              valPoint1Controller.text,
                            );
                            print(valPoint1);
                          }
                          if (valPoint2 != null) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              valPoint2,
                              valPoint2Controller.text,
                            );
                            print(valPoint2);
                          }
                          if (valPoint3 != null) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              valPoint3,
                              valPoint3Controller.text,
                            );
                            print(valPoint3);
                          }
                          if (valPoint4 != null) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              valPoint4,
                              valPoint4Controller.text,
                            );
                            print(valPoint4);
                          }
                          if (valPoint5 != null) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              valPoint5,
                              valPoint5Controller.text,
                            );
                            print(valPoint5);
                          }
                          if (valPoint6 != null) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              valPoint6,
                              valPoint6Controller.text,
                            );
                            print(valPoint6);
                          }
                          if (valPoint7 != null) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              valPoint7,
                              valPoint7Controller.text,
                            );
                            print(valPoint7);
                          }

                          setState(() {
                            isSave = false;
                          });

                          statusHasilKerjaProvider.hasilkerja = hasilKerja;
                          statusSikapPostProvider.sikappost = sikapPostModel;

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ResultSuccessPage(
                                nip: widget.nip,
                                mingguN: widget.mingguN,
                                idPeriode: widget.idPeriode,
                                categorySuccess: widget.categoryResult,
                              ),
                            ),
                          );
                        } else {
                          // null check box
                          setState(() {
                            isSave = false;
                          });

                          showError('Nilai Sikap masih kosong');
                        }
                      }
                    }
                  }
                } else {
                  if (isBukan == true) {
                    SikapPostModel sikapPostModel;
                    if (widget.categoryResult != 'add') {
                      // TODO: planning => hapus data nilai kerja dan sikap dulu semua, baru update kolom bukan jadi true(1)
                    } else {
                      setState(() {
                        isSave = true;
                      });

                      sikapPostModel = await sikapPostProvider.updateBukan(
                        widget.idPeriode,
                        widget.nikb,
                      );

                      statusSikapPostProvider.sikappost = sikapPostModel;

                      setState(() {
                        isSave = false;
                      });

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ResultSuccessPage(
                            nip: widget.nip,
                            mingguN: widget.mingguN,
                            idPeriode: widget.idPeriode,
                            categorySuccess: widget.categoryResult,
                          ),
                        ),
                      );
                    }
                  } else if (valC4Controller.text.isEmpty ||
                      valA1Controller.text.isEmpty ||
                      valA2Controller.text.isEmpty ||
                      valA3Controller.text.isEmpty ||
                      valA4Controller.text.isEmpty) {
                    showError('Nilai masih ada yang kosong');
                  } else if ((isPoint1 == true &&
                          valPoint1Controller.text.isEmpty) ||
                      (isPoint2 == true && valPoint2Controller.text == '') ||
                      (isPoint3 == true && valPoint3Controller.text == '') ||
                      (isPoint4 == true && valPoint4Controller.text == '') ||
                      (isPoint5 == true && valPoint5Controller.text == '') ||
                      (isPoint6 == true && valPoint6Controller.text == '') ||
                      (isPoint7 == true && valPoint7Controller.text == '')) {
                    showError('Nilai masih ada yang kosong');
                  } else {
                    setState(() {
                      isSave = true;
                    });

                    SikapPostModel sikapPostModel;
                    if (widget.categoryResult != 'add') {
                      // TODO: tidak terpakai dari sini
                      if (valPoint0Controller.text.isNotEmpty) {
                        if (valPoint1Controller.text.isNotEmpty ||
                            valPoint2Controller.text.isNotEmpty ||
                            valPoint3Controller.text.isNotEmpty ||
                            valPoint4Controller.text.isNotEmpty ||
                            valPoint5Controller.text.isNotEmpty ||
                            valPoint6Controller.text.isNotEmpty ||
                            valPoint7Controller.text.isNotEmpty) {
                          setState(() {
                            isSave = false;
                          });
                          showError('Penilaian nilai sikap salah !');
                        } else if (valPoint1Controller.text.isEmpty ||
                            valPoint2Controller.text.isEmpty ||
                            valPoint3Controller.text.isEmpty ||
                            valPoint4Controller.text.isEmpty ||
                            valPoint5Controller.text.isEmpty ||
                            valPoint6Controller.text.isEmpty ||
                            valPoint7Controller.text.isEmpty) {
                          HasilKerjaModel hasilKerja =
                              await hasilKerjaProvider.updateHasilKerja(
                            widget.idPeriode,
                            widget.nikb,
                            valA1Controller.text,
                            valA2Controller.text,
                            valA3Controller.text,
                            valA4Controller.text,
                            valKetHasilKerjaController.text,
                            '',
                          );

                          HasilKerjaCModel insertHasilKerjaC;
                          HasilKerjaCModel updateHasilKerjaC;
                          if (tempC4 == '') {
                            insertHasilKerjaC =
                                await hasilKerjaCProvider.insertHasilKerjaC(
                              widget.kodePriode,
                              widget.nikb,
                              widget.idPeriode,
                              valC4Controller.text,
                            );
                          } else {
                            updateHasilKerjaC =
                                await hasilKerjaCProvider.updateHasilKerjaC(
                              widget.idPeriode,
                              widget.nikb,
                              valC4Controller.text,
                            );
                          }

                          sikapPostModel = await sikapPostProvider.deleteSikap(
                            widget.idPeriode,
                            widget.nikb,
                          );

                          sikapPostModel = await sikapPostProvider.insertSikap(
                            widget.idPeriode,
                            widget.nikb,
                            'PR00',
                            valPoint0Controller.text,
                          );

                          setState(() {
                            isSave = false;
                          });

                          setState(() {
                            isSave = false;
                          });

                          print(hasilKerja.toString());

                          statusHasilKerjaProvider.hasilkerja = hasilKerja;
                          statusHasilKerjaCProvider.hasilkerjac =
                              insertHasilKerjaC;
                          statusHasilKerjaCProvider.hasilkerjac =
                              updateHasilKerjaC;
                          statusSikapPostProvider.sikappost = sikapPostModel;

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ResultSuccessPage(
                                nip: widget.nip,
                                mingguN: widget.mingguN,
                                idPeriode: widget.idPeriode,
                                categorySuccess: widget.categoryResult,
                              ),
                            ),
                          );
                        }
                      } // TODO: tidak terpakai sampai sini
                      else {
                        /* HasilKerjaModel hasilKerja =
                            await hasilKerjaProvider.updateHasilKerja(
                          widget.idPeriode,
                          widget.nikb,
                          valA1Controller.text,
                          valA2Controller.text,
                          valA3Controller.text,
                          valA4Controller.text,
                          valKetHasilKerjaController.text,
                          '',
                        );

                        HasilKerjaCModel insertHasilKerjaC;
                        HasilKerjaCModel updateHasilKerjaC;
                        if (tempC4 == '') {
                          insertHasilKerjaC =
                              await hasilKerjaCProvider.insertHasilKerjaC(
                            widget.kodePriode,
                            widget.nikb,
                            widget.idPeriode,
                            valC4Controller.text,
                          );
                        } else {
                          updateHasilKerjaC =
                              await hasilKerjaCProvider.updateHasilKerjaC(
                            widget.idPeriode,
                            widget.nikb,
                            valC4Controller.text,
                          );
                        } */

                        /* sikapPostModel = await sikapPostProvider.deleteSikap(
                          widget.idPeriode,
                          widget.nikb,
                        );

                        //  TODO : update 291221
                        if (valPoint1Controller.text.isNotEmpty ||
                            valPoint2Controller.text.isNotEmpty ||
                            valPoint3Controller.text.isNotEmpty ||
                            valPoint4Controller.text.isNotEmpty ||
                            valPoint5Controller.text.isNotEmpty ||
                            valPoint6Controller.text.isNotEmpty ||
                            valPoint7Controller.text.isNotEmpty) {
                          if (valPoint1Controller.text.isNotEmpty) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              'PR01',
                              valPoint1Controller.text,
                            );
                          }

                          if (valPoint2Controller.text.isNotEmpty) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              'PR02',
                              valPoint2Controller.text,
                            );
                          }

                          if (valPoint3Controller.text.isNotEmpty) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              'PR03',
                              valPoint3Controller.text,
                            );
                          }

                          if (valPoint4Controller.text.isNotEmpty) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              'PR04',
                              valPoint4Controller.text,
                            );
                          }

                          if (valPoint5Controller.text.isNotEmpty) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              'PR05',
                              valPoint5Controller.text,
                            );
                          }

                          if (valPoint6Controller.text.isNotEmpty) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              'PR06',
                              valPoint6Controller.text,
                            );
                          }

                          if (valPoint7Controller.text.isNotEmpty) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              'PR07',
                              valPoint7Controller.text,
                            );
                          }
                        } else {
                          sikapPostModel = await sikapPostProvider.insertSikap(
                            widget.idPeriode,
                            widget.nikb,
                            'PR00',
                            valPoint0Controller.text,
                          );
                        } */

                        /* setState(() {
                          isSave = false;
                        });

                        statusHasilKerjaProvider.hasilkerja = hasilKerja;
                        statusHasilKerjaCProvider.hasilkerjac =
                            insertHasilKerjaC;
                        statusHasilKerjaCProvider.hasilkerjac =
                            updateHasilKerjaC; */

                        // statusSikapPostProvider.sikappost = sikapPostModel;

                        if (valAlasanKerjaController.text.isEmpty) {
                          setState(() {
                            isSave = false;
                          });
                          showError('Alasan pengajuan belum di isi');
                        } else {
                          HasilKerjaModel hasilKerjaTemp =
                              await hasilKerjaProvider.insertTempHasilKerja(
                            widget.idPeriode,
                            widget.nikb,
                            userProvider.user.nip.toString(),
                            userProvider.user.ajb.toString(),
                            valA1Controller.text,
                            valA2Controller.text,
                            valA3Controller.text,
                            valA4Controller.text,
                            valKetHasilKerjaController.text,
                            valC4Controller.text,
                            valAlasanKerjaController.text,
                          );

                          HasilKerjaModel hasilNilaiSebelumTemp;
                          if (checkStatusSecond != '2') {
                            hasilNilaiSebelumTemp = await hasilKerjaProvider
                                .insertTempSecondHasilKerja(
                              widget.idPeriode,
                              widget.nikb,
                              userProvider.user.nip.toString(),
                              userProvider.user.ajb.toString(),
                              oldA1,
                              oldA2,
                              oldA3,
                              oldA4,
                              oldC4,
                            );
                          }

                          setState(() {
                            isSave = false;
                          });

                          print(hasilKerja.toString());

                          statusHasilKerjaProvider.hasilkerja = hasilKerjaTemp;
                          if (checkStatusSecond != '2') {
                            statusHasilKerjaProvider.hasilkerja =
                                hasilNilaiSebelumTemp;
                          }

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ResultSuccessPage(
                                nip: widget.nip,
                                mingguN: widget.mingguN,
                                idPeriode: widget.idPeriode,
                                categorySuccess: widget.categoryResult,
                              ),
                            ),
                          );
                        }
                      }
                    } else {
                      if (valPoint0 != null) {
                        if (valPoint1 != null ||
                            valPoint2 != null ||
                            valPoint3 != null ||
                            valPoint4 != null ||
                            valPoint5 != null ||
                            valPoint6 != null ||
                            valPoint7 != null) {
                          // point 0 & point 1-7
                          setState(() {
                            isSave = false;
                          });

                          showError('Penilaian nilai sikap salah !');
                        } else if (valPoint1 == null ||
                            valPoint2 == null ||
                            valPoint3 == null ||
                            valPoint4 == null ||
                            valPoint5 == null ||
                            valPoint6 == null ||
                            valPoint7 == null) {
                          // point 0
                          HasilKerjaModel hasilKerja =
                              await hasilKerjaProvider.updateHasilKerja(
                            widget.idPeriode,
                            widget.nikb,
                            valA1Controller.text,
                            valA2Controller.text,
                            valA3Controller.text,
                            valA4Controller.text,
                            valKetHasilKerjaController.text,
                            '',
                          );

                          HasilKerjaCModel insertHasilKerjaC;
                          HasilKerjaCModel updateHasilKerjaC;

                          if (avlNilaiC_4 != '' || avlNilaiC4 != '') {
                            updateHasilKerjaC =
                                await hasilKerjaCProvider.updateHasilKerjaC(
                              widget.idPeriode,
                              widget.nikb,
                              valC4Controller.text,
                            );
                          } else {
                            insertHasilKerjaC =
                                await hasilKerjaCProvider.insertHasilKerjaC(
                              widget.kodePriode,
                              widget.nikb,
                              widget.idPeriode,
                              valC4Controller.text,
                            );
                          }

                          sikapPostModel = await sikapPostProvider.insertSikap(
                            widget.idPeriode,
                            widget.nikb,
                            valPoint0,
                            valPoint0Controller.text,
                          );

                          setState(() {
                            isSave = false;
                          });

                          statusHasilKerjaProvider.hasilkerja = hasilKerja;
                          statusHasilKerjaCProvider.hasilkerjac =
                              insertHasilKerjaC;
                          statusHasilKerjaCProvider.hasilkerjac =
                              updateHasilKerjaC;
                          statusSikapPostProvider.sikappost = sikapPostModel;

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ResultSuccessPage(
                                nip: widget.nip,
                                mingguN: widget.mingguN,
                                idPeriode: widget.idPeriode,
                                categorySuccess: widget.categoryResult,
                              ),
                            ),
                          );
                        }
                      } else if (valPoint0 == null) {
                        if (valPoint1 != null ||
                            valPoint2 != null ||
                            valPoint3 != null ||
                            valPoint4 != null ||
                            valPoint5 != null ||
                            valPoint6 != null ||
                            valPoint7 != null) {
                          // point 1-7
                          HasilKerjaModel hasilKerja =
                              await hasilKerjaProvider.updateHasilKerja(
                            widget.idPeriode,
                            widget.nikb,
                            valA1Controller.text,
                            valA2Controller.text,
                            valA3Controller.text,
                            valA4Controller.text,
                            valKetHasilKerjaController.text,
                            '',
                          );

                          HasilKerjaCModel insertHasilKerjaC;
                          HasilKerjaCModel updateHasilKerjaC;
                          if (tempC4 == '') {
                            insertHasilKerjaC =
                                await hasilKerjaCProvider.insertHasilKerjaC(
                              widget.kodePriode,
                              widget.nikb,
                              widget.idPeriode,
                              valC4Controller.text,
                            );
                          } else {
                            updateHasilKerjaC =
                                await hasilKerjaCProvider.updateHasilKerjaC(
                              widget.idPeriode,
                              widget.nikb,
                              valC4Controller.text,
                            );
                          }

                          if (valPoint1 != null) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              valPoint1,
                              valPoint1Controller.text,
                            );
                            print(valPoint1);
                          }
                          if (valPoint2 != null) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              valPoint2,
                              valPoint2Controller.text,
                            );
                            print(valPoint2);
                          }
                          if (valPoint3 != null) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              valPoint3,
                              valPoint3Controller.text,
                            );
                            print(valPoint3);
                          }
                          if (valPoint4 != null) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              valPoint4,
                              valPoint4Controller.text,
                            );
                            print(valPoint4);
                          }
                          if (valPoint5 != null) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              valPoint5,
                              valPoint5Controller.text,
                            );
                            print(valPoint5);
                          }
                          if (valPoint6 != null) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              valPoint6,
                              valPoint6Controller.text,
                            );
                            print(valPoint6);
                          }
                          if (valPoint7 != null) {
                            sikapPostModel =
                                await sikapPostProvider.insertSikap(
                              widget.idPeriode,
                              widget.nikb,
                              valPoint7,
                              valPoint7Controller.text,
                            );
                            print(valPoint7);
                          }

                          setState(() {
                            isSave = false;
                          });

                          statusHasilKerjaProvider.hasilkerja = hasilKerja;
                          statusHasilKerjaCProvider.hasilkerjac =
                              insertHasilKerjaC;
                          statusHasilKerjaCProvider.hasilkerjac =
                              updateHasilKerjaC;
                          statusSikapPostProvider.sikappost = sikapPostModel;

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ResultSuccessPage(
                                nip: widget.nip,
                                mingguN: widget.mingguN,
                                idPeriode: widget.idPeriode,
                                categorySuccess: widget.categoryResult,
                              ),
                            ),
                          );
                        } else {
                          // null check box
                          setState(() {
                            isSave = false;
                          });

                          showError('Nilai Sikap masih kosong');
                        }
                      }
                    }
                  }
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff4141A4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: widget.categoryResult != 'add'
                  ? Text(
                      'Kirim  Pengajuan',
                      style: buttonTextStyle,
                    )
                  : Text(
                      'Simpan',
                      style: buttonTextStyle,
                    ),
            ),
    );
  }

  void _onBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xff737373),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 10,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Informasi Kategori Hasil Kerja',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '⦿',
                          style: subInfoNilaiTextStyle,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'A1',
                          style: subInfoNilaiTextStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Kuantitas',
                        style: infoNilaiTextStyle,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '⦿',
                          style: subInfoNilaiTextStyle,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'A2',
                          style: subInfoNilaiTextStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Kualitas',
                        style: infoNilaiTextStyle,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '⦿',
                          style: subInfoNilaiTextStyle,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'A3',
                          style: subInfoNilaiTextStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Waktu',
                        style: infoNilaiTextStyle,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '⦿',
                          style: subInfoNilaiTextStyle,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'A4',
                          style: subInfoNilaiTextStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Efesiensi',
                        style: infoNilaiTextStyle,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: isInfoC4,
                      child: Row(
                        children: [
                          Text(
                            '⦿',
                            style: subInfoNilaiTextStyle,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'C4',
                            style: subInfoNilaiTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isInfoC4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Admnistrasi',
                          style: infoNilaiTextStyle,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xff4141A4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Kembali',
                          style: buttonTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onBottomSheetSecond() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xff737373),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Informasi Kategori Sikap',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    /* SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '⦿',
                          style: subInfoNilaiTextStyle,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Point 0',
                          style: subInfoNilaiTextStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Karyawan tidak melakukan pelanggaran.',
                        style: infoNilaiTextStyle,
                        textAlign: TextAlign.justify,
                      ),
                    ), */
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '⦿',
                          style: subInfoNilaiTextStyle,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Point 1',
                          style: subInfoNilaiTextStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Karyawan pernah mengeluh/ complain/ menolak/ tidak melaksanakan saat diberi perintah/ tugas.',
                        style: infoNilaiTextStyle,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '⦿',
                          style: subInfoNilaiTextStyle,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Point 2',
                          style: subInfoNilaiTextStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Karyawan pernah tidak memahami/ sulit memahami instruksi yang diberikan.',
                        style: infoNilaiTextStyle,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '⦿',
                          style: subInfoNilaiTextStyle,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Point 3',
                          style: subInfoNilaiTextStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Karyawan pernah menunjukan sikap tidak semangat dalam bekerja.',
                        style: infoNilaiTextStyle,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '⦿',
                          style: subInfoNilaiTextStyle,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Point 4',
                          style: subInfoNilaiTextStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Karyawan pernah melakukan tindakan indisipliner (misal: tidur dalam jam kerja; meninggalkan ruang kerja tanpa izin; terlambat masuk setelah istirahat; tidak melaksanakan CPOB; tidak memakai masker; tidak physical distancing; dsj.',
                        style: infoNilaiTextStyle,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '⦿',
                          style: subInfoNilaiTextStyle,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Point 5',
                          style: subInfoNilaiTextStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Karyawan pernah tidak melapor ke atasan saat mengalami hambatan, tidak bisa mengerjakan, atau sudah selesai mengerjakan tugas.',
                        style: infoNilaiTextStyle,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '⦿',
                          style: subInfoNilaiTextStyle,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Point 6',
                          style: subInfoNilaiTextStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Karyawan cenderung bermasalah dengan rekan kerja (misal: tidak mau bekerja sama; tidak berbagi tugas; tidak bersedia membantu; tidak ramah; dsb).',
                        style: infoNilaiTextStyle,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '⦿',
                          style: subInfoNilaiTextStyle,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Point 7',
                          style: subInfoNilaiTextStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Karyawan pernah bersikap tidak sopan dan tidak pantas terhadap atasan/ rekan kerja/ karyawan lain (termasuk: bersiul; menyindir dengan sengaja; menggoda lawan jenis; memanggil rekan kerja dengan berteriak; dan tindakan tidak sopan/ pantas lainnya).',
                        style: infoNilaiTextStyle,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xff4141A4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Kembali',
                          style: buttonTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
              ),
            ),
          ),
        );
      },
    );
  }
}

class NumericalRangeFormatter extends TextInputFormatter {
  final int min;
  final int max;

  NumericalRangeFormatter({this.min, this.max});

  int zero = 0;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    } else if (int.parse(newValue.text) == 0) {
      return TextEditingValue().copyWith(text: '0');
    } else if (int.parse(newValue.text) < min) {
      return TextEditingValue().copyWith(text: min.toStringAsFixed(2));
    } else {
      return int.parse(newValue.text) > max ? oldValue : newValue;
    }
  }
}
