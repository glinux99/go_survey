import 'package:flutter/material.dart';
import 'package:go_survey/models/questionnaires/questionnaire.dart';
import 'package:go_survey/models/reponses/reponse_service.dart';
import 'package:go_survey/models/reponses/reponses.dart';
import 'package:go_survey/models/rubriques/rubrique.dart';

import '../models/questionnaires/questionnaire_service.dart';

class QuestionReponseReadView extends StatefulWidget {
  final RubriqueModel questionnaires;
  final int? questIndex;
  const QuestionReponseReadView(
      {super.key, required this.questionnaires, required this.questIndex});
  @override
  State<QuestionReponseReadView> createState() =>
      _QuestionReponseReadViewState();
}

class _QuestionReponseReadViewState extends State<QuestionReponseReadView> {
  late List<QuestionnaireModel> questionsList;
  late List<ReponsesModel> reponsesList;
  final _questionnaireService = QuestionnaireService();
  late final Map<int, String> reponseQuestion;
  var reponseService = ReponseService();
  late final List<String> reponsesView;
  late TextEditingController _controller;
  @override
  void initState() {
    reponseQuestion = {};
    _controller = TextEditingController();
    questionsList = <QuestionnaireModel>[];
    reponsesList = <ReponsesModel>[];
    reponsesView = [];
    getRubriques();
    getReponses();
    super.initState();
  }

  getRubriques() async {
    var rubriques = await _questionnaireService
        .getQuestionByIdRubrique(widget.questIndex! + 1);
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
    // print(rubriques);
  }

  getReponses() async {}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Debut de l'enquete"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(
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
                      decoration: const BoxDecoration(
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
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
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
                          const SizedBox(
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
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.green,
                                                offset: Offset(-10, 10),
                                                blurRadius: 20,
                                                spreadRadius: 4)
                                          ]),
                                      child: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                            minHeight: 40,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              children: [
                                                Text(questionsList[index]
                                                    .question
                                                    .toString()),
                                                Text(reponsesView.toString())
                                              ],
                                            ),
                                          ))),
                                ),
                              )),
                        ],
                      ),
                    );
                  })),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: TextButton(
                style: ButtonStyle(),
                onPressed: () async {
                  print(reponsesList[0].reponse);
                },
                child: Text(
                  "Retour",
                  style: TextStyle(fontSize: 20),
                )),
          )
        ],
      ),
    );
  }
}

class RadioButtonField extends StatelessWidget {
  final List<String> radioList;
  final Map<int, String> reponseQuestion;
  final int index;
// Don't ask me others hahahah ... Go Survey System hahah
  const RadioButtonField(this.radioList, this.reponseQuestion, this.index,
      {super.key});

  @override
  Widget build(BuildContext context) {
    String? select;
    select = "";
    Map<int, String> mapRadioButtonField = radioList.asMap();

    return StatefulBuilder(
      builder: (_, StateSetter setState) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...mapRadioButtonField.entries.map(
            (MapEntry<int, String> mapEntry) => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                      activeColor: Theme.of(context).primaryColor,
                      groupValue: select,
                      toggleable: true,
                      value: radioList[mapEntry.key],
                      onChanged: (value) {
                        setState(() {
                          select = value as String?;
                          reponseQuestion
                              .addEntries([MapEntry(index, value.toString())]);
                        });
                        print(select);
                      }
                      // setState(() => select = value as String?),

                      ),
                  Text(mapEntry.value)
                ]),
          ),
        ],
      ),
    );
  }
}
