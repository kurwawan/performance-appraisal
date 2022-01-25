import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penilaian/config.dart';
import 'package:penilaian/models/approves/historyuser_model.dart';
import 'package:penilaian/pages/approves/choice_approve.dart';
import 'package:penilaian/pages/checking/check_listweek.dart';
import 'package:penilaian/providers/approves/historydetailperiode_provider.dart';
import 'package:penilaian/providers/user_provider.dart';
import 'package:penilaian/theme.dart';
import 'package:penilaian/pages/list_week.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  // const HomePage({ Key? key }) : super(key: key);
  final String nip;
  final String ajb;

  HomePage({
    this.nip,
    this.ajb,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var baseUrl = Config.url;
  bool isCheckLoad = false;

  bool isNotif = false;
  bool isNotNotif = true;

  bool isNotifSecond = false;
  bool isNotNotifSecond = true;

  Future logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('nip');
    sharedPreferences.remove('ajb');
    /* Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => MyApp())); */
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (route) => false,
    );
  }

  String checkTotal = '';
  Future getIsCheck(String nik, String ajb) async {
    try {
      String url = "$baseUrl/penilaian/web/api/get/ischeck?nik=$nik&ajb=$ajb";

      final response = await http.get(url);
      if (response.body.toString() == '[]') {
        print('nilai kosong');
        checkTotal = '';
      } else {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          checkTotal = data[0]['total'];
          print('total : ' + checkTotal);
        } else {
          return null;
        }
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  String spNipGlobal;

  Future getNip() async {
    String spNip = '', spAjb = '';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      spNipGlobal = sharedPreferences.getString('nip');
      spNip = sharedPreferences.getString('nip');
      spAjb = sharedPreferences.getString('ajb');

      isCheckLoad = true;
      getIsCheck(spNip, spAjb).whenComplete(() {
        setState(() {
          isCheckLoad = false;
          print('NIP : ' + spNipGlobal);
        });
      }).catchError((e) {
        print(e.toString());
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getNip();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 5,
              left: 16,
              right: 16,
            ),
            child: isCheckLoad
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xff4141A4),
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        header(),
                        SizedBox(
                          height: 30,
                        ),
                        bodyStatus(),
                        SizedBox(
                          height: 10,
                        ),
                        bodyPenilaian(),
                        SizedBox(
                          height: 10,
                        ),
                        bodyPerubahan(),
                        SizedBox(
                          height: 10,
                        ),
                        checkTotal == '0' ? Container() : bodyCheck(),
                        SizedBox(
                          height: 10,
                        ),
                        bodyApprove(),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    var userProvider = Provider.of<UserProvider>(context);

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 250,
              child: Text(
                'Selamat datang,\n' + userProvider.user.nmp,
                style: titleTextStyle,
                overflow: TextOverflow.clip,
              ),
            ),
            Container(
              width: 250,
              child: Text(
                userProvider.user.jbt,
                style: subTitleTextStyle,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
        Spacer(),
        Ink(
          decoration: ShapeDecoration(
            color: Colors.red[900],
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(
              Icons.highlight_off_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              showAlertDialog(context);
            },
          ),
        ),
      ],
    );
  }

  Widget bodyStatus() {
    return Container(
      width: double.infinity,
      height: 120,
      child: InkWell(
        onTap: () async {
          _onBottomSheet();
        },
        child: Card(
          color: Colors.red[900],
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notifikasi',
                            style: menuTextStyle,
                          ),
                          Text(
                            'Cek secara berkala status pengajuan perubahan nilai.',
                            style: subMenuTextStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
                        'Riwayat Pengajuan',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    listHistory(),
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

  Widget listHistory() {
    var historyDetailPeriodeProvider =
        Provider.of<HistoryDetailPeriodeProvider>(context);
    int i = 0;

    return FutureBuilder<List<HistoryUserModel>>(
      future: historyDetailPeriodeProvider.getAllStatus(spNipGlobal),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: snapshot.data.map(
              (historyDetailPeriode) {
                i++;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* Visibility(
                      visible: i == 1 ? false : true,
                      child: Container(
                        height: 20,
                        child: VerticalDivider(
                          color: Color(0xffB3B5C4),
                          thickness: 2,
                        ),
                      ),
                    ), */
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color:
                                Colors.green.withOpacity(0.25), // border color
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
                                        : Colors.red[900], // inner circle color
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
                      padding: EdgeInsets.only(
                        left: 25,
                        right: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bawahan : ' + historyDetailPeriode.nmp,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            historyDetailPeriode.nmPeriode,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Minggu ke - ' + historyDetailPeriode.mingguN,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                historyDetailPeriode.tglAwalMinggu
                                        .substring(8, 10) +
                                    "-" +
                                    historyDetailPeriode.tglAwalMinggu
                                        .substring(5, 7) +
                                    "-" +
                                    historyDetailPeriode.tglAwalMinggu
                                        .substring(0, 4) +
                                    '  ',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                's/d',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                historyDetailPeriode.tglAkhirMinggu
                                        .substring(8, 10) +
                                    "-" +
                                    historyDetailPeriode.tglAkhirMinggu
                                        .substring(5, 7) +
                                    "-" +
                                    historyDetailPeriode.tglAkhirMinggu
                                        .substring(0, 4) +
                                    '  ',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Alasan : ' + historyDetailPeriode.alsFrom,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            historyDetailPeriode.alsTo == null ||
                                    historyDetailPeriode.alsTo == ''
                                ? '-'
                                : 'Tanggapan : ' + historyDetailPeriode.alsTo,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 20,
                      thickness: 8,
                    ),
                  ],
                );
              },
            ).toList(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 30,
            ),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.red[900],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget bodyPenilaian() {
    return Container(
      width: double.infinity,
      height: 120,
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ListWeekPage(
                action: 'add',
                nip: widget.nip,
                ajb: widget.ajb,
              ),
            ),
          );
        },
        child: Card(
          color: Color(0xff4141A4),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Penilaian',
                            style: menuTextStyle,
                          ),
                          Text(
                            'Penilaian tim karyawan yang dilakukan oleh atasan.',
                            style: subMenuTextStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyPerubahan() {
    return Container(
      width: double.infinity,
      height: 120,
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ListWeekPage(
                action: 'update',
                nip: widget.nip,
                ajb: widget.ajb,
              ),
            ),
          );
        },
        child: Card(
          color: Color(0xffFA9F42),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Perubahan',
                            style: menuTextStyle,
                          ),
                          Text(
                            'Perubahan nilai tim karyawan yang dilakukan oleh atasan.',
                            style: subMenuTextStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyCheck() {
    return Container(
      width: double.infinity,
      height: 120,
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CheckListWeekPage(
                nip: widget.nip,
                ajb: widget.ajb,
              ),
            ),
          );
        },
        child: Card(
          color: Color(0xff1F5F5B),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pengecekan',
                            style: menuTextStyle,
                          ),
                          Text(
                            'Cek bawahan yang belum melakukan penilaian.',
                            style: subMenuTextStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyApprove() {
    var userProvider = Provider.of<UserProvider>(context);

    return Visibility(
      visible:
          userProvider.user.jbt.toString().contains('Human') ? true : false,
      child: Container(
        width: double.infinity,
        height: 120,
        child: InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ChoicePage(
                  nip: widget.nip,
                  ajb: widget.ajb,
                ),
              ),
            );
          },
          child: Card(
            color: Color(0xff0D2137),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Approve',
                              style: menuTextStyle,
                            ),
                            Text(
                              'Persetujuan pengajuan perubahan nilai karayawan.',
                              style: subMenuTextStyle,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 1,
                        child: Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
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

  showAlertDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        'Tidak',
        style: alertNoTextStyle,
      ),
    );

    Widget continueButton = FlatButton(
      onPressed: () {
        /* Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LoginPage(),
          ),
        ); */
        logOut();
      },
      child: Text(
        'Ya',
        style: alertYesTextStyle,
      ),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text(
        'Logout ?',
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}
