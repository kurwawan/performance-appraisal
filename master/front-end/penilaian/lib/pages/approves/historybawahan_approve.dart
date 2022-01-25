import 'package:flutter/material.dart';
import 'package:penilaian/models/approves/historybawahan_model.dart';
import 'package:penilaian/pages/approves/historyatasan_approve.dart';
import 'package:penilaian/pages/approves/historyperiode_approve.dart';
import 'package:penilaian/providers/approves/historybawahan_provider.dart';
import 'package:penilaian/theme.dart';
import 'package:provider/provider.dart';

class HistoryBawahanPage extends StatefulWidget {
  // const HistoryBawahanPage({ Key? key }) : super(key: key);
  final String ats;
  final String ajbAts;
  final String atasan;

  HistoryBawahanPage({
    this.ats,
    this.ajbAts,
    this.atasan,
  });

  @override
  _HistoryBawahanPageState createState() => _HistoryBawahanPageState();
}

class _HistoryBawahanPageState extends State<HistoryBawahanPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HistoryAtasanPage(),
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
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 5,
                  left: 16,
                  right: 16,
                ),
                child: listAtasan(),
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
              'List Bawahan',
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
          Icons.supervisor_account_rounded,
          size: 50,
        ),
      ],
    );
  }

  Widget listAtasan() {
    var historyBawahanProvider = Provider.of<HistoryBawahanProvider>(context);

    return FutureBuilder<List<HistoryBawahanModel>>(
      future: historyBawahanProvider.getHistory(widget.ats, widget.ajbAts),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: snapshot.data
                .map(
                  (historyBawahan) => InkWell(
                    child: Card(
                      color: Color(0xff0D2137),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              historyBawahan.nmp,
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
                          builder: (context) => HistoryPeriodeApprove(
                            ats: widget.ats,
                            ajbAts: widget.ajbAts,
                            nik: historyBawahan.nik.toString(),
                            atasan: widget.atasan,
                            bawahan: historyBawahan.nmp,
                          ),
                        ),
                      );
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
}
