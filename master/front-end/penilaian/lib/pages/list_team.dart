import 'package:flutter/material.dart';
import 'package:penilaian/models/team_model.dart';
import 'package:penilaian/pages/list_week.dart';
import 'package:penilaian/pages/results/result_team.dart';
import 'package:penilaian/providers/team_provider.dart';
import 'package:penilaian/theme.dart';
import 'package:provider/provider.dart';

class ListTeamPage extends StatefulWidget {
  // const ListTeamPage({ Key? key }) : super(key: key);
  final String nip;
  final String idPeriode;
  final String mingguN;
  final String categoryTeam;

  ListTeamPage({
    Key key,
    this.nip,
    this.idPeriode,
    this.mingguN,
    this.categoryTeam,
  }) : super(key: key);

  @override
  _ListTeamPageState createState() => _ListTeamPageState();
}

class _ListTeamPageState extends State<ListTeamPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ListWeekPage(
                action: widget.categoryTeam,
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
                  header(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Minggu ke :',
                          style: periodeTextStyle,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.mingguN.toString(),
                          style: periodeTextStyle,
                        ),
                      ],
                    ),
                  ),
                  listTeam(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    if (widget.categoryTeam == 'add') {
      return Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'List Team',
                style: titleTextStyle,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Daftar Nama Team',
                style: subTitleTextStyle,
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.group_sharp,
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
                'List Team',
                style: titleTextStyle,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Update Nilai Team',
                style: subTitleTextStyle,
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.group_sharp,
            size: 50,
          ),
        ],
      );
    }
  }

  Widget listTeam() {
    var teamProvider = Provider.of<TeamProvider>(context);
    if (widget.categoryTeam == 'add') {
      return FutureBuilder<List<TeamModel>>(
        future: teamProvider.getTeams(
            widget.nip.toString(), widget.idPeriode.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 150,
                        color: Color(0xff4141A4),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Sudah dinilai semua',
                        style: dataEmptyDoneTextStyle,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Column(
                children: snapshot.data
                    .map(
                      (team) => InkWell(
                        child: Card(
                          color: Color(0xffFA9F42),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 20,
                                ),
                                child: Icon(
                                  Icons.account_circle_rounded,
                                  color: Colors.white,
                                  size: 55,
                                ),
                              ),
                              Container(
                                width: 150,
                                child: Text(
                                  team.nmp,
                                  overflow: TextOverflow.ellipsis,
                                  style: listTeamTextStyle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
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
                              builder: (BuildContext context) => ResultTeamPage(
                                nip: widget.nip.toString(),
                                idPeriode: widget.idPeriode.toString(),
                                mingguN: widget.mingguN.toString(),
                                nmp: team.nmp.toString(),
                                jbtb: team.jbtb.toString(),
                                alv: team.alv.toString(),
                                nikb: team.nikb.toString(),
                                kodePriode: team.kdPeriode.toString(),
                                categoryResult: 'add',
                              ),
                            ),
                          );
                        },
                      ),
                    )
                    .toList(),
              );
            }
          }

          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xffFA9F42),
                ),
              ),
            ),
          );
        },
      );
    } else {
      return FutureBuilder<List<TeamModel>>(
        future: teamProvider.getAllTeams(
            widget.nip.toString(), widget.idPeriode.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.announcement_outlined,
                        size: 150,
                        color: Colors.red[900],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Belum ada yang dinilai',
                        style: dataEmptyTextStyle,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Column(
                children: snapshot.data
                    .map(
                      (team) => InkWell(
                        child: Card(
                          color: Color(0xffFA9F42),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 20,
                                ),
                                child: Icon(
                                  Icons.account_circle_rounded,
                                  color: Colors.white,
                                  size: 55,
                                ),
                              ),
                              Container(
                                width: 150,
                                child: Text(
                                  team.nmp,
                                  overflow: TextOverflow.ellipsis,
                                  style: listTeamTextStyle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
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
                              builder: (BuildContext context) => ResultTeamPage(
                                nip: widget.nip.toString(),
                                idPeriode: widget.idPeriode.toString(),
                                mingguN: widget.mingguN.toString(),
                                nmp: team.nmp.toString(),
                                jbtb: team.jbtb.toString(),
                                alv: team.alv.toString(),
                                nikb: team.nikb.toString(),
                                kodePriode: team.kdPeriode.toString(),
                                categoryResult: 'update',
                              ),
                            ),
                          );
                        },
                      ),
                    )
                    .toList(),
              );
            }
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xffFA9F42),
                  ),
                ),
              ),
            ); // loading
          }
        },
      );
    }
  }
}
