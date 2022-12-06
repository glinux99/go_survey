import 'package:flutter/material.dart';
import 'package:go_survey/components/ReponsesView.dart';
import 'package:go_survey/models/questionnaires/questionnaire.dart';
import 'package:go_survey/models/reponses/reponse_service.dart';
import 'package:go_survey/models/reponses/reponses.dart';
import 'package:go_survey/models/rubriques/rubrique.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/questionnaires/questionnaire_service.dart';

class QuestionReponseViewView extends StatefulWidget {
  const QuestionReponseViewView(
      {super.key, required this.questionnaires, this.questIndex});

  final int? questIndex;
  final RubriqueModel questionnaires;

  @override
  State<QuestionReponseViewView> createState() =>
      _QuestionReponseViewViewState();
}

class _QuestionReponseViewViewState extends State<QuestionReponseViewView> {
  late int cle;
  late List<QuestionnaireModel> questionsList;
  late final Map<int, String> reponseQuestion;
  var reponseService = ReponseService();
  late final List<ReponsesModel> reponsesList;

  late TextEditingController _controller;
  final _questionnaireService = QuestionnaireService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    getRubriques();
    reponseQuestion = {};
    cle = 0;
    reponsesList = [];
    _controller = TextEditingController();
    questionsList = <QuestionnaireModel>[];
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
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(50)),
                color: Theme.of(context).colorScheme.secondary),
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
                  itemBuilder: (context, index) => Card(
                        elevation: 10,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: ListTile(
                          leading: Text(
                            (index + 1).toString(),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(questionsList[index].question.toString()),
                              if (questionsList[index].typeReponse.toString() ==
                                  "Reponse textuelle")
                                TextField(
                                  textInputAction: TextInputAction.newline,
                                  onChanged: (newValue) {
                                    reponseQuestion.addEntries(
                                        [MapEntry(index, newValue.toString())]);
                                    print(reponseQuestion);
                                  },
                                ),
                              if (questionsList[index].typeReponse.toString() ==
                                  "Reponse Numerique")
                                TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (newValue) {
                                    reponseQuestion.addEntries(
                                        [MapEntry(index, newValue.toString())]);
                                  },
                                ),
                              if (questionsList[index].typeReponse.toString() ==
                                  "Modalite [1. Oui, 2. Non]")
                                Column(
                                  children: [
                                    // Some code
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: RadioButtonField(
                                            const ['1. Oui', '2. Non'],
                                            reponseQuestion,
                                            index)),
                                    // Text(reponseQuestion
                                    //     .toString())
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ))),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: TextButton(
                style: const ButtonStyle(),
                onPressed: () async {
                  var recPref = await SharedPreferences.getInstance();
                  var userId = recPref.getInt('authId');

                  if (questionsList.length == reponseQuestion.length) {
                    setState(() {
                      cle = 0;
                      reponseQuestion.forEach((key, value) async {
                        var reponse = ReponsesModel();
                        reponse.reponse = value;
                        reponse.questionId = questionsList[cle].id;
                        reponse.rubriqueId = widget.questIndex! + 1;
                        cle++;
                        reponse.userId = userId;
                        var result = await reponseService.saveReponses(reponse);
                        print(cle);
                      });
                    });
                    print(questionsList.length);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReadReponseView(
                                  rubriqueName: widget.questionnaires,
                                  rubriqueId: widget.questIndex,
                                )));
                  } else {
                    print(questionsList.length);
                    print(reponseQuestion);
                    print('Error');
                  }
                },
                child: const Text(
                  "Enregistrer",
                  style: TextStyle(fontSize: 20),
                )),
          )
        ],
      ),
    );
  }
}

class RadioButtonField extends StatelessWidget {
// Don't ask me others hahahah ... Go Survey System hahah
  RadioButtonField(this.radioList, this.reponseQuestion, this.index,
      {super.key});

  final int index;
  final List<String> radioList;
  final Map<int, String> reponseQuestion;

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
// class TestPage extends StatefulWidget {
//   const TestPage({Key? key}) : super(key: key);

//   @override
//   _TestPageState createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   // The group value
//   var _result;
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'Kindacode.com',
//         ),
//       ),
//       body: Padding(
//           padding: const EdgeInsets.all(25),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text('1 + 2 + 4 = ?'),
//               RadioListTile(
//                   title: const Text('4'),
//                   value: 4,
//                   groupValue: _result,
//                   onChanged: (value) {
//                     setState(() {
//                       _result = value;
//                     });
//                   }),
//               RadioListTile(
//                   title: const Text('5.4'),
//                   value: 5.4,
//                   groupValue: _result,
//                   onChanged: (value) {
//                     setState(() {
//                       _result = value;
//                     });
//                   }),
//               RadioListTile(
//                   title: const Text('6'),
//                   value: 6,
//                   groupValue: _result,
//                   onChanged: (value) {
//                     setState(() {
//                       _result = value;
//                     });
//                   }),
//               RadioListTile(
//                   title: const Text('7'),
//                   value: 7,
//                   groupValue: _result,
//                   onChanged: (value) {
//                     setState(() {
//                       _result = value;
//                     });
//                   }),
//               const SizedBox(height: 25),
//               Text(_result == 7 ? 'Correct!' : 'Please chose the right answer!')
//             ],
//           )),
//     );
//   }
// }
