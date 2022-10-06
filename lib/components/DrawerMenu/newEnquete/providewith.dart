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
    'Reponse Numerique 2'
  ];
  Map<String, String> valueKey = {"_singleValue": "Reponse textuelle"};
  Map<int, String> valeurSelected = new Map<int, String>();

  int compteur = 0;
  late DynamicList listClass;
  late DynamicList typeQuestion;
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
    typeQuestion = DynamicList(taskItems.list);
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
          });
        },
      );
  Widget build(BuildContext context) {
    return Column(
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
        Container(
          child: Form(
              key: _globalKey,
              child: TextFormField(
                controller: _controller,
                onSaved: (val) {
                  taskItems.AjouterElement(val);
                },
              )),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: ElevatedButton(
            onPressed: () {
              if (_globalKey.currentState!.validate()) {
                _globalKey.currentState!.save();
              }
            },
            child: Text("Ajouter"),
          ),
        ),
        Consumer<ListProvider>(builder: (context, provider, listTile) {
          return Expanded(
              child: ListView.builder(
                  itemCount: listClass.list.length, itemBuilder: buildList));
        })
      ],
    );
  }

  Expanded createSection(context, typeofresponse) {
    return Expanded(
        child: MediaQuery.removePadding(
      context: context,
      child: ListView(
        children: [
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
                        TextField(
                          decoration: InputDecoration(
                              hintText: "Veuillez taper une question ici"),
                        ),
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
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 15),
            height: 50,
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
                    "Ajouter une section",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget buildList(
    BuildContext context,
    int index,
  ) {
    var entryList = valueKey.entries.toList();
    compteur++;
    return Dismissible(
      key: Key(compteur.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        taskItems.SuppElement(index);
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
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Veuillez taper une question ici"),
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
                                Text("oooo"),
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

class selectWidget extends StatelessWidget {
  const selectWidget({
    Key? key,
    required this.valeurSelected,
  }) : super(key: key);

  final Map<int, String> valeurSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: valeurSelected.length + 1,
        itemBuilder: (context, index2) => index2 < valeurSelected.length
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question $index2',
                    style: TextStyle(fontSize: 24),
                  )
                ],
              )
            : ElevatedButton(
                onPressed: () => print(valeurSelected),
                child: Text("get selescted")));
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
