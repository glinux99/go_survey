import 'package:flutter/material.dart';
import 'package:go_survey/components/taille_config.dart';

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
            // ),
            RoundedInputField(
              hintText: "Votre nom",
              icon: Icons.person,
              value: false,
            ),
            const PasswordInputField(
              hintText: "**********",
              icon: Icons.key_sharp,
              value: true,
            ),
            ButtonContinue(
              texte: "Se connecter",
            ),
            Row(
              children: [Text("Vous n'avez-pas de compte?")],
            ),
          ],
        ),
      )),
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

class RoundedInputField extends StatelessWidget {
  const RoundedInputField(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.value})
      : super(key: key);
  final String hintText;
  final IconData icon;
  final bool value;
  // final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      enableSuggestions: true,
      autocorrect: true,
      decoration: InputDecoration(
        icon: const Icon(
          Icons.person,
          color: Colors.green,
        ),
        hintText: hintText,
        border: InputBorder.none,
      ),
    ));
  }
}

class PasswordInputField extends StatelessWidget {
  const PasswordInputField(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.value})
      : super(key: key);
  final String hintText;
  final IconData icon;
  final bool value;
  // final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      obscureText: value,
      obscuringCharacter: "*",
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        icon: Icon(
          icon,
          color: Colors.green,
        ),
        hintText: hintText,
        border: InputBorder.none,
      ),
    ));
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
