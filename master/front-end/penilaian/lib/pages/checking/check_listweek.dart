import 'package:flutter/material.dart';
import 'package:penilaian/pages/checking/check_listteam.dart';
import 'package:penilaian/pages/home.dart';
import 'package:penilaian/providers/user_provider.dart';
import 'package:penilaian/providers/week_provider.dart';
import 'package:penilaian/theme.dart';
import 'package:provider/provider.dart';
import 'package:penilaian/models/week_model.dart';

class CheckListWeekPage extends StatefulWidget {
  // const CheckListWeekPage({ Key? key }) : super(key: key);.
  final String nip;
  final String ajb;

  CheckListWeekPage({
    this.nip,
    this.ajb,
  });

  @override
  _CheckListWeekPageState createState() => _CheckListWeekPageState();
}

class _CheckListWeekPageState extends State<CheckListWeekPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => HomePage(
                nip: widget.nip,
                ajb: widget.ajb,
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
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: header(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      '',
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
              'List Week',
              style: titleTextStyle,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Pengecekan Nilai',
              style: subTitleTextStyle,
            ),
          ],
        ),
        Spacer(),
        Icon(
          Icons.date_range_rounded,
          size: 50,
        ),
      ],
    );
  }

  Widget listWeek() {
    var weekProvider = Provider.of<WeekProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    return FutureBuilder<List<WeekModel>>(
      future: weekProvider.getCheckWeeks(
        userProvider.user.nip.toString(),
        userProvider.user.ajb.toString(),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: snapshot.data
                .map((week) => InkWell(
                      child: Card(
                        color: Color(0xff1F5F5B),
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
                                    week.mingguN,
                                    style: listWeekTextStyle,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  week.nmPeriode,
                                  style: listWeekTextStyle,
                                ),
                                Text(
                                  week.tglAwalMinggu.substring(8, 10) +
                                      "-" +
                                      week.tglAwalMinggu.substring(5, 7) +
                                      "-" +
                                      week.tglAwalMinggu.substring(0, 4),
                                  style: subWeekTextStyle,
                                ),
                                Text(
                                  's/d',
                                  style: subWeekTextStyle,
                                ),
                                Text(
                                  week.tglAkhirMinggu.substring(8, 10) +
                                      "-" +
                                      week.tglAkhirMinggu.substring(5, 7) +
                                      "-" +
                                      week.tglAkhirMinggu.substring(0, 4),
                                  style: subWeekTextStyle,
                                ),
                              ],
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
                                CheckListTeamPage(
                              nip: userProvider.user.nip.toString(),
                              mingguN: week.mingguN.toString(),
                              idPeriode: week.idDetilPeriode,
                              ajb: userProvider.user.ajb.toString(),
                            ),
                          ),
                        );
                      },
                    ))
                .toList(),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xff1F5F5B),
              ),
            ),
          ),
        );
      },
    );
  }
}
