import 'package:flutter/material.dart';

class UserInterface extends StatelessWidget {
  const UserInterface({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuration du UI"),
      ),
      body: UserInterfaceHome(),
    );
  }
}

class UserInterfaceHome extends StatefulWidget {
  const UserInterfaceHome({super.key});

  @override
  State<UserInterfaceHome> createState() => _UserInterfaceHomeState();
}

class _UserInterfaceHomeState extends State<UserInterfaceHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          UserInterfacewidget(
            titre: "Theme",
            hintText: "Utiliser le theme de l'appareil",
          ),
          UserInterfacewidget(
            titre: "Langue",
            hintText: "Utiliser la langue de l'appareil",
          ),
          UserInterfacewidget(
            titre: "Taille de police",
            hintText: "Normal",
          ),
          UserInterfacewidget(
            titre: "Ecran d'acceuil",
            hintText: "true",
          ),
        ],
      ),
    );
  }
}

class UserInterfacewidget extends StatelessWidget {
  const UserInterfacewidget(
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
