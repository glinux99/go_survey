import 'package:flutter/material.dart';

class AproposGoSurvey extends StatelessWidget {
  const AproposGoSurvey({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("A propos de Go Survey"),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
          child: ListView(children: [
            Center(
              child: Text(
                "Go Survey",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              '''
Go Survey est une application de création de sondages et de création de formulaires. Elle vous permet de créer des sondages et des formulaires sans effort et vous aide à collecter des données de haute qualité, même hors ligne. Partagez l'enquête sur différentes plateformes et collectez des réponses en temps réel. L'application est dans son appogee, il change du jour au jour pour permettre aux utilsateurs d'utiliser les fonctionnalites les plus recentes et pour les faciliter les analyse. Les mis a jour sont uniquement appliquees a notre version qui sera enn ligne. Votre version ne pourra pas etre concerne pour vous permettre de travailler tranquillemenent, toute fois si vous voulez changer de version ou profiter d'avanatge fonctionnalites mis a jour, vous devriez maiantenant demander une mis a jour de l'application ou la telecharger directement sur google play ou playstore
''',
              style: TextStyle(fontSize: 18, wordSpacing: 3, letterSpacing: 1),
              textAlign: TextAlign.justify,
            )
          ]),
        ),
      ),
    );
  }
}
