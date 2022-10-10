import 'package:flutter/material.dart';
import 'package:go_survey/components/DrawerMenu/oldEnqueteQuestionnaires/enquetes_recentes.dart';
import 'package:go_survey/components/DrawerMenu/configs/rubriques.dart';
import 'package:go_survey/components/DrawerMenu/configs/titre_btn_plus.dart';
import 'package:go_survey/components/question_reponseView.dart';
import 'package:go_survey/models/rubriques/rubrique.dart';
import 'package:go_survey/models/rubriques/rubrique_service.dart';

class NewEnquete extends StatefulWidget {
  const NewEnquete({
    Key? key,
  }) : super(key: key);

  @override
  State<NewEnquete> createState() => _NewEnqueteState();
}

class _NewEnqueteState extends State<NewEnquete> {
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
        if (rubriquesList.isEmpty == true)
          Center(
              child: Column(
            children: [
              Text("Aucune enquete recente effectuee"),
              RubriqueCreateWidget()
            ],
          ))
        else
          Wrap(
            children: [
              SizedBox(
                height: size.height - size.height / 3,
                width: double.infinity,
                child: Expanded(
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      reverse: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 0, crossAxisCount: 2),
                      shrinkWrap: true,
                      itemCount: rubriquesList.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) return RubriqueCreateWidget();
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        QuestionReponseViewView(
                                            questIndex: index - 1,
                                            questionnaires:
                                                rubriquesList[index - 1])));
                          },
                          child: EnqueteWidget(
                            img: "assets/img/2.png",
                            titre: rubriquesList[index - 1].description ?? '',
                            CountQ: 12,
                          ),
                        );
                      }),
                ),
              ),
            ],
          )
      ],
    );
  }
}
