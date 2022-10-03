import 'package:flutter/material.dart';
import 'package:go_survey/components/enquetes_recentes.dart';
import 'package:go_survey/components/rubriques.dart';
import 'package:go_survey/components/titre_btn_plus.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitreButtonPlus(
          titreBtn: "Voir plus",
          titre: "Nos recentes enquetes",
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              EnqueteWidget(
                img: "assets/img/2.png",
                titre: "Enfant de la rue",
                CountQ: 12,
              ),
              EnqueteWidget(
                img: "assets/img/1.jpg",
                titre: "Enfant de la rue",
                CountQ: 12,
              ),
              EnqueteWidget(
                img: "assets/img/1.jpg",
                titre: "Enfant de la rue",
                CountQ: 12,
              ),
            ],
          ),
        ),
        TitreButtonPlus(
          titreBtn: "Voir plus",
          titre: "Nos questionnaires recentes",
        ),
        Column(
          children: [
            EnqueteRecente(
              titre: "Enque sur les enfants de",
              sousTitre: "Enfant de la rue",
              RubriqueImg: null,
            ),
            EnqueteRecente(
              titre: "Enque sur les enfants de",
              sousTitre: "Enfant de la rue",
              RubriqueImg: null,
            ),
            EnqueteRecente(
              titre: "Enque sur les enfants de",
              sousTitre: "Enfant de la rue",
              RubriqueImg: null,
            ),
            EnqueteRecente(
              titre: "Enque sur les enfants de",
              sousTitre: "Enfant de la rue",
              RubriqueImg: null,
            ),
          ],
        ),
      ],
    );
  }
}
