import 'package:flutter/material.dart';

class ProjetsConfigAccess extends StatelessWidget {
  const ProjetsConfigAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuration de Projets"),
      ),
      body: ProjetsConfigAccessHome(),
    );
  }
}

class ProjetsConfigAccessHome extends StatefulWidget {
  const ProjetsConfigAccessHome({super.key});

  @override
  State<ProjetsConfigAccessHome> createState() =>
      _ProjetsConfigAccessHomeState();
}

class _ProjetsConfigAccessHomeState extends State<ProjetsConfigAccessHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // Il faut ajiuter les icones
        children: [
          ProjetsConfigwidget(
            titre: "Reconfigurer avec un code QR Code",
            hintText: "Remplacer tous les parametres existants",
          ),
          ProjetsConfigwidget(
            titre: "Reinitialiser",
            hintText: "Choisir depuis les paramtres, formulaires et donnees",
          ),
          ProjetsConfigwidget(
            titre: "Supprimer",
            hintText: "",
          ),
        ],
      ),
    );
  }
}

class ProjetsConfigwidget extends StatelessWidget {
  const ProjetsConfigwidget(
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
