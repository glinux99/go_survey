import 'package:flutter/material.dart';
import 'package:go_survey/components/DrawerMenu/oldEnqueteQuestionnaires/enquetes_recentes.dart';
import 'package:go_survey/components/DrawerMenu/configs/rubriques.dart';
import 'package:go_survey/components/DrawerMenu/configs/titre_btn_plus.dart';

class NewEnquete extends StatelessWidget {
  const NewEnquete({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            RubriqueCreateWidget(),
            EnqueteWidget(
              img: "assets/img/2.png",
              titre: "Enfant de la rue",
              CountQ: 12,
            ),
            EnqueteWidget(
              img: "assets/img/2.png",
              titre: "Enfant de la rue",
              CountQ: 12,
            ),
          ],
        )
      ],
    );
  }
}
