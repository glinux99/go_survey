import 'package:flutter/material.dart';
import 'package:go_survey/components/DrawerMenu/oldEnqueteQuestionnaires/reponse_view.dart';
import 'package:go_survey/models/questionnaires/questionnaire.dart';
import 'package:go_survey/models/questionnaires/questionnaire_service.dart';
import 'package:go_survey/models/reponses/reponse_service.dart';
import 'package:go_survey/models/reponses/reponses.dart';
import 'package:go_survey/models/rubriques/rubrique.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadReponseView extends StatefulWidget {
  final RubriqueModel rubriqueName;
  final int? rubriqueId;
  const ReadReponseView(
      {super.key, required this.rubriqueName, this.rubriqueId});

  @override
  State<ReadReponseView> createState() => _ReadReponseViewState();
}

class _ReadReponseViewState extends State<ReadReponseView> {
  late List<QuestionnaireModel> questionsList;
  late List<ReponsesModel> reponsesL;
  final _questionnaireService = QuestionnaireService();
  final _reponseService = ReponseService();
  getRubriques() async {
    var rubriques = await _questionnaireService
        .getQuestionByIdRubrique2(widget.rubriqueId! + 1);
    rubriques.forEach((rub) {
      setState(() {
        var rubriqueModel = QuestionnaireModel();
        rubriqueModel.id = rub['id'];
        rubriqueModel.typeReponse = rub['typeReponse'];
        rubriqueModel.question = rub['question'];
        rubriqueModel.userId = rub['userId'];
        rubriqueModel.rubriqueId = rub['rubriqueId'];
        questionsList.add(rubriqueModel);
      });
    });
    // print(rubriques);
  }

  getReponses() async {
    var rubriques =
        await _reponseService.getReponsesByRubriqueId2(widget.rubriqueId! + 1);
    rubriques.forEach((rub) {
      setState(() {
        var rubriqueModel = ReponsesModel();
        rubriqueModel.id = rub['id'];
        rubriqueModel.reponse = rub['reponse'];
        rubriqueModel.userId = rub['userId'];
        rubriqueModel.rubriqueId = rub['rubriqueId'];
        reponsesL.add(rubriqueModel);
      });

      // print(reponsesL[1].reponse);
    });
    // print(rubriques);
  }

  @override
  void initState() {
    // TODO: implement initState
    questionsList = <QuestionnaireModel>[];
    reponsesL = <ReponsesModel>[];
    getReponses();
    getRubriques();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Debut de l'enquete"),
              centerTitle: true,
            ),
            body: Column(mainAxisSize: MainAxisSize.max, children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(50)),
                    color: Theme.of(context).primaryColor),
                child: Stack(
                  children: [
                    Positioned(
                        top: 20,
                        right: 0,
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50))),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 25, right: 10),
                            child: Text(
                              widget.rubriqueName.description ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          )),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: questionsList.length,
                      reverse: true,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Card(
                            elevation: 10,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: ListTile(
                              leading: Text(
                                (index + 1).toString(),
                              ),
                              title: Text(
                                  questionsList[index].question.toString()),
                              subtitle: Text(
                                  '\n' + reponsesL[index].reponse.toString()),
                            ),
                          ))),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: TextButton(
                    style: ButtonStyle(),
                    onPressed: () async {
                      Navigator.pop(context);
                      print(reponsesL[1].reponse);
                    },
                    child: Text(
                      "Retour",
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ])));
  }
}
