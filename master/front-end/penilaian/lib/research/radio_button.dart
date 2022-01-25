import 'package:flutter/material.dart';

class MyChoice {
  String choice;
  int index;
  MyChoice({
    this.index,
    this.choice,
  });
}

class RadioButton extends StatefulWidget {
  // const RadioButton({ Key? key }) : super(key: key);

  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  /* String defaultChoice;
  int defaultIndex; */

  String radioButtonItem /*  = 'ONE' */;
  int id /*  = 1 */;

  /* List<MyChoice> choices = [
    MyChoice(index: 0, choice: "A1"),
    MyChoice(index: 1, choice: "A2"),
    MyChoice(index: 2, choice: "A3"),
    MyChoice(index: 3, choice: "A4"),
    MyChoice(index: 4, choice: "C4"),
  ]; */

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            /* Wrap(
              children: [
                Container(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.black,
                      // disabledColor: Colors.red,
                    ),
                    child: Column(
                      children: choices
                          .map((data) => RadioListTile(
                              title: Text('${data.choice}'),
                              value: data.index,
                              activeColor: Color(0xff4141A4),
                              groupValue: defaultIndex,
                              onChanged: (value) {
                                setState(() {
                                  defaultChoice = data.choice;
                                  defaultIndex = data.index;
                                });
                              }))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ), */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 1,
                  groupValue: id,
                  activeColor: Color(0xff4141A4),
                  onChanged: (value) {
                    setState(() {
                      radioButtonItem = "A1";
                      id = 1;
                    });
                  },
                ),
                Text('A1'),
                SizedBox(
                  width: 6,
                ),
                Radio(
                  value: 2,
                  groupValue: id,
                  activeColor: Color(0xff4141A4),
                  onChanged: (value) {
                    setState(() {
                      radioButtonItem = "A2";
                      id = 2;
                    });
                  },
                ),
                Text('A2'),
                SizedBox(
                  width: 6,
                ),
                Radio(
                  value: 3,
                  groupValue: id,
                  activeColor: Color(0xff4141A4),
                  onChanged: (value) {
                    setState(() {
                      radioButtonItem = "A3";
                      id = 3;
                    });
                  },
                ),
                Text('A3'),
                SizedBox(
                  width: 6,
                ),
                Radio(
                  value: 4,
                  groupValue: id,
                  activeColor: Color(0xff4141A4),
                  onChanged: (value) {
                    setState(() {
                      radioButtonItem = "A4";
                      id = 4;
                    });
                  },
                ),
                Text('A4'),
                SizedBox(
                  width: 6,
                ),
                Radio(
                  value: 5,
                  groupValue: id,
                  activeColor: Color(0xff4141A4),
                  onChanged: (value) {
                    setState(() {
                      radioButtonItem = "C4";
                      id = 5;
                    });
                  },
                ),
                Text('C4'),
                SizedBox(
                  width: 6,
                ),
              ],
            ),
            Text(
              radioButtonItem.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
