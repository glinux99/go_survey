import 'package:flutter/material.dart';

class ControleAccessAccess extends StatelessWidget {
  const ControleAccessAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Controle d'access"),
      ),
      body: ControleAccessAccessHome(),
    );
  }
}

class ControleAccessAccessHome extends StatefulWidget {
  const ControleAccessAccessHome({super.key});

  @override
  State<ControleAccessAccessHome> createState() =>
      _ControleAccessAccessHomeState();
}

class _ControleAccessAccessHomeState extends State<ControleAccessAccessHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // il faut ajouter les icones
          ControleAccesswidget(
            titre: "Parametre du menu principale",
            hintText: "Montrer ou cacher les bouttons",
          ),
          ControleAccesswidget(
            titre: "Parametres utilisateurs",
            hintText: "Montrer ou cacher les parametres",
          ),
          ControleAccesswidget(
            titre: "Parametres d'entree du formulaire",
            hintText: "Montrer ou cacher les actions",
          ),
        ],
      ),
    );
  }
}

class ControleAccesswidget extends StatelessWidget {
  const ControleAccesswidget(
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
