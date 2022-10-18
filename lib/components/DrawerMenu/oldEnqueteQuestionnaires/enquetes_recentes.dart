import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EnqueteRecente extends StatefulWidget {
  const EnqueteRecente({
    super.key,
    required this.titre,
    required this.sousTitre,
    required this.RubriqueImg,
  });
  final titre, sousTitre, RubriqueImg;
  // final CountQ = 0;
  @override
  State<EnqueteRecente> createState() => _EnqueteRecenteState();
}

class _EnqueteRecenteState extends State<EnqueteRecente> {
  @override
  Widget build(BuildContext context) {
    final List<IconData> points = [
      FontAwesomeIcons.chartArea,
      FontAwesomeIcons.chartBar,
      FontAwesomeIcons.chartColumn,
      FontAwesomeIcons.chartGantt,
      FontAwesomeIcons.chartLine,
      FontAwesomeIcons.chartPie,
      FontAwesomeIcons.chartSimple
    ];
    final Random r = Random();

    IconData randomIcon = points[r.nextInt(points.length)];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Divider(
            height: 2,
          ),
          Card(
            elevation: 5,
            child: ListTile(
              title: Text(
                widget.titre,
                style: TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.green,
                    child: Icon(randomIcon)),
              ),
              subtitle: Text(
                widget.sousTitre,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12),
              ),
              trailing: Icon(Icons.more_vert_outlined),
            ),
          ),
          SizedBox(
            height: 2,
          )
        ],
      ),
    );
  }
}
