import 'package:flutter/material.dart';

class ProjetFormulairesAccess extends StatelessWidget {
  const ProjetFormulairesAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Projets et Formulaires"),
      ),
      body: ProjetFormulairesAccessHome(),
    );
  }
}

class ProjetFormulairesAccessHome extends StatefulWidget {
  const ProjetFormulairesAccessHome({super.key});

  @override
  State<ProjetFormulairesAccessHome> createState() =>
      _ProjetFormulairesAccessHomeState();
}

class _ProjetFormulairesAccessHomeState
    extends State<ProjetFormulairesAccessHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ProjetFormulaireswidget(
            titre: "Mode de mis a jour des formulaire vierges",
            hintText: "Manuel",
          ),
          ProjetFormulaireswidget(
            titre: "Frequences de Mise a jour automatique",
            hintText: "toutes les 10min",
          ),
          ProjetFormulaireswidget(
            titre: "Envoie automatique",
            hintText: "Off",
          ),
          ProjetFormulaireswidget(
            titre: "Suppression apres l'envoi",
            hintText:
                "Suppression des medias et formulaire finalisees apresl'envoi au serveur",
          ),
          ProjetFormulaireswidget(
            titre: "Finaliser par defaut",
            hintText: "Marquer comme finalise par defaut",
          ),
        ],
      ),
    );
  }
}

class ProjetFormulaireswidget extends StatelessWidget {
  const ProjetFormulaireswidget(
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
