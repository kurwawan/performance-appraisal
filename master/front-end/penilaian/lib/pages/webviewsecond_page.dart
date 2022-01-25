import 'dart:async';

import 'package:flutter/material.dart';
import 'package:penilaian/pages/login.dart';
import 'package:penilaian/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewSecondPage extends StatefulWidget {
  // const WebViewSecondPage({ Key? key }) : super(key: key);

  @override
  _WebViewSecondPageState createState() => _WebViewSecondPageState();
}

class _WebViewSecondPageState extends State<WebViewSecondPage> {
  bool isInvisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(
              isState: false,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return null;
      },
      child: SafeArea(
        child: Scaffold(
          body: Visibility(
            visible: false,
            child: WebView(
              initialUrl: 'http://ifarssolo.ip-dynamic.com:6501',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
          floatingActionButton: _button(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  _button() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: 175,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff4141A4),
              ),
              color: Color(0xff4141A4),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Mengakses server',
                      style: buttonTextStyle,
                    ),
                    SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
