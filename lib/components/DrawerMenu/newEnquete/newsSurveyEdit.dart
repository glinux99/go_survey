import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_survey/admin/dashbord.dart';
import 'package:go_survey/components/ReponsesView.dart';
import 'package:go_survey/models/questionnaire.dart';
import 'package:go_survey/models/questionnaires/questionnaire.dart';
import 'package:go_survey/models/questionnaires/questionnaire_service.dart';
import 'package:go_survey/models/reponses/reponse_service.dart';
import 'package:go_survey/models/reponses/reponses.dart';
import 'package:go_survey/models/rubriques/rubrique.dart';
import 'package:go_survey/models/rubriques/rubrique_service.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionnaireEditing extends StatefulWidget {
  final RubriqueModel questionnaires;
  final int? questIndex;
  QuestionnaireEditing(
      {super.key, required this.questionnaires, this.questIndex});
  @override
  State<QuestionnaireEditing> createState() => _QuestionnaireEditingState();
}

class _QuestionnaireEditingState extends State<QuestionnaireEditing> {
  late List<QuestionnaireModel> questionsList;
  var _result;
  late int cle;
  final _questionnaireService = QuestionnaireService();
  final _rubriqueService = RubriqueService();
  late final List<ReponsesModel> reponsesList;
  late final Map<int, String> reponseQuestion;
  var reponseService = ReponseService();
  late TextEditingController _controller;
  late GlobalKey<FormState> _globalKey;
  @override
  void initState() {
    getRubriques();
    _globalKey = GlobalKey();
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
          title: Text("Editer les questionnaires"),
          centerTitle: true,
          actions: [
            // IconButton(
            //   onPressed: () {
            //     _rubriqueService.delete(widget.questIndex! + 1);
            //     print(widget.questIndex! + 1);
            //     print("Rubrique Deleted");
            //   },
            //   icon: Icon(Icons.delete_sharp),
            // ),
          ]),
      body: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(50)),
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
                  itemBuilder: (context, index) => Card(
                        elevation: 10,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: ListTile(
                          leading: Text(
                            (index + 1).toString(),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                    label: Text(questionsList[index]
                                        .question
                                        .toString())),
                                onChanged: (value) {
                                  setState(() {
                                    reponseQuestion.addEntries([
                                      MapEntry(questionsList[index].id!, value)
                                    ]);
                                  });
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          subtitle: Text("Type " +
                              questionsList[index].typeReponse.toString()),
                          trailing: IconButton(
                              onPressed: () async {
                                await _questionnaireService
                                    .deleteQuestion(questionsList[index].id);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Dashboard(
                                              RouteLink: 'newEnquete',
                                            )));
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.green[200],
                                        elevation: 2,
                                        padding: EdgeInsetsGeometry.lerp(
                                            EdgeInsets.all(12),
                                            EdgeInsets.all(12),
                                            1),
                                        content: Container(
                                          height: 50,
                                          child: Text(
                                              "La question a ete supprime avec succes!!!"),
                                        )));
                              },
                              icon: Icon(Icons.delete)),
                        ),
                      ))),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: TextButton(
                style: ButtonStyle(),
                onPressed: () async {
                  reponseQuestion.forEach((key, value) {
                    print(key);
                    if (value.isNotEmpty) {
                      var result =
                          _questionnaireService.getQuestionUpdate(key, value);
                    }
                  });
                  // print(questionsList[0].rubriqueId);
                  print(widget.questIndex! + 1);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Dashboard(
                                RouteLink: 'newEnquete',
                              )));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green[200],
                      elevation: 2,
                      padding: EdgeInsetsGeometry.lerp(
                          EdgeInsets.all(12), EdgeInsets.all(12), 1),
                      content: Container(
                        height: 50,
                        child: Text("Question modifiee(s) avec success!!!"),
                      )));
                },
                child: Text(
                  "Enregistrer",
                  style: TextStyle(fontSize: 20),
                )),
          )
        ],
      ),
    );
  }
}
