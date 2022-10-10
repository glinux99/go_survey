import 'package:flutter/material.dart';
import 'package:go_survey/components/DrawerMenu/oldEnqueteQuestionnaires/questionnaire_list.dart';
import 'package:go_survey/components/DrawerMenu/configs/rubriques.dart';
import 'package:go_survey/models/rubriques/rubrique.dart';
import 'package:go_survey/models/rubriques/rubrique_service.dart';

class OldEnquete extends StatefulWidget {
  const OldEnquete({super.key});

  @override
  State<OldEnquete> createState() => _OldEnqueteState();
}

class _OldEnqueteState extends State<OldEnquete> {
  late List<RubriqueModel> rubriquesList;

  final _rubriqueService = RubriqueService();
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: SizedBox(
            height: size.height - size.height / 3,
            width: double.infinity,
            child: Expanded(
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                reverse: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 0, crossAxisCount: 2),
                shrinkWrap: true,
                itemCount: rubriquesList.length,
                itemBuilder: (BuildContext context, int index) => EnqueteWidget(
                  img: "assets/img/2.png",
                  titre: rubriquesList[index].description ?? '',
                  CountQ: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
