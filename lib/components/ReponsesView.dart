import 'package:flutter/material.dart';
import 'package:go_survey/admin/dashbord.dart';
import 'package:go_survey/components/question_reponseView.dart';
import 'package:go_survey/models/questionnaires/questionnaire.dart';
import 'package:go_survey/models/questionnaires/questionnaire_service.dart';
import 'package:go_survey/models/reponses/reponse_service.dart';
import 'package:go_survey/models/reponses/reponses.dart';
import 'package:go_survey/models/rubriques/rubrique.dart';
import 'package:go_survey/models/rubriques/rubrique_service.dart';
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
  RubriqueModel rubrique = RubriqueModel();
  final _rubriqueService = RubriqueService();
  var rubriqueId;
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

  getRubrique() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      rubriqueId = prefs.getInt('rubriqueCurrentId');
    });
    var result = await _rubriqueService.getRubriqueById(widget.rubriqueId! + 1);
    result.forEach((e) {
      rubrique.id = e['id'];
      rubrique.description = e['description'];
      rubrique.userId = e['userId'];
      rubrique.questCount = e['questCount'];
    });
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
    getRubrique();
    getRubriques();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Enquete en cours"),
              centerTitle: true,
            ),
            body: Column(mainAxisSize: MainAxisSize.max, children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50)),
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
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          )),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: questionsList.length,
                      reverse: true,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Card(
                            elevation: 10,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: ListTile(
                              leading: Text(
                                (questionsList.length - index).toString(),
                              ),
                              title: Text(
                                  questionsList[index].question.toString()),
                              subtitle: Text('\n${reponsesL[index].reponse}'),
                            ),
                          ))),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        style: const ButtonStyle(),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Dashboard(
                                        RouteLink: "mainDashboard",
                                      )));
                        },
                        child: const Text(
                          "Fermer",
                          style: TextStyle(fontSize: 20),
                        )),
                    TextButton(
                        style: const ButtonStyle(),
                        onPressed: () async {
                          // print(rubrique.description);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuestionReponseViewView(
                                      questIndex: widget.rubriqueId,
                                      questionnaires: rubrique)));
                        },
                        child: const Text(
                          "Suivant",
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                ),
              )
            ])));
  }
}
