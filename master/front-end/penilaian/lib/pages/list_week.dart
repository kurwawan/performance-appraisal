import 'package:flutter/material.dart';
import 'package:penilaian/pages/home.dart';
import 'package:penilaian/pages/list_team.dart';
import 'package:penilaian/providers/user_provider.dart';
import 'package:penilaian/providers/week_provider.dart';
import 'package:penilaian/theme.dart';
import 'package:provider/provider.dart';
import 'package:penilaian/models/week_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListWeekPage extends StatefulWidget {
  // const ListWeekPage({ Key? key }) : super(key: key);.
  final String action;
  final String nip;
  final String ajb;

  ListWeekPage({
    this.action,
    this.nip,
    this.ajb,
  });

  @override
  _ListWeekPageState createState() => _ListWeekPageState();
}

class _ListWeekPageState extends State<ListWeekPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => HomePage(
                nip: widget.nip,
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
    if (widget.action == 'add') {
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
                'Daftar yang Belum di Nilai',
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
    } else {
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
                'Update Nilai',
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
  }

  Widget listWeek() {
    var weekProvider = Provider.of<WeekProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    if (widget.action == 'add') {
      return FutureBuilder<List<WeekModel>>(
        future: weekProvider.getWeeks(userProvider.user.nip.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: snapshot.data
                  .map(
                    (week) => InkWell(
                      child: Card(
                        color: Color(0xff4141A4),
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
                            builder: (BuildContext context) => ListTeamPage(
                              nip: userProvider.user.nip.toString(),
                              mingguN: week.mingguN.toString(),
                              idPeriode: week.idDetilPeriode,
                              categoryTeam: 'add',
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
                  Color(0xff4141A4),
                ),
              ),
            ),
          );
        },
      );
    } else {
      return FutureBuilder<List<WeekModel>>(
        future: weekProvider.getAllWeeks(userProvider.user.nip.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: snapshot.data
                  .map((week) => InkWell(
                        child: Card(
                          color: Color(0xff4141A4),
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
                              builder: (BuildContext context) => ListTeamPage(
                                nip: userProvider.user.nip.toString(),
                                mingguN: week.mingguN.toString(),
                                idPeriode: week.idDetilPeriode,
                                categoryTeam: 'update',
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
                  Color(0xff4141A4),
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
