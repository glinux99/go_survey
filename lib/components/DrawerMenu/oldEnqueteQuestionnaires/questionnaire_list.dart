import 'package:flutter/material.dart';
import 'package:go_survey/components/DrawerMenu/oldEnqueteQuestionnaires/enquetes_recentes.dart';
import 'package:go_survey/components/question_reponseView.dart';
import 'package:go_survey/components/questionnaireView.dart';

class QuestionnnaireList extends StatefulWidget {
  const QuestionnnaireList({super.key});

  @override
  State<QuestionnnaireList> createState() => _QuestionnnaireListState();
}

class _QuestionnnaireListState extends State<QuestionnnaireList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Questionnaires")),
      body: Questionnaires(),
    );
  }
}

class Questionnaires extends StatefulWidget {
  const Questionnaires({super.key});

  @override
  State<Questionnaires> createState() => _QuestionnairesState();
}

class _QuestionnairesState extends State<Questionnaires> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // a utiliser
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ReponseView()));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuestionReponseViewView()));
            },
            child: EnqueteRecente(
                titre: "Enquete sur les enfants malades",
                sousTitre: "Questionnaires",
                RubriqueImg: null),
          ),
          EnqueteRecente(
              titre: "Enquete sur les enfants malades",
              sousTitre: "Questionnaires",
              RubriqueImg: null),
          EnqueteRecente(
              titre: "Enquete sur les enfants malades",
              sousTitre: "Questionnaires",
              RubriqueImg: null),
          EnqueteRecente(
              titre: "Enquete sur les enfants malades",
              sousTitre: "Questionnaires",
              RubriqueImg: null),
          EnqueteRecente(
              titre: "Enquete sur les enfants malades",
              sousTitre: "Questionnaires",
              RubriqueImg: null),
          EnqueteRecente(
              titre: "Enquete sur les enfants malades",
              sousTitre: "Questionnaires",
              RubriqueImg: null),
          EnqueteRecente(
              titre: "Enquete sur les enfants malades",
              sousTitre: "Questionnaires",
              RubriqueImg: null),
          EnqueteRecente(
              titre: "Enquete sur les enfants malades",
              sousTitre: "Questionnaires",
              RubriqueImg: null),
          EnqueteRecente(
              titre: "Enquete sur les enfants malades",
              sousTitre: "Questionnaires",
              RubriqueImg: null),
          EnqueteRecente(
              titre: "Enquete sur les enfants malades",
              sousTitre: "Questionnaires",
              RubriqueImg: null),
          EnqueteRecente(
              titre: "Enquete sur les enfants malades",
              sousTitre: "Questionnaires",
              RubriqueImg: null),
        ],
      ),
    );
  }
}
