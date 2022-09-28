import 'package:flutter/material.dart';
import 'package:go_survey/admin/dashbord.dart';
import 'package:go_survey/components/home_screen.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  @override
  State<LoginSignup> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  bool connecter = false;
  bool souvenir = false;
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
          AnimatedPositioned(
            duration: Duration(milliseconds: 400),
            curve: Curves.bounceInOut,
            top: connecter ? 200 : 230,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              curve: Curves.bounceInOut,
              padding: EdgeInsets.all(20),
              height: connecter ? 380 : 350,
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
                                height: 2,
                                width: 100,
                                color: Colors.orange,
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
                                  height: 2,
                                  width: 100,
                                  color: Colors.orange,
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
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard(
                                    Route: "mainDashboard",
                                  )));
                    },
                    child: Text("S'incrire"),
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
          ),
          Positioned(
              top: MediaQuery.of(context).size.height - 150,
              right: 0,
              left: 0,
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
          RoundedInputField(
              hintText: "genesiskikimba@gmail.com",
              icon: Icons.lock_clock_outlined,
              value: false)
        ],
      ),
    );
  }

  Container LoginSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          RoundedInputField(
              hintText: "genesiskikimba@gmail.com",
              icon: Icons.lock_clock_outlined,
              value: false),
          PasswordInputField(
              hintText: "*********", icon: Icons.lock, value: true),
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
