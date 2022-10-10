import 'package:flutter/material.dart';
import 'package:go_survey/components/DrawerMenu/configs/rubriques.dart';
import 'package:go_survey/components/DrawerMenu/oldEnqueteQuestionnaires/enquetes_recentes.dart';
import 'package:go_survey/components/DrawerMenu/configs/titre_btn_plus.dart';
import 'package:go_survey/models/rubriques/rubrique.dart';
import 'package:go_survey/models/rubriques/rubrique_service.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

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
    } else
      return Column(
        children: [
          SizedBox(
            height: size.height * .232,
            child: ListView.builder(
              reverse: true,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: rubriquesList.length,
              itemBuilder: (BuildContext context, int index) => EnqueteWidget(
                img: "assets/img/2.png",
                titre: rubriquesList[index].description ?? '',
                CountQ: 12,
              ),
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
