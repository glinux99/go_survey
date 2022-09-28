// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_survey/components/enquetes_recentes.dart';
import 'package:go_survey/components/headerDashboard.dart';
import 'package:go_survey/components/newsurvey.dart';
import 'package:go_survey/components/rubriques.dart';
import 'package:go_survey/components/titre_btn_plus.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key, required this.Route});
  final String Route;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarContructeur(),
      drawer: MenuGauche(),
      body: DashboardBody(
        RouteLink: Route,
      ),
    );
  }

  AppBar AppBarContructeur() {
    return AppBar(
      backgroundColor: Colors.green,
      // elevation: 0,
      // leading: IconButton(
      //     onPressed: () {
      //       Drawer();
      //     },
      //     icon: Icon(Icons.menu_book_rounded)),
      elevation: 0,
    );
  }
}
