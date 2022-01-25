import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:penilaian/models/user_model.dart';
import 'package:penilaian/pages/home.dart';
import 'package:penilaian/providers/login_provider.dart';
import 'package:penilaian/providers/user_provider.dart';
import 'package:penilaian/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:penilaian/pages/webview_page.dart';

class LoginPage extends StatefulWidget {
  // const LoginPage({Key? key}) : super(key: key);
  final bool isState;

  LoginPage({this.isState});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  bool isLoading = false;
  bool isClick1 = false;

  launchURL(String url) async {
    String url1 = url;
    if (await canLaunch(url1)) {
      await launch(url1, forceSafariVC: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url1';
    }
  }

  launchURLSecond(String url) async {
    String url1 = url;
    if (await canLaunch(url1)) {
      await launch(url1, forceSafariVC: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url1';
    }
  }

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    void showError(String message) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[900],
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }

    return SafeArea(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: titleTextStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Penilaian Karyawan PT. IFARS',
                  style: subTitleTextStyle,
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Image.asset(
                    'assets/login.png',
                    width: 300,
                    height: 240,
                  ),
                ),
                Visibility(
                  visible: widget.isState == null ? true : false,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            child: TextButton(
                              onPressed: isClick1 == true
                                  ? null
                                  : () async {
                                      setState(() {
                                        isClick1 = true;
                                      });

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WebViewPage(
                                            url:
                                                'http://ifarssolo.ip-dynamic.com:1501',
                                          ),
                                        ),
                                      );
                                    },
                              style: TextButton.styleFrom(
                                backgroundColor: isClick1 == false
                                    ? Color(0xff4141A4)
                                    : Color(0xfff4f2ed),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Akses ke Server',
                                style: buttonTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.isState == false ? true : false,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Username',
                            style: titleTextStyle,
                          ),
                          TextFormField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              fillColor: Color(0xffF1F0F5),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(0xff4141A4),
                                ),
                              ),
                              hintText: 'Masukkan username',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color(0xffB3B5C4),
                              ),
                            ),
                            style: TextStyle(
                              color: Color(0xff4141A4),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: titleTextStyle,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: Color(0xffF1F0F5),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(0xff4141A4),
                                ),
                              ),
                              hintText: 'Masukkan password',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color(0xffB3B5C4),
                              ),
                            ),
                            style: TextStyle(
                              color: Color(0xff4141A4),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xff4141A4),
                                  ),
                                ),
                              )
                            : TextButton(
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();

                                  if (usernameController.text.isEmpty ||
                                      passwordController.text.isEmpty) {
                                    showError('Isi username dan password');
                                  } else {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    UserModel user = await loginProvider.login(
                                      usernameController.text,
                                      passwordController.text,
                                    );

                                    setState(() {
                                      isLoading = false;
                                    });

                                    if (user == null) {
                                      showError(
                                          'Username dan Password tidak ditemukan !');
                                    } else {
                                      userProvider.user = user;

                                      prefs.setString('nip',
                                          userProvider.user.nip.toString());
                                      prefs.setString('ajb',
                                          userProvider.user.ajb.toString());

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomePage(
                                            nip: userProvider.user.nip
                                                .toString(),
                                            ajb: userProvider.user.ajb
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xff4141A4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Login',
                                  style: buttonTextStyle,
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'v 1.0  © 2022',
                            style: copyRightTextStyle,
                          ),
                        ],
                      ),
                      Text(
                        'Kurniawan Ridwan Surohardjo',
                        style: copyRightTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
