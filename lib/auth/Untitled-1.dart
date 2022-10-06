import 'package:flutter/material.dart';
import 'package:go_survey/components/DrawerMenu/oldEnqueteQuestionnaires/enquetes_recentes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // user name
                      Column(
                        children: [
                          Text(
                            "Salut Daniel",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "26 Septembre 2022",
                            style: TextStyle(color: Colors.green[200]),
                          )
                        ],
                      ),
                      // noti
                      Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(148, 103, 224, 123),
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.all(0),
                          child: TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.menu, color: Colors.white),
                              label: Text(""))),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // barre de recherche
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green[600],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Row(children: [
                      Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      Text(
                        "Tapez ici votre recherche",
                        style: TextStyle(color: Colors.green[200]),
                      )
                    ]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Que voulez-vous faire aujourd'hui?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.green[600],
                            borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Enfant",
                          style: TextStyle(fontSize: 28),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.green[600],
                            borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Enfant",
                          style: TextStyle(fontSize: 28),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(25),
              color: Colors.grey[300],
              child: Center(
                child: Column(children: [
                  // enquetes recentes titres
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Enquetes recents",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Icon(Icons.more_horiz)
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // enquetes recentes
                  Expanded(
                      child: ListView(
                    children: [
                      // EnqueteRecente(),
                      // EnqueteRecente(),
                      // EnqueteRecente(),
                      // EnqueteRecente(),
                      // EnqueteRecente(),
                      // EnqueteRecente(),
                      // EnqueteRecente(),
                      // EnqueteRecente(),
                    ],
                  ))
                ]),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
