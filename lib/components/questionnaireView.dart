import 'package:flutter/material.dart';
import 'package:go_survey/components/colors/colors.dart';

class QuestionnaireView extends StatefulWidget {
  const QuestionnaireView({super.key});

  @override
  State<QuestionnaireView> createState() => _QuestionnaireViewState();
}

class _QuestionnaireViewState extends State<QuestionnaireView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Questionnaire"),
          centerTitle: true,
        ),
        body: QuestionnaireViewBody());
  }
}

class QuestionnaireViewBody extends StatefulWidget {
  const QuestionnaireViewBody({super.key});

  @override
  State<QuestionnaireViewBody> createState() => _QuestionnaireViewBodyState();
}

class _QuestionnaireViewBodyState extends State<QuestionnaireViewBody> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    List<String> question = [
      'Quel est votre nom?',
      'Quel est votre age?',
      'Quel est votre genre svp',
      'Que faites vous'
    ];
    return Scaffold(
      // backgroundColor: kprimary,
      body: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
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
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50))),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 25, right: 10),
                        child: Text(
                          "Name rubrique ",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                    ))
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: question.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(question.toString()),
                      // onDismissed: ((direction) {
                      //   setState(() {
                      //     question.removeAt(index);
                      //   });
                      // }),
                      child: Column(
                        children: [
                          SizedBox(
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
                                              BorderRadius.circular(0.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.green,
                                                offset: Offset(-10, 10),
                                                blurRadius: 20,
                                                spreadRadius: 4)
                                          ]),
                                      child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            minHeight: 40,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(question[index]),
                                          ))),
                                ),
                              )),
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
