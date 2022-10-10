import 'package:flutter/material.dart';
import 'package:go_survey/components/colors/colors.dart';
import 'package:go_survey/models/questionnaires/questionnaire.dart';
import 'package:go_survey/models/rubriques/rubrique.dart';

import '../models/questionnaires/questionnaire_service.dart';

class QuestionReponseViewView extends StatefulWidget {
  final RubriqueModel questionnaires;
  final int? questIndex;
  QuestionReponseViewView(
      {super.key, required this.questionnaires, this.questIndex});
  @override
  State<QuestionReponseViewView> createState() =>
      _QuestionReponseViewViewState();
}

class _QuestionReponseViewViewState extends State<QuestionReponseViewView> {
  late List<QuestionnaireModel> questionsList;

  final _questionnaireService = QuestionnaireService();

  @override
  @override
  void initState() {
    getRubriques();
    questionsList = <QuestionnaireModel>[];
    super.initState();
  }

  getRubriques() async {
    var recensement = QuestionnaireModel();
    var rubriques = await _questionnaireService.getQuestionByIdRubrique(
        recensement, widget.questIndex);
    print(rubriques);
    setState(() {
      rubriques.forEach((rub) {
        var rubriqueModel = QuestionnaireModel();
        rubriqueModel.id = rub['id'];
        rubriqueModel.typeReponse = rub['typeReponse'];
        rubriqueModel.question = rub['question'];
        rubriqueModel.userId = rub['userId'];
        rubriqueModel.rubriqueId = rub['rubriqueId'];
        questionsList.add(rubriqueModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    List<String> question = [
      'Quel est votre nom?',
      'Quel est votre age?',
      'Quel est votre genre svp',
      'Que faites vous',
      'Etes vous malade',
      'Avex vous un enfant de moijns de 13ans?',
      'Croyexz vous en une puissanc3 superieure?',
      'Savez vous qu il existe une force qui depasse tout ce dont nous savons',
      'Avez vous deja eu peur un jour jus qu a crever dans votre froc?'
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Debut de l'enquete"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(50)),
                color: Colors.green),
            child: Stack(
              children: [
                Positioned(
                    top: 20,
                    right: 0,
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50))),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 25, right: 10),
                        child: Text(
                          widget.questionnaires.description ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(questionsList[index].question.toString()),
                      // onDismissed: ((direction) {
                      //   setState(() {
                      //     question.removeAt(index);
                      //   });
                      // }),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.green[300],
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.green,
                                                offset: Offset(-10, 10),
                                                blurRadius: 20,
                                                spreadRadius: 4)
                                          ]),
                                      child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            minHeight: 40,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              children: [
                                                Text(question[index]),
                                                TextFormField()
                                              ],
                                            ),
                                          ))),
                                ),
                              )),
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
