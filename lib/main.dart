import 'package:first_app/pages/daily.dart';
import 'package:first_app/games/moderategame.dart';
import 'package:first_app/intros/veryeasymoderateintro.dart';
import 'package:first_app/games/hardgame.dart';
import 'package:first_app/intros/hardintro.dart';
import 'package:first_app/pages/graphvalue.dart';
import 'package:first_app/pages/home.dart';
import 'package:first_app/pages/result.dart';
import 'package:first_app/intros/easyintro.dart';
import 'package:first_app/games/veryeasygame.dart';
import 'package:first_app/games/easygame.dart';
import 'package:first_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:first_app/pages/graph.dart';
import 'package:first_app/widgets/loadingscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appdir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appdir.path);
  Hive.registerAdapter(GraphvalueAdapter());
  runApp(
    MyApp(), // Wrap your app
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.courgette().fontFamily,
      ),
      routes: {
        // MyRoutes.loginroute: (context) => LoginPage(),
        MyRoutes.homeroute: (context) => FutureBuilder(
            future: Hive.openBox('scores'),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                return HomePage();
              else
                return Scaffold(
                  body: Center(
                    child: Loadingscreen(),
                  ),
                );
            }),
        MyRoutes.moderateroute: (context) => ModeratePage(),
        MyRoutes.easygameroute: (context) => EasygamePage(),
        MyRoutes.veryEasygameroute: (context) => VeryEasygamePage(),
        MyRoutes.hardgameroute: (context) => HardgamePage(),
        MyRoutes.result: (context) => Firstresult(),
        MyRoutes.veryeasymoderateintro: (context) => VeryEasyModerateintro(),
        MyRoutes.easyintro: (context) => Easyintro(),
        MyRoutes.hardintro: (context) => Hardintro(),
        MyRoutes.graph: (context) => GraphPage(),
        MyRoutes.daily: (context) => Daily(),
      },
    );

    //
  }
}
