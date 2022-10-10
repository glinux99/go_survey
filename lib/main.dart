import 'package:flutter/material.dart';
import 'package:go_survey/admin/dashbord.dart';
import 'package:go_survey/auth/login.dart';
import 'package:go_survey/components/screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool show = true, logPref = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  logPref = prefs.getBool('login') ?? false;
  show = prefs.getBool("go_survey") ?? true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // theme: ThemeData.light(),
      home: show
          ? AcceuilScreen()
          : logPref
              ? Dashboard(
                  RouteLink: "mainDashboard",
                )
              : const LoginSignup(),
    );
  }
}
