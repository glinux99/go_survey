import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_survey/components/DrawerMenu/newEnquete/newsSurveyEdit.dart';
import 'package:go_survey/components/question_reponseView.dart';
import 'package:go_survey/models/questionnaires/questionnaire.dart';
import 'package:go_survey/models/questionnaires/questionnaire_service.dart';
import 'package:go_survey/models/reponses/reponses.dart';
import 'package:go_survey/models/rubriques/rubrique.dart';
import 'package:go_survey/models/rubriques/rubrique_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionnaireSaveView extends StatefulWidget {
  const QuestionnaireSaveView({super.key});

  @override
  State<QuestionnaireSaveView> createState() => _QuestionnaireSaveViewState();
}

class _QuestionnaireSaveViewState extends State<QuestionnaireSaveView> {
  RubriqueModel rubrique = RubriqueModel();
  final _rubriqueService = RubriqueService();
  final _questionnaireService = QuestionnaireService();
  var rubriqueId;
  late final List<QuestionnaireModel> questionsList;
  getRubrique() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      rubriqueId = prefs.getInt('rubriqueCurrentId');
    });
    var result = await _rubriqueService.getRubriqueById(rubriqueId);
    result.forEach((e) {
      rubrique.id = e['id'];
      rubrique.description = e['description'];
      rubrique.userId = e['userId'];
      rubrique.questCount = e['questCount'];
    });
    print(rubrique.description);
  }

  getQuestions() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      rubriqueId = prefs.getInt('rubriqueCurrentId');
    });
    var rubriques =
        await _questionnaireService.getQuestionByIdRubrique(rubriqueId);
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
    print('ssss');
  }

  @override
  void initState() {
    // TODO: implement initState
    questionsList = [];
    getRubrique();
    getQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Les questionnaires"),
        centerTitle: true,
      ),
      body: Column(
        children: [
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
                              Text(questionsList[index].question.toString()),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          subtitle: Text("Type " +
                              questionsList[index].typeReponse.toString()),
                        ),
                      ))),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    style: ButtonStyle(),
                    onPressed: () async {
                      HapticFeedback.mediumImpact();
                      HapticFeedback.vibrate();
                      print(rubriqueId);
                      print(rubrique.description);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionnaireEditing(
                                  questIndex: rubriqueId - 1,
                                  questionnaires: rubrique)));
                    },
                    child: Text(
                      "Modifier",
                      style: TextStyle(fontSize: 20),
                    )),
                TextButton(
                    style: ButtonStyle(),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionReponseViewView(
                                  questIndex: rubriqueId - 1,
                                  questionnaires: rubrique)));
                    },
                    child: Text(
                      "Debuter",
                      style: TextStyle(fontSize: 20),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
