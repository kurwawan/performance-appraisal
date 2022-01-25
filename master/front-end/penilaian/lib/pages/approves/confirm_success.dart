import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penilaian/pages/approves/date_approve.dart';
import 'package:penilaian/pages/approves/user_approve.dart';

class ConfirmSuccessPage extends StatefulWidget {
  // const ConfirmSuccessPage({ Key? key }) : super(key: key);
  final String tgu;

  ConfirmSuccessPage({
    Key key,
    this.tgu,
  }) : super(key: key);

  @override
  _ConfirmSuccessPageState createState() => _ConfirmSuccessPageState();
}

class _ConfirmSuccessPageState extends State<ConfirmSuccessPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ListDateApprove(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
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
                'Konfirmasi Berhasil',
                style: GoogleFonts.poppins(
                  color: Color(0xff1F5F5B),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xff1F5F5B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
