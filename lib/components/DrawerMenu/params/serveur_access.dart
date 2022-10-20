import 'package:flutter/material.dart';

class ServeurAccess extends StatelessWidget {
  const ServeurAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuration du Serveur"),
      ),
      body: ServeurAccessHome(),
    );
  }
}

class ServeurAccessHome extends StatefulWidget {
  const ServeurAccessHome({super.key});

  @override
  State<ServeurAccessHome> createState() => _ServeurAccessHomeState();
}

class _ServeurAccessHomeState extends State<ServeurAccessHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          serveurwidget(
            titre: "Nom du Serveur",
            hintText: "GoSurvey Server",
            champ: "serveur",
          ),
          serveurwidget(
            titre: "Url",
            hintText: "https://",
            champ: "",
          ),
          serveurwidget(
            titre: "Nom d'Utilisateur",
            hintText: "GoSurvey Server",
          ),
          serveurwidget(
            titre: "Mot de pass",
            hintText: "************",
            obscure: true,
          ),
        ],
      ),
    );
  }
}

class serveurwidget extends StatelessWidget {
  const serveurwidget(
      {Key? key,
      required this.titre,
      required this.hintText,
      this.obscure,
      this.champ})
      : super(key: key);
  final String titre, hintText;
  final bool? obscure;
  final String? champ;
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
