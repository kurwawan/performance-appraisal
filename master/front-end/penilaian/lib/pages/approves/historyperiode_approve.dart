import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penilaian/pages/approves/historybawahan_approve.dart';
import 'package:penilaian/providers/approves/historyperiode_provider.dart';
import 'package:penilaian/providers/approves/historydetailperiode_provider.dart';
import 'package:penilaian/theme.dart';
import 'package:provider/provider.dart';
import 'package:penilaian/models/approves/historyperiode_model.dart';
import 'package:penilaian/models/approves/historydetailperiode_model.dart';

class HistoryPeriodeApprove extends StatefulWidget {
  // const HistoryPeriodeApprove({ Key? key }) : super(key: key);
  final String ats;
  final String ajbAts;
  final String nik;
  final String atasan;
  final String bawahan;

  HistoryPeriodeApprove({
    this.ats,
    this.ajbAts,
    this.nik,
    this.atasan,
    this.bawahan,
  });

  @override
  _HistoryPeriodeApproveState createState() => _HistoryPeriodeApproveState();
}

class _HistoryPeriodeApproveState extends State<HistoryPeriodeApprove> {
  String tempPeroide;
  String tempMinggu;
  String tempRangeMinggu;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HistoryBawahanPage(
              ats: widget.ats,
              ajbAts: widget.ajbAts,
              atasan: widget.atasan,
            ),
          ),
        );
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 5,
                  left: 16,
                  right: 16,
                ),
                child: header(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'Atasan :  ',
                      style: periodeTextStyle,
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          widget.atasan,
                          style: namaPenilaianTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'Bawahan :  ',
                      style: periodeTextStyle,
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          widget.bawahan,
                          style: namaPenilaianTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 5,
                  left: 16,
                  right: 16,
                ),
                child: listPeriode(),
              ),
            ],
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
              'List Periode',
              style: titleTextStyle,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Riwayat Pengajuan',
              style: subTitleTextStyle,
            ),
          ],
        ),
        Spacer(),
        Icon(
          Icons.date_range_sharp,
          size: 50,
        ),
      ],
    );
  }

  Widget listPeriode() {
    var historyPeriodeProvider = Provider.of<HistoryPeriodeProvider>(context);

    return FutureBuilder<List<HistoryPeriodeModel>>(
      future: historyPeriodeProvider.getHistory(widget.nik),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: snapshot.data
                .map(
                  (historyPeriode) => InkWell(
                    child: Card(
                      color: Color(0xff0D2137),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: Colors.white,
                                  size: 55,
                                ),
                                Text(
                                  historyPeriode.mingguN,
                                  style: listWeekTextStyle,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                historyPeriode.nmPeriode,
                                style: listWeekTextStyle,
                              ),
                              Text(
                                historyPeriode.tglAwalMinggu.substring(8, 10) +
                                    "-" +
                                    historyPeriode.tglAwalMinggu
                                        .substring(5, 7) +
                                    "-" +
                                    historyPeriode.tglAwalMinggu
                                        .substring(0, 4),
                                style: subWeekTextStyle,
                              ),
                              Text(
                                's/d',
                                style: subWeekTextStyle,
                              ),
                              Text(
                                historyPeriode.tglAkhirMinggu.substring(8, 10) +
                                    "-" +
                                    historyPeriode.tglAkhirMinggu
                                        .substring(5, 7) +
                                    "-" +
                                    historyPeriode.tglAkhirMinggu
                                        .substring(0, 4),
                                style: subWeekTextStyle,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.insert_drive_file_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      tempPeroide = historyPeriode.idPeriode.toString();
                      print('HASIL : ' + widget.nik + ' and ' + tempPeroide);
                      tempMinggu = historyPeriode.mingguN.toString();
                      tempRangeMinggu =
                          historyPeriode.tglAwalMinggu.substring(8, 10) +
                              "-" +
                              historyPeriode.tglAwalMinggu.substring(5, 7) +
                              "-" +
                              historyPeriode.tglAwalMinggu.substring(0, 4) +
                              '  s/d  ' +
                              historyPeriode.tglAkhirMinggu.substring(8, 10) +
                              "-" +
                              historyPeriode.tglAkhirMinggu.substring(5, 7) +
                              "-" +
                              historyPeriode.tglAkhirMinggu.substring(0, 4);
                      _onBottomSheet();
                    },
                  ),
                )
                .toList(),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xff0D2137),
              ),
            ),
          ),
        );
      },
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
                        'Detail Riwayat',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Minggu ke ' + tempMinggu,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        tempRangeMinggu,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    nilaiAwal(),
                    Divider(
                      height: 20,
                      thickness: 8,
                    ),
                    listDetailPeriode(),
                    SizedBox(
                      height: 10,
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

  Widget nilaiAwal() {
    /* return; */

    var historyDetailPeriodeProvider =
        Provider.of<HistoryDetailPeriodeProvider>(context);

    return FutureBuilder<List<HistoryDetailPeriodeModel>>(
      future:
          historyDetailPeriodeProvider.getNilaiLama(widget.nik, tempPeroide),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: snapshot.data.map(
              (historyNilaiLama) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.green
                                  .withOpacity(0.25), // border color
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2), // border width
                              child: Container(
                                // or ClipRRect if you need to clip the content
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Colors.yellow[900], // inner circle color
                                ),
                                // inner content
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            /* historyNilaiLama.tgu.substring(8, 10) +
                                "-" +
                                historyNilaiLama.tgu.substring(5, 7) +
                                "-" +
                                historyNilaiLama.tgu.substring(0, 4) +
                                '  ' +
                                historyNilaiLama.tgu.substring(11, 19) +
                                '  [' + */
                            ('Nilai Awal') /*  + ']' */,
                            style: detailHositoryTextStyle,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('A1'),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text('A3'),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(':'),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(':'),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(historyNilaiLama.a1),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(historyNilaiLama.a3),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('A2'),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text('A4'),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(':'),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(':'),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(historyNilaiLama.a2),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(historyNilaiLama.a4),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Visibility(
                                visible:
                                    historyNilaiLama.c4 == '' ? false : true,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('C4'),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(''),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(':'),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(''),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(historyNilaiLama.c4),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(''),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xff0D2137),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget listDetailPeriode() {
    /* return; */

    var historyDetailPeriodeProvider =
        Provider.of<HistoryDetailPeriodeProvider>(context);
    int i = 0;

    return FutureBuilder<List<HistoryDetailPeriodeModel>>(
      future: historyDetailPeriodeProvider.getHistory(widget.nik, tempPeroide),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: snapshot.data.map(
              (historyDetailPeriode) {
                i++;
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: i == 1 ? false : true,
                        child: Container(
                          child: VerticalDivider(
                            color: Color(0xffB3B5C4),
                            thickness: 2,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.green
                                  .withOpacity(0.25), // border color
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2), // border width
                              child: Container(
                                // or ClipRRect if you need to clip the content
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: historyDetailPeriode.status == null
                                      ? Color(0xff4141A4)
                                      : historyDetailPeriode.status == '1'
                                          ? Color(0xff1F5F5B)
                                          : Colors
                                              .red[900], // inner circle color
                                ),
                                // inner content
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            historyDetailPeriode.tgu.substring(8, 10) +
                                "-" +
                                historyDetailPeriode.tgu.substring(5, 7) +
                                "-" +
                                historyDetailPeriode.tgu.substring(0, 4) +
                                '  ' +
                                historyDetailPeriode.tgu.substring(11, 19) +
                                '  [' +
                                (historyDetailPeriode.status == null
                                    ? 'Belum'
                                    : historyDetailPeriode.status == '1'
                                        ? 'Setuju'
                                        : 'Tolak') +
                                ']',
                            style: detailHositoryTextStyle,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('A1'),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text('A3'),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(':'),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(':'),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(historyDetailPeriode.a1),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(historyDetailPeriode.a3),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('A2'),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text('A4'),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(':'),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(':'),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(historyDetailPeriode.a2),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(historyDetailPeriode.a4),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Visibility(
                                visible: historyDetailPeriode.c4 == ''
                                    ? false
                                    : true,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('C4'),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(''),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(':'),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(''),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(historyDetailPeriode.c4),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(''),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: historyDetailPeriode.status == null
                            ? false
                            : historyDetailPeriode.status == '1'
                                ? false
                                : true,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            historyDetailPeriode.status == null
                                ? ''
                                : historyDetailPeriode.status == '1'
                                    ? ''
                                    : historyDetailPeriode.status == '2'
                                        ? ''
                                        : 'Alasan Ditolak :  ' +
                                            historyDetailPeriode.alsFrom,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xff0D2137),
              ),
            ),
          ),
        );
      },
    );
  }
}
