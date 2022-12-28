import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_survey/admin/dashbord.dart';
import 'package:go_survey/components/DrawerMenu/configs/taille_config.dart';
import 'package:go_survey/components/colors/colors.dart';
import 'package:go_survey/models/users/user.dart';
import 'package:go_survey/models/users/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  @override
  State<LoginSignup> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  bool connecter = false;
  bool souvenir = false;
  double inscriptErreur = 200;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  late List<User> userUnique;
  late List<User> userAuth;
  var _userService = UserService();

  @override
  void initState() {
    super.initState();
    connecter = true;
    userUnique = [];
    userAuth = [];
  }

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.height;
    final isclavier = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: size / 3,
              // hg 300
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/2.png"), fit: BoxFit.fill)),
              child: Container(
                padding: const EdgeInsets.only(top: 90, left: 20),
                color: const Color.fromARGB(255, 67, 153, 59).withOpacity(.80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                          text: "Bienvenu dans ",
                          style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 11, 20, 12)),
                          children: [
                            TextSpan(
                                text: "Gosurvey",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: kBlack,
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Le leader dans les enquetes",
                      style: TextStyle(letterSpacing: 1, color: kWhite),
                    )
                  ],
                ),
              ),
            ),
          ),
          Form(
            key: _key,
            child: AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.bounceInOut,
              // bottom: 0,
              top: connecter
                  ? isclavier
                      ? size - MediaQuery.of(context).size.height
                      : size - (MediaQuery.of(context).size.height - 100) / 1.14
                  : isclavier
                      ? 100
                      : size - (MediaQuery.of(context).size.height - 100) / 1.2,
              // top 230

              child: AnimatedContainer(
                duration: const Duration(milliseconds: 0),
                curve: Curves.bounceInOut,
                padding: const EdgeInsets.all(20),
                // height: connecter ? 450 : 400,
                width: MediaQuery.of(context).size.width - 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: kBlack.withOpacity(.3),
                          spreadRadius: 5,
                          blurRadius: 15)
                    ]),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              connecter = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Connection",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !connecter
                                        ? kGreen
                                        : const Color.fromARGB(
                                            172, 76, 175, 79)),
                              ),
                              if (!connecter)
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  height: 3,
                                  width: 100,
                                  color: kGreen,
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              connecter = true;
                            });
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  "Inscription",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: connecter
                                          ? kGreen
                                          : const Color.fromARGB(
                                              172, 76, 175, 79)),
                                ),
                                if (connecter)
                                  Container(
                                    margin: const EdgeInsets.only(top: 3),
                                    height: 3,
                                    width: 100,
                                    color: kGreen,
                                  ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    if (connecter) enregistrementSection(),
                    if (!connecter) loginSection(),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          _key.currentState!.save();
                          var user = User();
                          user.name = nameController.text;
                          user.email = emailController.text;
                          user.phone = phoneController.text;
                          user.password = passwordController.text;
                          final logPref = await SharedPreferences.getInstance();
                          if (connecter) {
                            var result = await _userService.saveUser(user);
                            logPref.setBool('login', true);
                            result = await _userService.loginUser(
                                emailController.text, passwordController.text);
                            var userId;
                            print(result);
                            // for (var entry in result[0].entries) {
                            //   if (entry.key == 'id') userId = entry.value;
                            //   if (entry.key == 'name')
                            //     logPref.setString('userName', entry.value);
                            //   if (entry.key == 'phone')
                            //     logPref.setString('userPhone', entry.value);
                            // }
                            if (result.isEmpty != true) {
                              result.forEach((userUnik) {
                                setState(() {
                                  var userModel = User();
                                  userModel.id = userUnik['id'];
                                  userModel.name = userUnik['name'];
                                  userModel.email = userUnik['email'];
                                  userModel.phone =
                                      userUnik['phone'].toString();
                                  userModel.password = userUnik['password'];
                                  userAuth.add(userModel);
                                  userId = userAuth[0].id;
                                  logPref.setString(
                                      'userName', userAuth[0].name.toString());
                                  logPref.setString('userPhone',
                                      userAuth[0].phone.toString());
                                });
                              });
                            }
                            logPref.setInt('authId', userId);
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Dashboard(
                                          RouteLink: "mainDashboard",
                                        )));
                            // print(result);
                          }
                          if (!connecter) {
                            var result = await _userService.loginUser(
                                emailController.text, passwordController.text);

                            print(emailController.text);
                            print(passwordController.text);
                            if (result.isEmpty != true) {
                              var userId;
                              // some things error
                              print('login is okay');
                              for (var entry in result[0].entries) {
                                if (entry.key == 'id') userId = entry.value;
                                if (entry.key == 'name')
                                  logPref.setString('userName', entry.value);
                                if (entry.key == 'phone')
                                  logPref.setString(
                                      'userPhone', entry.value.toString());
                                if (entry.key == 'password')
                                  logPref.setString(
                                      'userPassword', entry.value.toString());
                                if (entry.key == 'email')
                                  logPref.setString(
                                      'userEmail', entry.value.toString());
                              }
                              logPref.setInt('authId', userId);
                              print(userId);
                              // print(userUnique[0].email);
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Dashboard(
                                            RouteLink: "mainDashboard",
                                          )));
                              logPref.setBool('login', true);
                            } else {
                              // Si l'authentification refuse ce code pourra s'executer
                              Fluttertoast.showToast(
                                msg: "Echec d'authentification",
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              // print('login is failled');
                            }
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                          side: const BorderSide(width: 1, color: kGrey),
                          minimumSize: const Size(145, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          // primary: kWhite,
                          backgroundColor: kGreen),
                      child: !connecter
                          ? const Text(
                              "Se connecter",
                              style: TextStyle(color: kWhite),
                            )
                          : const Text("S'incrire",
                              style: TextStyle(color: kWhite)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              right: 0,
              left: 0,
              top: MediaQuery.of(context).size.height - 100,
              child: Column(
                children: [
                  Text(!connecter ? "Ou se connecter avec" : "S'incrire avec"),
                  Container(
                    margin: const EdgeInsets.only(right: 20, left: 20, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        socialButton(Icons.facebook, "Facebook", kFacebook,
                            'https://www.facebook.com'),
                        socialButton(FontAwesomeIcons.googlePlus, "Google",
                            kGoogle, 'https://www.gmail.com')
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  TextButton socialButton(IconData icon, String titre, Color bg, String link) {
    return TextButton(
        onPressed: () async {
          final url = Uri.parse(link);
          if (await canLaunchUrl(url)) {
            // await launchUrl(url);
            await launchUrl(url, mode: LaunchMode.externalApplication);
          }
        },
        style: TextButton.styleFrom(
            side: const BorderSide(width: 1, color: kGrey),
            minimumSize: const Size(145, 40),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            primary: kWhite,
            backgroundColor: bg),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 5,
            ),
            Text(titre)
          ],
        ));
  }

  Container enregistrementSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ListView(
        children: [
          TextFieldContainer(
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              controller: nameController,
              decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Color.fromARGB(183, 0, 0, 0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                  icon: Icon(
                    Icons.person,
                    color: kGreen,
                  ),
                  labelText: "Votre nom"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champs est requi';
                }
                return null;
              },
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.black),
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: const InputDecoration(
                labelStyle: TextStyle(color: Color.fromARGB(183, 0, 0, 0)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38),
                ),
                icon: Icon(
                  Icons.email_sharp,
                  color: kGreen,
                ),
                iconColor: kGreen,
                labelText: 'Adresse E-mail'),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Ce champs est requi';
              String pattern = r'\w+@\w+\.\w+';
              if (!RegExp(pattern).hasMatch(value)) {
                return 'Format incorrect pour l\'addresse E-mail';
              }
              return null;
            },
          ),
          TextFieldContainer(
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.phone,
              controller: phoneController,
              decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Color.fromARGB(183, 0, 0, 0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                  icon: Icon(
                    Icons.phone_in_talk,
                    color: kGreen,
                  ),
                  labelText: "+243"),
            ),
          ),
          TextFieldContainer(
              child: TextFormField(
            style: TextStyle(color: Colors.black),
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '''Le mot de passe ne peut pas etre null ou vide''';
              }
              String pattern = r'^(\w+).{7,}$';
              if (!RegExp(pattern).hasMatch(value)) {
                return '''8 characteres sont requis pour le mot de passe''';
              }
              return null;
            },
            obscureText: true,
            obscuringCharacter: "*",
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintStyle: TextStyle(color: Color.fromARGB(183, 0, 0, 0)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black38),
              ),
              icon: Icon(
                FontAwesomeIcons.lock,
                color: kGreen,
              ),
              hintText: '*****************',
            ),
          )),
        ],
      ),
    );
  }

// Section de connection
  Container loginSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          TextFormField(
            style: TextStyle(color: Colors.black),
            controller: emailController,
            decoration: const InputDecoration(
                labelStyle: TextStyle(color: Color.fromARGB(183, 0, 0, 0)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38),
                ),
                icon: Icon(
                  Icons.email_sharp,
                  color: kGreen,
                ),
                iconColor: kGreen,
                labelText: 'Adresse E-mail'),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Ce champs est requi';
              String pattern = r'\w+@\w+\.\w+';
              if (!RegExp(pattern).hasMatch(value)) {
                return 'Format incorrect pour l\'addresse E-mail';
              }
              return null;
            },
          ),
          TextFieldContainer(
              child: TextFormField(
            style: TextStyle(color: Colors.black),
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '''Le mot de passe ne peut pas etre null ou vide''';
              }
              String pattern = r'^(\w+).{7,}$';
              if (!RegExp(pattern).hasMatch(value)) {
                return '''8 characteres sont requis pour le mot de passe''';
              }
              return null;
            },
            obscureText: true,
            obscuringCharacter: "*",
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintStyle: TextStyle(color: Color.fromARGB(183, 0, 0, 0)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black38),
              ),
              icon: Icon(
                FontAwesomeIcons.lock,
                color: kGreen,
              ),
              hintText: '*****************',
            ),
          )),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          side: MaterialStateBorderSide.resolveWith(
                            (states) =>
                                BorderSide(width: 1.0, color: Colors.black12),
                          ),
                          activeColor: kGreen,
                          value: souvenir,
                          onChanged: (value) {
                            setState(() {
                              souvenir = !souvenir;
                            });
                          }),
                      const Text(
                        "Se souvenir de moi",
                        style: TextStyle(fontSize: 12, color: kGrey),
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Mot de passe oublie?",
                        style: TextStyle(fontSize: 12),
                      ))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    Size taille = MediaQuery.of(context).size;
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      width: taille.width * .8,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}

class ButtonContinue extends StatefulWidget {
  const ButtonContinue({Key? key, required this.texte}) : super(key: key);
  final String texte;
  // final Function appuyez;
  @override
  State<ButtonContinue> createState() => _ButtonContinueState();
}

class _ButtonContinueState extends State<ButtonContinue> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SizedBox(
        width: screenProportionGetWidht(200),
        height: screenProportionGetHeight(40),
        child: TextButton(

            // onPressed: widget.appuyez,
            onPressed: () {},
            child: Text(
              widget.texte,
              style: TextStyle(
                  fontSize: screenProportionGetWidht(17), color: kWhite),
            )),
      ),
    );
  }
}
