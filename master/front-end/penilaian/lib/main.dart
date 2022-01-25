import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penilaian/pages/home.dart';
import 'package:penilaian/pages/list_team.dart';
import 'package:penilaian/pages/list_week.dart';
import 'package:penilaian/pages/login.dart';
import 'package:penilaian/pages/results/result_success.dart';
import 'package:penilaian/providers/approves/confirmapprove_provider.dart';
import 'package:penilaian/providers/approves/historyatasan_provider.dart';
import 'package:penilaian/providers/approves/historybawahan_provider.dart';
import 'package:penilaian/providers/approves/historyperiode_provider.dart';
import 'package:penilaian/providers/approves/statusconfirm_provider.dart';
import 'package:penilaian/providers/approves/userapprove_provider.dart';
import 'package:penilaian/providers/results/hasilkerja_provider.dart';
import 'package:penilaian/providers/results/hasilkerjac_provider.dart';
import 'package:penilaian/providers/login_provider.dart';
import 'package:penilaian/providers/results/sikappost_provider.dart';
import 'package:penilaian/providers/results/statushasilkerja_provider.dart';
import 'package:penilaian/providers/results/statushasilkerjac_provider.dart';
import 'package:penilaian/providers/results/statussikappost_provider.dart';
import 'package:penilaian/providers/team_provider.dart';
import 'package:penilaian/providers/user_provider.dart';
import 'package:penilaian/providers/week_provider.dart';
import 'package:penilaian/providers/approves/dateapprove_provider.dart';
import 'package:penilaian/providers/approves/historydetailperiode_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MyApp() /* MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiTextFormField(),
    ), */
      );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<WeekProvider>(
          create: (context) => WeekProvider(),
        ),
        ChangeNotifierProvider<TeamProvider>(
          create: (context) => TeamProvider(),
        ),
        ChangeNotifierProvider<HasilKerjaProvider>(
          create: (context) => HasilKerjaProvider(),
        ),
        ChangeNotifierProvider<StatusHasilKerjaProvider>(
          create: (context) => StatusHasilKerjaProvider(),
        ),
        ChangeNotifierProvider<HasilKerjaCProvider>(
          create: (context) => HasilKerjaCProvider(),
        ),
        ChangeNotifierProvider<StatusHasilKerjaCProvider>(
          create: (context) => StatusHasilKerjaCProvider(),
        ),
        ChangeNotifierProvider<SikapPostProvider>(
          create: (context) => SikapPostProvider(),
        ),
        ChangeNotifierProvider<StatusSikapPostProvider>(
          create: (context) => StatusSikapPostProvider(),
        ),
        ChangeNotifierProvider<DateApproveProvider>(
          create: (context) => DateApproveProvider(),
        ),
        ChangeNotifierProvider<UserApproveProvider>(
          create: (context) => UserApproveProvider(),
        ),
        ChangeNotifierProvider<ConfirmApproveProvider>(
          create: (context) => ConfirmApproveProvider(),
        ),
        ChangeNotifierProvider<StatusConfirmProvider>(
          create: (context) => StatusConfirmProvider(),
        ),
        ChangeNotifierProvider<HistoryAtasanProvider>(
          create: (context) => HistoryAtasanProvider(),
        ),
        ChangeNotifierProvider<HistoryBawahanProvider>(
          create: (context) => HistoryBawahanProvider(),
        ),
        ChangeNotifierProvider<HistoryPeriodeProvider>(
          create: (context) => HistoryPeriodeProvider(),
        ),
        ChangeNotifierProvider<HistoryDetailPeriodeProvider>(
          create: (context) => HistoryDetailPeriodeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => HomePage(),
          '/list-week': (context) => ListWeekPage(),
          '/list-team': (context) => ListTeamPage(),
          '/save': (context) => ResultSuccessPage(),
        },
      ),
    );
  }
}
