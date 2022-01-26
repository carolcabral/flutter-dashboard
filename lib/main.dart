import 'package:app/controllers/mqtt_controller.dart';
import 'package:app/screens/mqtt_screen.dart';

import 'controllers/MenuController.dart';
import 'screens/control/control_screen.dart';
import 'screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (context) => MQTTController(),//MenuController(),
        ),
      ], child: const ControlScreen() //MainScreen(),
          ),
    );
  }
}
