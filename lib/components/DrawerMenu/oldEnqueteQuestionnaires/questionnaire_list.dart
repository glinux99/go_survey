import 'package:flutter/material.dart';
import 'package:go_survey/components/DrawerMenu/oldEnqueteQuestionnaires/reponse_view.dart';
import 'package:go_survey/components/enquetes_recentes.dart';

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReponseView()));
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
