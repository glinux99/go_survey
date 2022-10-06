import 'package:flutter/material.dart';
import 'package:go_survey/admin/dashbord.dart';
import 'package:go_survey/components/DrawerMenu/configs/taille_config.dart';
import 'package:go_survey/components/screen/home_screen.dart';
import 'package:go_survey/models/users/user.dart';
import 'package:go_survey/models/users/user_service.dart';

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
  var _userService = UserService();
  @override
  void initState() {
    super.initState();
    connecter = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/2.png"), fit: BoxFit.fill)),
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                color: Color.fromARGB(255, 67, 153, 59).withOpacity(.80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "Bienvenu dans ",
                          style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 11, 20, 12)),
                          children: [
                            TextSpan(
                                text: "Gosurvey",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold))
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Le leader dans les enquetes",
                      style: TextStyle(letterSpacing: 1, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          Form(
            key: _key,
            child: AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              curve: Curves.bounceInOut,
              top: connecter ? inscriptErreur : 230,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 0),
                curve: Curves.bounceInOut,
                padding: EdgeInsets.all(20),
                // height: connecter ? 450 : 400,
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.3),
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
                                        ? Colors.green
                                        : Color.fromARGB(172, 76, 175, 79)),
                              ),
                              if (!connecter)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 3,
                                  width: 100,
                                  color: Colors.green,
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
                                          ? Colors.green
                                          : Color.fromARGB(172, 76, 175, 79)),
                                ),
                                if (connecter)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 3,
                                    width: 100,
                                    color: Colors.green,
                                  ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    if (connecter) EnregistementSection(),
                    if (!connecter) LoginSection(),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          _key.currentState!.save();
                          var _user = User();
                          _user.name = nameController.text;
                          _user.email = emailController.text;
                          _user.phone = phoneController.text;
                          _user.password = passwordController.text;
                          var _result = await _userService.SaveUser(_user);
                          print(_result);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Dashboard(
                                        RouteLink: "mainDashboard",
                                      )));
                        }
                      },
                      child: !connecter
                          ? Text(
                              "Se connecter",
                              style: TextStyle(color: Colors.white),
                            )
                          : Text("S'incrire",
                              style: TextStyle(color: Colors.white)),
                      style: TextButton.styleFrom(
                          side: BorderSide(width: 1, color: Colors.grey),
                          minimumSize: Size(145, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          // primary: Colors.white,
                          backgroundColor: Colors.green),
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
                    margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SocialButton(Icons.facebook, "Facebook", Colors.blue),
                        SocialButton(Icons.plus_one, "Google", Colors.red)
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  TextButton SocialButton(IconData icon, String titre, Color bg) {
    return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
            side: BorderSide(width: 1, color: Colors.grey),
            minimumSize: Size(145, 40),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            primary: Colors.white,
            backgroundColor: bg),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 5,
            ),
            Text(titre)
          ],
        ));
  }

  Container EnregistementSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          TextFieldContainer(
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                  labelText: "Votre nom"),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Ce champs est requi';
                return null;
              },
            ),
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
                labelStyle: TextStyle(color: Color.fromARGB(183, 0, 0, 0)),
                icon: Icon(
                  Icons.email_sharp,
                  color: Colors.green,
                ),
                iconColor: Colors.green,
                labelText: 'Adresse E-mail'),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Ce champs est requi';
              String pattern = r'\w+@\w+\.\w+';
              if (!RegExp(pattern).hasMatch(value))
                return 'Format incorrect pour l\'addresse E-mail';
              return null;
            },
          ),
          TextFieldContainer(
            child: TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.phone_in_talk,
                    color: Colors.green,
                  ),
                  labelText: "+243"),
            ),
          ),
          TextFieldContainer(
              child: TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty)
                return '''Le mot de passe ne peut pas etre null ou vide''';
              String pattern = r'^(\w+).{7,}$';
              if (!RegExp(pattern).hasMatch(value))
                return '''8 characteres sont requis pour le mot de passe''';
              return null;
            },
            obscureText: true,
            obscuringCharacter: "*",
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              icon: Icon(
                Icons.local_activity,
                color: Colors.green,
              ),
              hintText: '*****************',
            ),
          )),
        ],
      ),
    );
  }

  Container LoginSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
                labelStyle: TextStyle(color: Color.fromARGB(183, 0, 0, 0)),
                icon: Icon(
                  Icons.email_sharp,
                  color: Colors.green,
                ),
                iconColor: Colors.green,
                labelText: 'Adresse E-mail'),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Ce champs est requi';
              String pattern = r'\w+@\w+\.\w+';
              if (!RegExp(pattern).hasMatch(value))
                return 'Format incorrect pour l\'addresse E-mail';
              return null;
            },
          ),
          TextFieldContainer(
              child: TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty)
                return '''Le mot de passe ne peut pas etre null ou vide''';
              String pattern = r'^(\w+).{7,}$';
              if (!RegExp(pattern).hasMatch(value))
                return '''8 characteres sont requis pour le mot de passe''';
              return null;
            },
            obscureText: true,
            obscuringCharacter: "*",
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              icon: Icon(
                Icons.local_activity,
                color: Colors.green,
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
                          activeColor: Colors.green,
                          value: souvenir,
                          onChanged: (value) {
                            setState(() {
                              souvenir = !souvenir;
                            });
                          }),
                      Text(
                        "Se souvenir de moi",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
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
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      width: taille.width * .8,
      decoration: BoxDecoration(
        color: Colors.white38,
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
                  fontSize: screenProportionGetWidht(17), color: Colors.white),
            )),
      ),
    );
  }
}
