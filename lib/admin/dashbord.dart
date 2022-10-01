// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_survey/components/DrawerMenu/licence.dart';
import 'package:go_survey/components/enquetes_recentes.dart';
import 'package:go_survey/components/headerDashboard.dart';
import 'package:go_survey/components/newsurvey.dart';
import 'package:go_survey/components/rubriques.dart';
import 'package:go_survey/components/titre_btn_plus.dart';

import '../components/DrawerMenu/parametre.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key, required this.RouteLink, this.titre = ""});
  final String RouteLink;
  final String titre;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarContructeur(titre),
      drawer: MenuGauche(),
      body: (RouteLink == "mainDashboard" ||
              RouteLink == "newEnquete" ||
              RouteLink == "oldEnquete")
          ? DashboardBody(
              RouteLink: RouteLink,
            )
          : ParametreMenu(),
    );
  }

  AppBar AppBarContructeur(String titre) {
    return AppBar(
      backgroundColor: Colors.green,
      // elevation: 0,
      // leading: IconButton(
      //     onPressed: () {
      //       Drawer();
      //     },
      //     icon: Icon(Icons.menu_book_rounded)),
      elevation: 0,
      title: Text(titre),
      centerTitle: true,
    );
  }
}
