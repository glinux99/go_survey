import 'package:flutter/material.dart';
import 'package:go_survey/components/DrawerMenu/configs/titre_btn_plus.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:go_survey/models/dynamique_quest.dart';
import 'package:go_survey/providers/list_provider.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:provider/provider.dart';

class QuestionnaireCreate extends StatefulWidget {
  const QuestionnaireCreate({super.key, required this.title});
  final String title;
  @override
  State<QuestionnaireCreate> createState() => _QuestionnaireCreateState();
}

class _QuestionnaireCreateState extends State<QuestionnaireCreate> {
  // bool valueCheckbox = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: ChangeNotifierProvider<ListProvider>(
          create: (context) => ListProvider(),
          child: QuestionCreate(),
        ));
  }
}

class QuestionCreate extends StatefulWidget {
  const QuestionCreate({super.key});

  @override
  State<QuestionCreate> createState() => _QuestionCreateState();
}

class _QuestionCreateState extends State<QuestionCreate> {
  bool valueCheckbox = false;
  late GlobalKey<FormState> _globalKey;
  late TextEditingController _controller;
  GroupController controllerCheckbox = GroupController();
  String _singleValue = "Reponse textuelle";
  String _singleValue2 = "Reponse textuelle";
  List<String> typeReponse = [
    'Reponse textuelle',
    'Reponse Numerique',
    'Modalite [1. Oui, 2. Non]',
    'Choix mutlitples',
    'Autres'
  ];
  Map<int, String> valeurSelected = new Map<int, String>();
  late String _verticalGroupValue = "Reponse textuelle";
  int compteur = 0;
  late DynamicList listClass;
  late DynamicList reponseTypeList;
  var taskItems;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      for (int i = 0; i < 3; i++) {
        valeurSelected.putIfAbsent(i, () => ""); //valeur par defaut
      }
    });
    _globalKey = GlobalKey();
    taskItems = Provider.of<ListProvider>(context, listen: false);
    listClass = DynamicList(taskItems.list);
    reponseTypeList = DynamicList(taskItems.list);
    _controller = TextEditingController();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  Widget checkBoxWidget(
          {required TypeOfReponse typeOfReponse,
          required VoidCallback OnClicked}) =>
      ListTile(
        onTap: OnClicked,
        leading: Checkbox(
            value: typeOfReponse.value, onChanged: (value) => OnClicked()),
        title: Text(
          typeOfReponse.titre,
          style: TextStyle(fontSize: 15),
        ),
      );
  final typeofreponse = [
    TypeOfReponse(titre: "Reponse Textuel"),
    TypeOfReponse(titre: "Reponse Numerique"),
    TypeOfReponse(titre: "Modalite [ 1.Oui, 2.Non ]"),
    TypeOfReponse(titre: "Autres modalite")
  ];
  Widget SimpleCheckbox(TypeOfReponse typeofreponse) => checkBoxWidget(
        typeOfReponse: typeofreponse,
        OnClicked: () {
          setState(() {
            final newvalue = !typeofreponse.value;
            typeofreponse.value = newvalue;
            print(typeofreponse.value);
          });
        },
      );
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  AideCreateQuestionnaire(
                      titre:
                          "Merci d'avoir choisis GoSurvey pour faire vos enquete"),
                  AideCreateQuestionnaire(titre: "odk")
                ],
              )),
          createSection(context, typeofreponse),
          Consumer<ListProvider>(builder: (context, provider, listTile) {
            return Expanded(
                child: ListView.builder(
                    itemCount: listClass.list.length, itemBuilder: buildList));
          })
        ],
      ),
      Positioned(
        top: 200,
        right: 0,
        width: 75,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    if (_globalKey.currentState!.validate()) {
                      _globalKey.currentState!.save();
                    }
                  },
                  icon: Icon(
                    Icons.add_circle,
                    size: 40,
                  ),
                ),
                Icon(
                  Icons.remove_red_eye,
                  size: 40,
                ),
                Icon(
                  Icons.check_circle_rounded,
                  size: 40,
                ),
                Icon(
                  Icons.close_sharp,
                  size: 40,
                )
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Column createSection(context, typeofresponse) {
    return Column(
      children: [
        Expanded(
            child: MediaQuery.removePadding(
          context: context,
          child: Wrap(children: [
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 15),
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    boxShadow: [
                      new BoxShadow(
                          color: Colors.green.withOpacity(.3),
                          offset: new Offset(-10, 5),
                          blurRadius: 20,
                          spreadRadius: 4)
                    ]),
                child: Column(
                  children: [
                    Text(
                      "Creer une question",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Form(
                              key: _globalKey,
                              child: TextFormField(
                                autofocus: false,
                                decoration: InputDecoration(
                                    hintText: "Tapez ici votre questionnaire"),
                                controller: _controller,
                                onSaved: (val) {
                                  taskItems.AjouterElement(val);
                                },
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Type de reponse",
                          ),
                          Column(
                            children: [
                              RadioGroup<String>.builder(
                                groupValue: _verticalGroupValue,
                                onChanged: (value) => setState(() {
                                  _verticalGroupValue = value.toString();
                                }),
                                items: typeReponse,
                                itemBuilder: (item) => RadioButtonBuilder(
                                  item,
                                ),
                              ),
                              // ...typeofresponse.map(SimpleCheckbox).toList(),
                            ],
                          )
                        ],
                      ),
                    ),
                    Text(_verticalGroupValue),
                  ],
                ),
              ),
            ),
          ]),
        )),
      ],
    );
  }

  Widget buildList(
    BuildContext context,
    int index,
  ) {
    int question = index + 1;
    compteur++;
    return Dismissible(
      key: Key(compteur.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        taskItems.SuppElement(index);
        if (index > 0) listClass.list.removeAt(index - 1);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10, top: 15),
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.green[200],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topRight: Radius.circular(30)),
              boxShadow: [
                new BoxShadow(
                    color: Colors.green.withOpacity(.3),
                    offset: new Offset(-10, 5),
                    blurRadius: 20,
                    spreadRadius: 4)
              ]),
          child: Column(
            children: [
              Text(
                "Question \t$question",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          hintText: listClass.list[index].toString()),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: [
                                Text("Type de reponse"),
                              ],
                            )
                          ],
                        ),
                        // ...typeofresponse.map(SimpleCheckbox).toList(),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AideCreateQuestionnaire extends StatelessWidget {
  const AideCreateQuestionnaire({super.key, required this.titre, this.img});
  final String titre;
  final String? img;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        // On prend la 80 % de la taille total de l ecran
        color: Colors.white,
        width: size.width * .8,
        margin: EdgeInsets.only(
          left: 10,
          top: 10 / 4,
          bottom: 10 * 2.5,
        ),
        child: Column(
          children: [
            Image.asset(
              img ?? "assets/img/1.jpg",
              height: 100,
              fit: BoxFit.fitWidth,
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
                child: Expanded(
                  child: Text(
                    titre,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
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

class TypeOfReponse {
  String titre;
  bool value;
  TypeOfReponse({
    required this.titre,
    this.value = false,
  });
}
