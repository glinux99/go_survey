import 'package:flutter/material.dart';
import 'package:go_survey/admin/dashbord.dart';
import 'package:go_survey/components/DrawerMenu/oldEnquete.dart';
import 'package:go_survey/components/bodyDashboard.dart';
import 'package:go_survey/components/enquetes_recentes.dart';
import 'package:go_survey/components/newsurvey.dart';
import 'package:go_survey/components/rubriques.dart';
import 'package:go_survey/components/titre_btn_plus.dart';
import 'package:rating_dialog/rating_dialog.dart';

class HeaderDashboard extends StatelessWidget {
  const HeaderDashboard({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15 * 2.5),
      height: size.height * .2,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 36 + 15,
            ),
            height: size.height * .2 - 27,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                )),
            child: Row(
              children: [
                Text(
                  "Go SURVEY",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Image.asset("assets/img/ico.png")
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: 54,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Colors.green.withOpacity(.23))
                  ]),
              child: TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                    hintText: "Rechercher",
                    hintStyle: TextStyle(
                      color: Colors.green.withOpacity(.5),
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    suffixIcon: Icon(Icons.search)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Menu drawer
class MenuGauche extends StatelessWidget {
  const MenuGauche({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                color: Colors.green[400],
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(15))),
            accountName: Text("Daniel KIKIMBA"),
            accountEmail: Text("genesiskikimba@gmail.com"),
            currentAccountPicture:
                CircleAvatar(foregroundImage: AssetImage("assets/img/1.jpg")),
            otherAccountsPictures: [
              Icon(
                Icons.light_mode,
                color: Colors.white,
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Dashboard"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Dashboard(
                            RouteLink: "mainDashboard",
                          )));
            },
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text("Nouvel enquete"),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertGoSUrvey(
                        titre: "Creer une enquete",
                        hintText: "Entrer le nom de votre Enquete",
                        validation: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Dashboard(
                                        RouteLink: "newEnquete",
                                      )))
                        },
                      );
                    });
              }),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Enquetes recentes"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Dashboard(
                            RouteLink: "oldEnquete",
                          )));
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Parametre de l'application"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Dashboard(
                            RouteLink: "parametreDashboard",
                            titre: "Parametre",
                          )));
            },
          ),
          Padding(
            padding: EdgeInsets.all(14.0),
            child: Text("Autres"),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Laissez un avis sur PlayStore"),
            onTap: () {},
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text("Licences et librairies"),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationIcon: Image.asset(
                    'assets/img/ico.png',
                    height: 30,
                  ),
                  applicationName: 'Go Survey',
                  applicationVersion: '\nV0.0.1',
                  applicationLegalese: '2022 Power by Joviale',
                  children: <Widget>[Text('')],
                );
              }),
          ListTile(
            leading: Icon(Icons.bluetooth),
            title: Text("Partager Go Survey"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key, required this.RouteLink});
  final String RouteLink;
  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // activation du scroking dans des petites appareils
    return SingleChildScrollView(
      child: Column(
        children: [
          HeaderDashboard(size: size),
          widget.RouteLink == "mainDashboard"
              ? MainDashboard()
              : widget.RouteLink == "oldEnquete"
                  ? OldEnquete()
                  : NewEnquete(),
        ],
      ),
    );
  }
}
