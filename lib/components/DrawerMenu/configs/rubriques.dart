import 'package:flutter/material.dart';
import 'package:go_survey/components/DrawerMenu/headerDashboard.dart';
import 'package:go_survey/components/DrawerMenu/newEnquete/questionnaires_creates.dart';
import 'package:go_survey/models/modalites/modalite_service.dart';
import 'package:go_survey/models/rubriques/rubrique_service.dart';

class EnqueteWidget extends StatefulWidget {
  const EnqueteWidget({
    super.key,
    required this.img,
    required this.CountQ,
    required this.titre,
  });
  final String img, titre;
  final int? CountQ;
  @override
  State<EnqueteWidget> createState() => _EnqueteWidgetState();
}

class _EnqueteWidgetState extends State<EnqueteWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraint) => Container(
        // On prend la 40 % de la taille total de l ecran
        width: size.width * .4,
        margin: EdgeInsets.only(
          left: 10,
          top: 10 / 4,
          bottom: 10 * 2.5,
        ),

        child: Column(
          children: [
            Image.asset(
              widget.img,
              height: 100,
              fit: BoxFit.fill,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(15 / 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Colors.green.withOpacity(.23),
                      )
                    ]),
                child: Flexible(
                  child: Wrap(
                    children: [
                      Text(
                        '${widget.titre}\n',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            maxLines: 1,
                            "Questions",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            widget.CountQ.toString(),
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RubriqueCreateWidget extends StatelessWidget {
  const RubriqueCreateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var _alertController = TextEditingController();
    var _recensementService = RubriqueService();
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green, width: 2)),
      // On prend la 40 % de la taille total de l ecran
      width: size.width * .4,
      margin: EdgeInsets.only(
        left: 10,
        top: 10 / 4,
        bottom: 10 * 2.5,
      ),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                // return AlertGoSUrvey(
                //   titre: "Creer une ribrique",
                //   hintText: "Entrer le nom de votre rubrique",
                //   validation: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => QuestionnaireCreate(
                //                   title: "Creation du questionnaire",
                //                 )));
                //   },
                // );
                return AlertGoSurvey(
                    titre: "Creer une enquete",
                    hinText: "Tapez le nom de votre enquete",
                    prefId: "rubriqueCurrentId",
                    routeLink: "newRubrique",
                    alertController: _alertController,
                    recensementService: _recensementService);
              });
        },
        child: Column(
          children: [
            Container(
              height: 100,
              child: Icon(
                Icons.add,
                size: 50,
              ),
            ),
            Container(
              padding: EdgeInsets.all(15 / 2),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: Colors.green.withOpacity(.23),
                )
              ]),
              child: Flexible(
                child: Wrap(
                  children: [
                    Text(
                      "Creer une rubrique",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          maxLines: 2,
                          "\nQuestions",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "\n0",
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future modalCreate(context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Create rubirque"),
            content: TextField(
              decoration: InputDecoration(hintText: "Votre texte"),
            ),
            actions: [TextButton(onPressed: () {}, child: Text("Envoyer"))],
          ));
}

class AlertGoSUrvey extends StatelessWidget {
  AlertGoSUrvey(
      {super.key,
      required this.titre,
      required this.hintText,
      required this.validation,
      this.onChanged,
      this.output});
  final String titre;
  final String hintText;
  final Function validation;
  final Function? onChanged;
  late final String? output;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 100,
          height: 200,
          child: OverflowBox(
            maxWidth: 400,
            minHeight: 10,
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  height: 50,
                  child: TextButton(
                    child: Text(titre, style: TextStyle(color: Colors.white)),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: 250,
                  child: Column(
                    children: [
                      TextField(
                        autofocus: true,
                        onTap: () {},
                        onChanged: onChanged!(),
                        decoration: InputDecoration(hintText: hintText),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () => validation.call(),
                  child: Text("Valider"),
                  style: TextButton.styleFrom(
                      side: BorderSide(width: 1, color: Colors.grey),
                      minimumSize: Size(145, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: Colors.white,
                      backgroundColor: Colors.green),
                ),
              ],
            ),
          ),
        ));
  }
}
