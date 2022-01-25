import 'dart:async';

import 'package:flutter/material.dart';
import 'package:penilaian/pages/list_team.dart';
import 'package:penilaian/theme.dart';

class ResultSuccessPage extends StatefulWidget {
  // const ResultSuccessPage({ Key? key }) : super(key: key);
  final String nip;
  final String idPeriode;
  final String mingguN;
  final String categorySuccess;

  ResultSuccessPage({
    Key key,
    this.nip,
    this.idPeriode,
    this.mingguN,
    this.categorySuccess,
  }) : super(key: key);

  @override
  _ResultSuccessPageState createState() => _ResultSuccessPageState();
}

class _ResultSuccessPageState extends State<ResultSuccessPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      if (widget.categorySuccess == 'add') {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ListTeamPage(
                      nip: widget.nip,
                      mingguN: widget.mingguN,
                      idPeriode: widget.idPeriode,
                      categoryTeam: 'add',
                    )));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ListTeamPage(
                      nip: widget.nip,
                      mingguN: widget.mingguN,
                      idPeriode: widget.idPeriode,
                      categoryTeam: 'update',
                    )));
      }

      /* Navigator.pop(context); */
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 150,
                color: Color(0xff4141A4),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  widget.categorySuccess == 'add'
                      ? 'Sukses Menyimpan Nilai'
                      : 'Berhasil Mengajukan Perubahan',
                  style: successTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff4141A4)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
