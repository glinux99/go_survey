// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_survey/components/DrawerMenu/headerDashboard.dart';
import 'package:go_survey/components/colors/colors.dart';
import '../components/DrawerMenu/params/parametre.dart';

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
      // backgroundColor: Colors.green,
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
