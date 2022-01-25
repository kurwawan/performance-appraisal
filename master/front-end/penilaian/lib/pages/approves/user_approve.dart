import 'package:flutter/material.dart';
import 'package:penilaian/models/approves/userapprove_model.dart';
import 'package:penilaian/pages/approves/confirm_approve.dart';
import 'package:penilaian/pages/approves/date_approve.dart';
import 'package:penilaian/pages/home.dart';
import 'package:penilaian/providers/approves/userapprove_provider.dart';
import 'package:penilaian/theme.dart';
import 'package:provider/provider.dart';

class ListUserApprove extends StatefulWidget {
  // const ListUserApprove({ Key? key }) : super(key: key);.
  final String tgu;

  ListUserApprove({
    this.tgu,
  });

  @override
  _ListUserApproveState createState() => _ListUserApproveState();
}

class _ListUserApproveState extends State<ListUserApprove> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ListDateApprove(),
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
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: header(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      widget.tgu.toString().substring(8, 10) +
                          ' / ' +
                          widget.tgu.toString().substring(5, 7) +
                          ' / ' +
                          widget.tgu.toString().substring(0, 4),
                      style: periodeTextStyle,
                    ),
                  ),
                  listWeek(),
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
              'List User',
              style: titleTextStyle,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Konfirmasi Nilai',
              style: subTitleTextStyle,
            ),
          ],
        ),
        Spacer(),
        Icon(
          Icons.supervised_user_circle,
          size: 50,
        ),
      ],
    );
  }

  Widget listWeek() {
    var approveUserProvider = Provider.of<UserApproveProvider>(context);

    return FutureBuilder<List<UserApproveModel>>(
      future: approveUserProvider.getApproveUsers(widget.tgu),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
              children: snapshot.hasData
                  ? snapshot.data
                      .map((approveUser) => InkWell(
                            child: Card(
                              color: Color(0xff0D2137),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: Text(
                                      approveUser.atasan,
                                      style: listWeekTextStyle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      color: Colors.white,
                                      size: 55,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ConfirmPage(
                                    tguById: approveUser.tgu,
                                    tgu: widget.tgu,
                                    id: approveUser.id,
                                    atasan: approveUser.atasan,
                                    jbAtasan: approveUser.jbtAts,
                                    bawahan: approveUser.bawahan,
                                    jbBawahan: approveUser.jbtBwh,
                                    idPeriode: approveUser.idPeriode,
                                    nik: approveUser.nik,
                                    alsFrom: approveUser.alsFrom,
                                    a1: approveUser.a1,
                                    a2: approveUser.a2,
                                    a3: approveUser.a3,
                                    a4: approveUser.a4,
                                    c4: approveUser.c4,
                                    ctt: approveUser.ctt,
                                    mingguN: approveUser.mingguN,
                                    tglAwal: approveUser.tglAwalMinggu,
                                    tglAkhir: approveUser.tglAkhirMinggu,
                                    periode: approveUser.nmPeriode,
                                    a1Old: approveUser.a1Old,
                                    a2Old: approveUser.a2Old,
                                    a3Old: approveUser.a3Old,
                                    a4Old: approveUser.a4Old,
                                    cttOld: approveUser.cttOld,
                                  ),
                                ),
                              );
                            },
                          ))
                      .toList()
                  : //data null
                  /* Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  ), */
                  []);
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
