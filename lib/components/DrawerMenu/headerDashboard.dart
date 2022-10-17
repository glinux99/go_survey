// ignore: file_names
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:go_survey/admin/dashbord.dart';
import 'package:go_survey/auth/login.dart';
import 'package:go_survey/components/DrawerMenu/apropos.dart';
import 'package:go_survey/components/DrawerMenu/configs/rubriques.dart';
import 'package:go_survey/components/DrawerMenu/newEnquete/questionnaires_creates.dart';
import 'package:go_survey/components/DrawerMenu/oldEnqueteQuestionnaires/oldEnquete.dart';
import 'package:go_survey/components/DrawerMenu/user/userprofile.dart';
import 'package:go_survey/components/bodyDashboard.dart';
import 'package:go_survey/components/DrawerMenu/newEnquete/newsurvey.dart';
import 'package:go_survey/components/colors/colors.dart';
import 'package:go_survey/models/recensements/recensement_service.dart';
import 'package:go_survey/models/rubriques/rubrique.dart';
import 'package:go_survey/models/rubriques/rubrique_service.dart';
import 'package:go_survey/models/users/user.dart';
import 'package:go_survey/models/users/user_service.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../save.dart';

// Menu drawer
class MenuGauche extends StatefulWidget {
  const MenuGauche({super.key});

  @override
  State<MenuGauche> createState() => _MenuGaucheState();
}

bool iconBinary = false;
IconData _themeLightIcon = Icons.wb_sunny;
IconData _themeDarkIcon = Icons.nights_stay;
ThemeData _themeDark = ThemeData(
  brightness: Brightness.dark,
);
ThemeData _themeLight =
    ThemeData(primarySwatch: Colors.green, brightness: Brightness.light);

class _MenuGaucheState extends State<MenuGauche> {
  bool profilevieuw = false;
  var _alertController = TextEditingController();
  int _currIndex = 1;
  int _currIndex2 = 1;
  var _userService = UserService();
  var _recensementService = RecensementService();
  var user;
  late String userName = 'Daniel';
  late String userPhone = '+243 970912428';
  late List<User> userUnique = [];
  getAuthUser() async {
    final prefs = await SharedPreferences.getInstance();
    var result = await _userService.getUserById(prefs.getInt('authId'));
    userName = prefs.getString('userName') ?? 'Daniel';
    userPhone = prefs.getString('userPhone') ?? '+243 970912428';
    result.forEach((userUnik) {
      setState(() {
        var userModel = User();
        userModel.id = userUnik['id'];
        userModel.name = userUnik['name'];
        userModel.email = userUnik['email'];
        userModel.phone = userUnik['phone'].toString();
        userModel.password = userUnik['password'].toString();
        userUnique.add(userModel);
      });
    });
  }

  @override
  void initState() {
    getAuthUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: kGreen,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        foregroundImage: AssetImage("assets/img/1.jpg"),
                        child: Text(
                          'user',
                        ),
                        radius: 34,
                      ),
                      ThemeSwitcher(
                        builder: (context) {
                          return IconButton(
                            onPressed: () async {
                              var prefs = await SharedPreferences.getInstance();

                              ThemeSwitcher.of(context).changeTheme(
                                theme: ThemeModelInheritedNotifier.of(context)
                                            .theme
                                            .brightness ==
                                        Brightness.light
                                    ? darkBlueTheme
                                    : lightTheme,
                              );
                              setState(() {
                                _currIndex2 = _currIndex2 == 0 ? 1 : 0;
                              });
                            },
                            icon: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 600),
                                transitionBuilder: (child, anim) =>
                                    RotationTransition(
                                      turns: child.key == ValueKey('icon11')
                                          ? Tween<double>(begin: 1, end: 0.5)
                                              .animate(anim)
                                          : Tween<double>(begin: 0.5, end: 1)
                                              .animate(anim),
                                      child: FadeTransition(
                                          opacity: anim, child: child),
                                    ),
                                child: _currIndex2 == 0
                                    ? Icon(Icons.light_mode_rounded,
                                        color: Colors.white,
                                        key: const ValueKey('icon11'))
                                    : Icon(
                                        Icons.dark_mode_rounded,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        key: const ValueKey('icon22'),
                                      )),
                            // const Icon(Icons.brightness_3, size: 25),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      profilevieuw = !profilevieuw;
                      _currIndex = _currIndex == 0 ? 1 : 0;
                    });
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 5),
                            Text(
                              userPhone,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                transitionBuilder: (child, anim) =>
                                    RotationTransition(
                                      turns: child.key == ValueKey('icon1')
                                          ? Tween<double>(begin: 1, end: 0.75)
                                              .animate(anim)
                                          : Tween<double>(begin: 0.75, end: 1)
                                              .animate(anim),
                                      child: FadeTransition(
                                          opacity: anim, child: child),
                                    ),
                                child: _currIndex == 0
                                    ? Icon(Icons.keyboard_arrow_right,
                                        color: Colors.white,
                                        key: const ValueKey('icon1'))
                                    : Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Colors.white,
                                        key: const ValueKey('icon2'),
                                      )),
                            onPressed: () {
                              setState(() {
                                profilevieuw = !profilevieuw;
                                _currIndex = _currIndex == 0 ? 1 : 0;
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (profilevieuw)
            AnimatedPositioned(
              curve: Curves.bounceInOut,
              duration: Duration(seconds: 200),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_outline_rounded),
                    title: const Text('Mon profile'),
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MonProfile(
                                    userUnique: userUnique[0],
                                  )));
                      // print(user[0].name);
                    },
                  ),
                  Divider(),
                ],
              ),
            ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Dashboard(
                            RouteLink: "mainDashboard",
                          )));
            },
          ),
          ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text("Nouvel enquete"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Dashboard(
                              RouteLink: 'newEnquete',
                            )));
              }),
          ListTile(
            leading: Icon(Icons.bar_chart_rounded),
            title: Text("Enquetes recentes"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Dashboard(
                            RouteLink: "oldEnquete",
                          )));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Parametres de l\'application'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Dashboard(
                            RouteLink: "parametreDashboard",
                            titre: "Parametre",
                          )));
            },
          ),
          const Divider(thickness: 1),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Laissez un avis sur PlayStore"),
            onTap: () {
              // show the dialog
              showDialog(
                  context: context,
                  barrierDismissible:
                      true, // set to false if you want to force a rating
                  builder: (context) => RatingDialog(
                        initialRating: 1.0,
                        // your app's name?
                        title: Text(
                          'Evaluation',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        message: Text(
                          'Appuyez sur une étoile pour définir votre évaluation. Ajoutez plus de description ici si vous le souhaitez.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15),
                        ),
                        // logo de l application
                        image: Image.asset(
                          "assets/img/ico.png",
                          height: 100,
                        ),
                        submitButtonText: 'Envoyer',
                        commentHint: 'Inserer ici votre commmentaire',
                        onCancelled: () => print('annuler'),
                        onSubmitted: (response) {
                          print(
                              'rating: ${response.rating}, comment: ${response.comment}');

                          // TODO: add your own logic
                          if (response.rating < 3.0) {
                            // send their comments to your email or anywhere you wish
                            // ask the user to contact you instead of leaving a bad review
                          } else {
                            _rateAndReviewApp();
                          }
                        },
                      ));
            },
          ),
          ListTile(
              leading: Icon(Icons.library_add_check),
              title: Text("Licences et librairies"),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationIcon: Image.asset(
                    'assets/img/ico.png',
                    height: 30,
                  ),
                  applicationName: 'Go Survey',
                  applicationVersion: '\nV0.0.1',
                  applicationLegalese: '2022 Power by Joviale',
                  children: <Widget>[Text('')],
                );
              }),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Inviter des amis'),
            onTap: () async {
              await FlutterShare.share(
                  title:
                      "Go Survey App: Telecharger notre application a partir de notre Site web");
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('A propos'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AproposGoSurvey()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Deconection'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('login', false);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginSignup()));
            },
          ),
        ],
      ),
    );
  }

  // actual store listing review & rating
  void _rateAndReviewApp() async {
    // refer to: https://pub.dev/packages/in_app_review
    final _inAppReview = InAppReview.instance;

    if (await _inAppReview.isAvailable()) {
      print('request actual review from store');
      _inAppReview.requestReview();
    } else {
      print('open actual store listing');
      // TODO: use your own store ids
      _inAppReview.openStoreListing(
        appStoreId: '<your app store id>',
        microsoftStoreId: '<your microsoft store id>',
      );
    }
  }
}

class AlertGoSurvey extends StatelessWidget {
  const AlertGoSurvey({
    Key? key,
    required this.titre,
    required this.hinText,
    required this.prefId,
    required this.routeLink,
    required TextEditingController alertController,
    required RubriqueService recensementService,
  })  : _alertController = alertController,
        _recensementService = recensementService,
        super(key: key);
  final String titre;
  final String hinText;
  final String prefId;
  final String routeLink;
  final TextEditingController _alertController;
  final RubriqueService _recensementService;

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
                        controller: _alertController,
                        autofocus: true,
                        onTap: () {},
                        onChanged: (value) {},
                        decoration: InputDecoration(hintText: hinText),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () async {
                    if (_alertController.text != '') {
                      var recPref = await SharedPreferences.getInstance();
                      var recId = recPref.getInt('authId');
                      var recensement = RubriqueModel();
                      recensement.userId = recId;
                      recensement.description = _alertController.text;
                      recensement.questCount = 0;
                      var result =
                          await _recensementService.saveRubrique(recensement);
                      recPref.setInt(prefId, result);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionnaireCreate(
                                    title: "Creation du questionnaire",
                                  )));
                      print(recPref.getInt(prefId));
                    } else
                      print('text input not null');
                  },
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

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key, required this.RouteLink});
  final String RouteLink;
  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  late SharedPreferences prefs;

  @override
  void initState() {
    rubriquesList = <RubriqueModel>[];
    _foundRUb = rubriquesList;
    getRubriques();
    super.initState();
  }

  List<RubriqueModel> _foundRUb = [];
  late List<RubriqueModel> rubriquesList;
  var _rubriqueService = RubriqueService();
  getRubriques() async {
    var rubriques = await _rubriqueService.getAllRubriques();
    setState(() {
      rubriques.forEach((rub) {
        var rubriqueModel = RubriqueModel();
        rubriqueModel.id = rub['id'];
        rubriqueModel.description = rub['description'];
        rubriqueModel.questCount = rub['questCount'];
        rubriquesList.add(rubriqueModel);
      });
    });
    print(rubriquesList);
  }

  void _runFiltre(String value) {
    List<RubriqueModel> result = [];
    if (value.isEmpty) {
      result = rubriquesList;
    } else {
      result = rubriquesList
          .where((element) =>
              element.description!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundRUb = result;
    });
  }

  Widget header() {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 15 * 2.5),
      height: size.height * .14,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 15,
              bottom: 36 + 15,
            ),
            height: size.height * .2,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                )),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Go Survey",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 100,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundImage: AssetImage(
                        "assets/img/ico.png",
                      ),
                      radius: 70,
                    ),
                  )
                ],
              ),
            ),
          ),
          // TextButton(
          //     onPressed: () {
          //       print(_foundRUb[0].id);
          //     },
          //     child: Text("OOOOK")),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: 48,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Colors.green.withOpacity(.23))
                  ]),
              child: TextField(
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
                onChanged: (value) => _runFiltre(value),
                decoration: InputDecoration(
                    hintText: "Rechercher...",
                    iconColor: Colors.green,
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    suffixIcon: Icon(Icons.search)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // activation du scroking dans des petites appareils
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            header(),
            widget.RouteLink == "mainDashboard"
                ? MainDashboard(
                    foundRUb: _foundRUb,
                  )
                : widget.RouteLink == "oldEnquete"
                    ? OldEnquete(
                        rubriquesList: _foundRUb,
                      )
                    : NewEnquete(
                        rubriquesList: _foundRUb,
                      ),
          ],
        ));
  }
}
