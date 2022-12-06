// ignore: file_names
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_survey/admin/dashbord.dart';
import 'package:go_survey/auth/login.dart';
import 'dart:io';
import 'package:go_survey/components/DrawerMenu/apropos.dart';
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
// import 'package:universal_html/html.dart';

import '../../save.dart';

// Menu drawer
class MenuGauche extends StatefulWidget {
  const MenuGauche({super.key});

  @override
  State<MenuGauche> createState() => _MenuGaucheState();
}

bool iconBinary = false;

class _MenuGaucheState extends State<MenuGauche> {
  bool profilevieuw = false;
  // ignore: prefer_typing_uninitialized_variables
  var user;
  late String userName = 'Daniel';
  late String userPhone = '+243 970912428';
  late List<User> userUnique = [];

  int _currIndex = 1;
  int _currIndex2 = 1;
  final _userService = UserService();

  @override
  void initState() {
    getAuthUser();
    // TODO: implement initState
    super.initState();
  }

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

  // actual store listing review & rating
  void _rateAndReviewApp() async {
    // refer to: https://pub.dev/packages/in_app_review
    final inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      print('request actual review from store');
      inAppReview.requestReview();
    } else {
      print('open actual store listing');
      // TODO: use your own store ids
      inAppReview.openStoreListing(
        appStoreId: '<your app store id>',
        microsoftStoreId: '<your microsoft store id>',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String store = "";
    if (Platform.isAndroid) {
      store = "Playstore";
    } else {
      store = "Appstore";
    }
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
                      const CircleAvatar(
                        backgroundColor: Colors.green,
                        foregroundImage: AssetImage("assets/img/default.png"),
                        radius: 34,
                        child: Text(
                          'user',
                        ),
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
                                      turns: child.key ==
                                              const ValueKey('icon11')
                                          ? Tween<double>(begin: 1, end: 0.5)
                                              .animate(anim)
                                          : Tween<double>(begin: 0.5, end: 1)
                                              .animate(anim),
                                      child: FadeTransition(
                                          opacity: anim, child: child),
                                    ),
                                child: _currIndex2 == 0
                                    ? const Icon(Icons.light_mode_rounded,
                                        color: Colors.white,
                                        key: ValueKey('icon11'))
                                    : const Icon(
                                        Icons.dark_mode_rounded,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        key: ValueKey('icon22'),
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
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              userPhone,
                              style: const TextStyle(color: Colors.white),
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
                                      turns: child.key ==
                                              const ValueKey('icon1')
                                          ? Tween<double>(begin: 1, end: 0.75)
                                              .animate(anim)
                                          : Tween<double>(begin: 0.75, end: 1)
                                              .animate(anim),
                                      child: FadeTransition(
                                          opacity: anim, child: child),
                                    ),
                                child: _currIndex == 0
                                    ? const Icon(Icons.keyboard_arrow_right,
                                        color: Colors.white,
                                        key: ValueKey('icon1'))
                                    : const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Colors.white,
                                        key: ValueKey('icon2'),
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
            Column(
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
                const Divider(thickness: 1),
              ],
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
              leading: const Icon(FontAwesomeIcons.chartBar),
              title: const Text("Nouvel enquete"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Dashboard(
                              RouteLink: 'newEnquete',
                            )));
              }),
          ListTile(
            leading: const Icon(Icons.bar_chart_rounded),
            title: const Text("Donnees recentes"),
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
            leading: const Icon(Icons.favorite),
            title: Text("Laissez un avis sur $store"),
            onTap: () {
              // show the dialog
              showDialog(
                  context: context,
                  barrierDismissible:
                      true, // set to false if you want to force a rating
                  builder: (context) => RatingDialog(
                        initialRating: 1.0,
                        // your app's name?
                        title: const Text(
                          'Evaluation',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        message: const Text(
                          'Appuyez sur une étoile pour définir votre évaluation. Ajoutez plus de description ici si vous le souhaitez.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
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
              leading: const Icon(Icons.library_add_check),
              title: const Text("Licences et librairies"),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationIcon: Image.asset(
                    'assets/img/ico.png',
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  applicationName: 'Go Survey',
                  applicationVersion: '\nV0.0.1',
                  applicationLegalese: '2022 Power by Joviale',
                  children: <Widget>[const Text('')],
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AproposGoSurvey()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Deconection'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('login', false);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginSignup()));
            },
          ),
        ],
      ),
    );
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

  final String hinText;
  final String prefId;
  final String routeLink;
  final String titre;

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
                    style: TextButton.styleFrom(
                        // primary: kWhite,
                        backgroundColor: kGreen.withOpacity(0.5)),
                    child: Text(titre,
                        style: const TextStyle(color: Colors.white)),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
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
                const SizedBox(
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
                              builder: (context) => const QuestionnaireCreate(
                                    title: "Creation du questionnaire",
                                  )));
                      print(recPref.getInt(prefId));
                    } else
                      print('text input not null');
                  },
                  child: const Text("Valider"),
                  style: TextButton.styleFrom(
                      side: const BorderSide(width: 1, color: Colors.grey),
                      minimumSize: const Size(145, 40),
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
  late String appTitle = widget.RouteLink == "newEnquete"
      ? "Nouvelle enquete"
      : widget.RouteLink == "oldEnquete"
          ? "Donnees recentes"
          : "Go Survey";

  late SharedPreferences prefs;
  late List<RubriqueModel> rubriquesList;

  List<RubriqueModel> _foundRUb = [];
  final _rubriqueService = RubriqueService();

  @override
  void initState() {
    rubriquesList = <RubriqueModel>[];
    _foundRUb = rubriquesList;
    getRubriques();
    super.initState();
  }

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

  Widget header() {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 15 * 2.5),
      height: size.height * .14,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 15,
              bottom: 36 + 15,
            ),
            height: size.height * .2,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                )),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appTitle,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 100,
                    child: const CircleAvatar(
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 48,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 10),
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
                    suffixIcon: const Icon(Icons.search)),
              ),
            ),
          ),
        ],
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    // activation du scroking dans des petites appareils
    return SingleChildScrollView(
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
      ),
    );
  }
}
