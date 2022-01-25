import 'package:flutter/material.dart';
import 'package:penilaian/models/approves/historyatasan_model.dart';
import 'package:penilaian/providers/approves/historyatasan_provider.dart';
import 'package:penilaian/theme.dart';
import 'package:provider/provider.dart';
import 'package:penilaian/pages/approves/historybawahan_approve.dart';

class HistoryAtasanPage extends StatefulWidget {
  // const HistoryAtasanPage({ Key? key }) : super(key: key);

  @override
  _HistoryAtasanPageState createState() => _HistoryAtasanPageState();
}

class _HistoryAtasanPageState extends State<HistoryAtasanPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
    );
  }

  Widget header() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'List Atasan',
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
    var historyAtasanProvider = Provider.of<HistoryAtasanProvider>(context);

    return FutureBuilder<List<HistoryAtasanModel>>(
      future: historyAtasanProvider.getHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: snapshot.data
                .map(
                  (historyAtasan) => InkWell(
                    child: Card(
                      color: Color(0xff0D2137),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              historyAtasan.atasan,
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
                          builder: (context) => HistoryBawahanPage(
                            ats: historyAtasan.ats,
                            ajbAts: historyAtasan.ajbAts,
                            atasan: historyAtasan.atasan,
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
