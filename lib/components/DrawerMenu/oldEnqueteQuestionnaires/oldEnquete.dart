import 'package:flutter/material.dart';
import 'package:go_survey/components/DrawerMenu/oldEnqueteQuestionnaires/dataOutPut.dart';
import 'package:go_survey/components/DrawerMenu/oldEnqueteQuestionnaires/questionnaire_list.dart';
import 'package:go_survey/components/DrawerMenu/configs/rubriques.dart';
import 'package:go_survey/models/rubriques/rubrique.dart';
import 'package:go_survey/models/rubriques/rubrique_service.dart';

class OldEnquete extends StatefulWidget {
  const OldEnquete({super.key, required this.rubriquesList});
  final List<RubriqueModel> rubriquesList;
  @override
  State<OldEnquete> createState() => _OldEnqueteState();
}

class _OldEnqueteState extends State<OldEnquete> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (widget.rubriquesList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
            child: Text(
          "Aucune donnee a ete trouve",
          textAlign: TextAlign.center,
        )),
      );
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).size.height / 3.5,
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          reverse: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 0, crossAxisCount: 2),
          shrinkWrap: true,
          itemCount: widget.rubriquesList.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DataOutPut(
                            rubriqueId: index,
                          )));
            },
            child: EnqueteWidget(
              img: "assets/img/2.png",
              CountQ: widget.rubriquesList[index].questCount ?? 0,
              titre: widget.rubriquesList[index].description ?? '',
            ),
          ),
        ),
      );
    }
  }
}
