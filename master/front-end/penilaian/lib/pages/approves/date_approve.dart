import 'package:flutter/material.dart';
import 'package:penilaian/models/approves/dateapprove_model.dart';
import 'package:penilaian/pages/approves/user_approve.dart';
import 'package:penilaian/providers/approves/dateapprove_provider.dart';
import 'package:penilaian/theme.dart';
import 'package:provider/provider.dart';

class ListDateApprove extends StatefulWidget {
  // const ListDateApprove({ Key? key }) : super(key: key);
  @override
  _ListDateApproveState createState() => _ListDateApproveState();
}

class _ListDateApproveState extends State<ListDateApprove> {
  @override
  Widget build(BuildContext context) {
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
    );
  }

  Widget header() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'List Date',
              style: titleTextStyle,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Konfirmasi Perubahan Nilai',
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

  Widget listWeek() {
    var approveDayProvider = Provider.of<DateApproveProvider>(context);

    return FutureBuilder<List<DateApproveModel>>(
      future: approveDayProvider.getApproveDays(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: snapshot.data
                .map((approveDate) => InkWell(
                      child: Card(
                        color: Color(0xff0D2137),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Text(
                                approveDate.tgu.toString().substring(8, 10) +
                                    ' / ' +
                                    approveDate.tgu.toString().substring(5, 7) +
                                    ' / ' +
                                    approveDate.tgu.toString().substring(0, 4),
                                style: listWeekTextStyle,
                              ),
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
                            builder: (BuildContext context) => ListUserApprove(
                              /* tgu: getDateApprove.dateApprove.tgu, */
                              tgu: approveDate.tgu.toString(),
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
                Color(0xff0D2137),
              ),
            ),
          ),
        );
      },
    );
  }
}
