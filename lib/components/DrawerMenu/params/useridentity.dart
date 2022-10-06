import 'package:flutter/material.dart';

class PhoneIdentityAccess extends StatelessWidget {
  const PhoneIdentityAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Identite de l'appareil et de l'utilisateur"),
      ),
      body: PhoneIdentityAccessHome(),
    );
  }
}

class PhoneIdentityAccessHome extends StatefulWidget {
  const PhoneIdentityAccessHome({super.key});

  @override
  State<PhoneIdentityAccessHome> createState() =>
      _PhoneIdentityAccessHomeState();
}

class _PhoneIdentityAccessHomeState extends State<PhoneIdentityAccessHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          PhoneIdentitywidget(
            titre: "Metadonnees du formulaire",
            hintText:
                "Ces valeurs seront ajoutees aux formulaires qui ont des champs pre-charges d'utilisateur, de courrier electronique et / ou de telephone pour identifier la personne qui soumet des donnees",
          ),
          PhoneIdentitywidget(
            titre: "Collecter des donnees d'utilisateur anonyme",
            hintText:
                "Les donnees anonumes d'utilisation nous aident a prioriser les correctifs et les fonctionnalites",
          ),
        ],
      ),
    );
  }
}

class PhoneIdentitywidget extends StatelessWidget {
  const PhoneIdentitywidget(
      {Key? key, required this.titre, required this.hintText, this.obscure})
      : super(key: key);
  final String titre, hintText;
  final bool? obscure;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(titre),
            subtitle: TextField(
              obscureText: obscure ?? false,
              decoration:
                  InputDecoration(hintText: hintText, border: InputBorder.none),
            ),
          ),
          Divider(
            color: Colors.green,
            height: 2,
          )
        ],
      ),
    );
  }
}
