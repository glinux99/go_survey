import 'package:flutter/material.dart';
import 'package:go_survey/components/DrawerMenu/oldEnqueteQuestionnaires/questionnaire_list.dart';
import 'package:go_survey/components/rubriques.dart';

class OldEnquete extends StatefulWidget {
  const OldEnquete({super.key});

  @override
  State<OldEnquete> createState() => _OldEnqueteState();
}

class _OldEnqueteState extends State<OldEnquete> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => QuestionnnaireList()));
          },
          child: EnqueteWidget(
            img: "assets/img/1.jpg",
            titre: "Enfant de la rue",
            CountQ: 12,
          ),
        ),
        EnqueteWidget(
          img: "assets/img/1.jpg",
          titre: "Enfant de la rue",
          CountQ: 12,
        ),
        EnqueteWidget(
          img: "assets/img/1.jpg",
          titre: "Enfant de la rue",
          CountQ: 12,
        ),
        EnqueteWidget(
          img: "assets/img/1.jpg",
          titre: "Enfant de la rue",
          CountQ: 12,
        ),
        EnqueteWidget(
          img: "assets/img/1.jpg",
          titre: "Enfant de la rue",
          CountQ: 12,
        ),
        EnqueteWidget(
          img: "assets/img/3.jpg",
          titre: "Enfant de la rue",
          CountQ: 12,
        ),
      ],
    );
  }
}
