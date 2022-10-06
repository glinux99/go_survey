import 'package:flutter/material.dart';
import 'package:go_survey/components/DrawerMenu/configs/taille_config.dart';
import 'package:go_survey/components/DrawerMenu/headerDashboard.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    TailleConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://demo.activeitzone.com/ecommerce/public/assets/img/placeholder.jpg'),
                radius: 50.0),
            Text(
              "Login",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: Color.fromARGB(255, 158, 192, 159),
            //         borderRadius: BorderRadius.circular(20),
            //         border: Border.all(color: Colors.white)),
            //     child: const TextField(
            //       decoration: InputDecoration(
            //           border: InputBorder.none,
            //           hintText: "Votre username",
            //           contentPadding: EdgeInsets.only(left: 4)),
            //     ),
            //   ),
            // // ),
            // RoundedInputField(
            //   hintText: "Votre nom",
            //   icon: Icons.person,
            //   value: false,
            // ),
            // const PasswordInputField(
            //   hintText: "**********",
            //   icon: Icons.key_sharp,
            //   value: true,
            // ),
            // ButtonContinue(
            //   texte: "Se connecter",
            // ),
            Row(
              children: [Text("Vous n'avez-pas de compte?")],
            ),
          ],
        ),
      )),
    );
  }
}
