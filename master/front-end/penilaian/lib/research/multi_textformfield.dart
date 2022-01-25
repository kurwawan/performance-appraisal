import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penilaian/config.dart';

class MultiTextFormField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic TextFormFields',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyForm(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _nameSecondController;

  var baseUrl = Config.url;
  // List<dynamic> dataPoint = List();

  var kdp = [];
  var ket = [];
  Future getSikapByPoint(String idPeriode, String nik) async {
    this.kdp = [];
    this.ket = [];
    try {
      String url = "$baseUrl/penilaian/web/api/get/sikap?idperiode=" +
          idPeriode +
          "&nik=" +
          nik;

      final response = await http.get(url);
      List listPoint = jsonDecode(response.body);

      /* print(response.statusCode);
      print(response.body.toString()); */

      if (response.statusCode == 200) {
        setState(() {
          // dataPoint = listPoint;
          for (var i = 0; i < listPoint.length; i++) {
            this.kdp.add(listPoint[i]['kdp']);
            this.ket.add(listPoint[i]['catat1']);
          }
          // print(ket);
        });
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static List<dynamic> friendsList = [];
  // static List<dynamic> dropDownList = [null];
  /* String valPoint;
  List<dynamic> dataPoint = ['Point 0', 'Point 1', 'Point 2', 'Point 3']; */

  var tempKdp = [];
  var tempKet = [];
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _nameSecondController = TextEditingController();

    getSikapByPoint("21201", "20203566").whenComplete(() {
      // print('kdp : ' + kdp.toList().toString());
      for (var i = 0; i < kdp.length; i++) {
        tempKdp.add(kdp[i].toString() + ' - ' + ket[i].toString());
        // tempKet.add(ket[i].toString());
        // setState(() {});
        // print('temp : ' + kdp[i].toString());
      }
      // print(temp.toString());

      friendsList = tempKdp;
      // friendsList.add(tempKdp);
      print(friendsList);

      // dropDownList = tempKet;
      // print(friendsList.toString());
      // print(dropDownList.toString());
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameSecondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Dynamic TextFormFields'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Add Friends',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                ..._getFriends(),
                SizedBox(
                  height: 40,
                ),
                FlatButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      print(friendsList);
                      // print(dropDownList);
                    }
                  },
                  child: Text('Submit'),
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// get firends text-fields
  List<Widget> _getFriends() {
    List<Widget> friendsTextFields = [];
    // List<Widget> dropDownItems = [];
    for (int i = 0; i < friendsList.length; i++) {
      if (i == 7) {
        friendsTextFields.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: FriendTextFields(i),
              ),
              SizedBox(
                width: 16,
              ),
              // we need add button at last friends row
              // _addRemoveButton(i == friendsList.length - 1, i),
            ],
          ),
        ));
      } else {
        friendsTextFields.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              // DropDownItems(i),
              FriendTextFields(i),
              /* SizedBox(
                width: 16,
              ), */
              // we need add button at last friends row
              _addRemoveButton(i == friendsList.length - 1, i),
            ],
          ),
        ));
      }
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          friendsList.insert(0, null);
          // dropDownList.insert(0, null);
          /* for (var i = 0; i < kdp.length; i++) {
            friendsList.insert(i, kdp[i]);
          } */
        } else {
          friendsList.removeAt(index);
          // dropDownList.removeAt(index);
        }
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

class FriendTextFields extends StatefulWidget {
  final int index;
  FriendTextFields(this.index);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  TextEditingController _nameController;
  TextEditingController _nameSecondController;
  // TextEditingController _nameSecondController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _nameSecondController = TextEditingController();
    // _nameSecondController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameSecondController.dispose();
    // _nameSecondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text =
          _MyFormState.friendsList[widget.index].toString().substring(7) ?? '';
      _nameSecondController.text =
          _MyFormState.friendsList[widget.index].toString().substring(0, 4) ??
              '';
      /* _nameSecondController.text =
          _MyFormState.dropDownList[widget.index] ?? ''; */

      // print(_MyFormState.friendsList[widget.index].toString().substring(0, 4));
      // print(_MyFormState.friendsList[widget.index].toString().substring(7));
      // valPoint = _MyFormState.dropDownList[widget.index] ?? '';
    });
    String a =
        _MyFormState.friendsList[widget.index].toString().substring(0, 4);
    return Row(
      children: [
        Container(
          width: 90,
          child: TextFormField(
            controller: _nameSecondController,
            onChanged: (v) {
              /*  String tempResult = _MyFormState.friendsList[widget.index]
                  .toString()
                  .substring(0, 4); */
              a = v;
            },
            decoration: InputDecoration(hintText: 'Enter your friend\'s name'),
            validator: (v) {
              if (v.trim().isEmpty) return 'Please enter something';
              return null;
            },
          ),
        ),
        Container(
          width: 90,
          child: TextFormField(
            controller: _nameController,
            onChanged: (v) => _MyFormState.friendsList[widget.index] = v,
            decoration: InputDecoration(hintText: 'Enter your friend\'s name'),
            validator: (v) {
              if (v.trim().isEmpty) return 'Please enter something';
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class DropDownItems extends StatefulWidget {
  final int index;
  DropDownItems(this.index);
  @override
  _DropDownItemsState createState() => _DropDownItemsState();
}

class _DropDownItemsState extends State<DropDownItems> {
  // TextEditingController _nameController;

  String valPoint;
  List<dynamic> dataPoint = ['Point 0', 'Point 1', 'Point 2', 'Point 3'];

  /* @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // print(dataPoint);
      // dataPoint[widget.index] = _MyFormState.dropDownList[widget.index] ?? '';
    });

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.grey,
        ),
        iconSize: 28,
        underline: SizedBox(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        value: valPoint,
        items: dataPoint.map((item) {
          return DropdownMenuItem(
            child: Text(item),
            value: item,
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            valPoint = value;
          });
        },
      ),
    );
  }
}
