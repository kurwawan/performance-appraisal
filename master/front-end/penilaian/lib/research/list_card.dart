import 'package:flutter/material.dart';
import 'package:penilaian/theme.dart';

class Data {
  Map fetch_data = {
    "data": [
      {"id": 111, "name": "abcasdasdads"},
      {"id": 222, "name": "pqr"},
      {"id": 333, "name": "abc"},
      {"id": 111, "name": "abcasdasdads"},
      {"id": 111, "name": "abcasdasdads"},
      {"id": 111, "name": "abcasdasdads"},
      {"id": 111, "name": "abcasdasdads"},
      {"id": 111, "name": "abcasdasdads"},
      {"id": 111, "name": "abcasdasdads"},
      {"id": 111, "name": "abcasdasdads"},
      {"id": 111, "name": "abcasdasdads"},
      {"id": 111, "name": "abcasdasdads"},
      {"id": 111, "name": "abcasdasdads"},
      {"id": 111, "name": "abcasdasdads"}
    ]
  };
  List _data;

  Data() {
    _data = fetch_data["data"];
  }

  int getId(int index) {
    return _data[index]["id"];
  }

  String getName(int index) {
    return _data[index]["name"];
  }

  int getLength() {
    return _data.length;
  }
}

class ListCard extends StatefulWidget {
  // const ListCard({ Key? key }) : super(key: key);
  @override
  _ListCardState createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  Data _data = new Data();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text('AAA'),
              ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: _data.getLength(),
                itemBuilder: _itemBuilder,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return InkWell(
      child: Card(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 25,
              ),
              child: Icon(
                Icons.date_range,
                color: Color(0xff4141A4),
                size: 55,
              ),
            ),
            Text(
              _data.getName(index),
              style: listWeekTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Color(0xff4141A4),
                size: 55,
              ),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
