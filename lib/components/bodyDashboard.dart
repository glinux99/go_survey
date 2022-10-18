import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_survey/admin/dashbord.dart';
import 'package:go_survey/components/DrawerMenu/configs/rubriques.dart';
import 'package:go_survey/components/DrawerMenu/oldEnqueteQuestionnaires/enquetes_recentes.dart';
import 'package:go_survey/components/DrawerMenu/configs/titre_btn_plus.dart';
import 'package:go_survey/components/question_reponseView.dart';
import 'package:go_survey/models/rubriques/rubrique.dart';
import 'package:go_survey/models/rubriques/rubrique_service.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key, required this.foundRUb});
  final List<RubriqueModel> foundRUb;
  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  late List<RubriqueModel> rubriquesList;

  final _rubriqueService = RubriqueService();

  @override
  @override
  void initState() {
    getRubriques();
    rubriquesList = <RubriqueModel>[];
    super.initState();
  }

  getRubriques() async {
    var rubriques = await _rubriqueService.getAllRubriques();
    setState(() {
      rubriques.forEach((rub) {
        var rubriqueModel = RubriqueModel();
        rubriqueModel.id = rub['id'];
        rubriqueModel.description = rub['description'];
        rubriqueModel.questCount = rub['questCount'];
        rubriquesList.add(rubriqueModel);
      });
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (rubriquesList.isEmpty == true) {
      return Center(
        child: Text("Aucune donnee"),
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: size.height * .232,
            child: ListView.builder(
                reverse: true,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.foundRUb.length,
                itemBuilder: (BuildContext context, int index) {
                  Random rnd = new Random();
                  int min = 1, max = 10;
                  int file = min + rnd.nextInt(max - min);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionReponseViewView(
                                  questIndex: index,
                                  questionnaires: rubriquesList[index])));
                    },
                    child: EnqueteWidget(
                      img: "assets/img/$file.json",
                      titre: widget.foundRUb[index].description ?? '',
                      CountQ: widget.foundRUb[index].questCount!,
                    ),
                  );
                }),
          ),
          TitreButtonPlus(
            titreBtn: "Voir plus",
            titre: "Questionnaires recentes",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Dashboard(
                            RouteLink: "oldEnquete",
                          )));
            },
          ),
          Column(
            children: [
              EnqueteRecente(
                titre: "Enquete sur les enfants de la rue",
                sousTitre: "Une enquete sur les enfant de la rue est une ",
                RubriqueImg: null,
              ),
              EnqueteRecente(
                titre: "Enquete sur les entreprises de la RDC",
                sousTitre:
                    "Le programme mondial des enquêtes MICS a été élaboré par l'UNICEF dans les ",
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
}
