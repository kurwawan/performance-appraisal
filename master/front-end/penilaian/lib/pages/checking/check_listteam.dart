import 'package:flutter/material.dart';
import 'package:penilaian/models/checking/checkteam_model.dart';
import 'package:penilaian/models/team_model.dart';
import 'package:penilaian/pages/checking/check_listweek.dart';
import 'package:penilaian/providers/team_provider.dart';
import 'package:penilaian/theme.dart';
import 'package:provider/provider.dart';

class CheckListTeamPage extends StatefulWidget {
  // const CheckListTeamPage({ Key? key }) : super(key: key);
  final String nip;
  final String idPeriode;
  final String mingguN;
  final String ajb;

  CheckListTeamPage({
    Key key,
    this.nip,
    this.idPeriode,
    this.mingguN,
    this.ajb,
  }) : super(key: key);

  @override
  _CheckListTeamPageState createState() => _CheckListTeamPageState();
}

class _CheckListTeamPageState extends State<CheckListTeamPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CheckListWeekPage(),
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
              'Belum Menilai',
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

  Widget listTeam() {
    var teamProvider = Provider.of<TeamProvider>(context);

    return FutureBuilder<List<CheckTeamModel>>(
      future: teamProvider.getCheckTeams(
        widget.nip.toString(),
        widget.idPeriode.toString(),
        widget.ajb.toString(),
      ),
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
                      color: Color(0xff1F5F5B),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Semua sudah melakukan penilaian',
                      style: dataEmptyCheckTextStyle,
                      textAlign: TextAlign.center,
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
                        color: Color(0xff1F5F5B),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 20,
                                left: 5,
                              ),
                              child: Icon(
                                Icons.account_circle_rounded,
                                color: Colors.white,
                                size: 55,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(
                                team.nmp,
                                overflow: TextOverflow.ellipsis,
                                style: listTeamTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
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
                  Color(0xff1F5F5B),
                ),
              ),
            ),
          ); // loading
        }
      },
    );
  }
}
