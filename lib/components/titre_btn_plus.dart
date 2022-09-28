import 'package:flutter/material.dart';

class TitreButtonPlus extends StatelessWidget {
  const TitreButtonPlus({Key? key, required this.titre, required this.titreBtn})
      : super(key: key);
  final String titreBtn, titre;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextSouligne(
            text: titre,
          ),
          FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.green,
              onPressed: () {},
              child: Text(
                titreBtn,
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}

class TextSouligne extends StatelessWidget {
  const TextSouligne({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15 / 4),
            child: Text(
              text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.only(right: 15 / 4),
                height: 7,
                color: Colors.green.withOpacity(.2),
              ))
        ],
      ),
    );
  }
}
