import 'package:flutter/material.dart';

class ReponseView extends StatefulWidget {
  const ReponseView({super.key});

  @override
  State<ReponseView> createState() => _ReponseViewState();
}

class _ReponseViewState extends State<ReponseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Visualisation de reponses")),
      body: ReponsesList(),
    );
  }
}

class ReponsesList extends StatelessWidget {
  const ReponsesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [Reponses(), Reponses(), Reponses(), Reponses()],
    ));
  }
}

class Reponses extends StatelessWidget {
  const Reponses({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0, left: 8.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.green,
                  child: Icon(Icons.message)),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "Quel est le nom de votre mari que vous aimez aussi bon que moi?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      // un moyen de modifier les reponse sera configurable dans l'application directement
                      enabled: false,
                      label: Text(
                          "Reponse ecris par le menage qui peut etre n'importe quoi"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
