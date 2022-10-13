import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(16),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                            padding: EdgeInsets.all(16),
                            color: Colors.green,
                            child: Icon(Icons.graphic_eq)),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // titre
                          Text(
                            widget.titre,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          // sous titre
                          Text(
                            widget.sousTitre,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      Text('\n\n12'),
                    ],
                  ),
                  Icon(Icons.more_vert),
                ],
              )),
          Divider(
            height: 2,
          )
        ],
      ),
    );
  }
}
