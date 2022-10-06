import 'package:flutter/material.dart';
import 'package:go_survey/components/DrawerMenu/params/accesscontrol.dart';
import 'package:go_survey/components/DrawerMenu/params/projets.dart';
import 'package:go_survey/components/DrawerMenu/params/projetuser.dart';
import 'package:go_survey/components/DrawerMenu/params/serveur_access.dart';
import 'package:go_survey/components/DrawerMenu/params/useridentity.dart';
import 'package:go_survey/components/DrawerMenu/params/userinterface.dart';

class ParametreMenu extends StatefulWidget {
  const ParametreMenu({super.key});

  @override
  State<ParametreMenu> createState() => _ParametreMenuState();
}

class _ParametreMenuState extends State<ParametreMenu> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        ListTile(
          leading: Icon(Icons.cloud_done_outlined),
          title: Text("Serveur"),
          subtitle: Text("url, utilisateur, mot de passe"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ServeurAccess()));
          },
        ),
        ListTile(
          leading: Icon(Icons.person_add_alt_1),
          title: Text("Interface utilisateur"),
          subtitle: Text("langue,theme, taille de police"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserInterface()));
          },
        ),
        ListTile(
          leading: Icon(Icons.forum_sharp),
          title: Text("Gestions des formulaires"),
          subtitle: Text("Mis a jour, envoi et supressions automatiques"),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProjetFormulairesAccess()));
          },
        ),
        ListTile(
          leading: Icon(Icons.cloud_done_outlined),
          title: Text("Identite de l'utilisateur et de l'application"),
          subtitle: Text(
              "Nom utilisateur, numero de Telephone et identite de l'appareil"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PhoneIdentityAccess()));
          },
        ),
        Divider(
          height: 30,
          color: Colors.green,
          thickness: 1.5,
        ),
        ListTile(
          leading: Icon(Icons.cloud_done_outlined),
          title: Text("Configuration du mot de passe"),
          subtitle: Text("mot de passe de l'utilisateur"),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.cloud_done_outlined),
          title: Text("Gestion de projet"),
          subtitle: Text("Reconfigurer, reinitialiser, supprimer"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProjetsConfigAccess()));
          },
        ),
        ListTile(
          leading: Icon(Icons.local_activity),
          title: Text("Controle d'acces"),
          subtitle: Text(""),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ControleAccessAccess()));
          },
        ),
      ]),
    );
  }
}
