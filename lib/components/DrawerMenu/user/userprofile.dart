import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_survey/components/DrawerMenu/user/alteruserprofile.dart';
import 'package:go_survey/models/users/user.dart';
import 'package:go_survey/models/users/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MonProfile extends StatefulWidget {
  final User userUnique;
  const MonProfile({super.key, required this.userUnique});
  @override
  State<MonProfile> createState() => _MonProfileState();
}

class _MonProfileState extends State<MonProfile> {
  Widget build(BuildContext context) {
    double coverHeight = MediaQuery.of(context).size.height / 3;
    return Scaffold(
        appBar: AppBar(
          title: Text("Mon Profile"),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            ContentImageProfile(coverHeight),
            ContentTextProfile(),
          ],
        ));
  }

  Widget ContentTextProfile() {
    return Container(
        child: Column(
      children: [
        Text(
          widget.userUnique.name.toString(),
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Text(
          widget.userUnique.email.toString(),
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialIcon(Icons.bar_chart, () {}),
            SizedBox(
              width: 12,
            ),
            SocialIcon(Icons.circle_notifications, () {}),
            SizedBox(
              width: 12,
            ),
            SocialIcon(Icons.mode_edit, () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileEdit(
                            userUnique: widget.userUnique,
                          )));
            }),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {},
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Enquetes'),
                  SizedBox(
                    height: 2,
                  ),
                  Text("2233")
                ],
              ),
            )
          ],
        ),
      ],
    ));
  }

  Stack ContentImageProfile(double coverHeight) {
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: coverHeight / 4),
              child: profileMethode(coverHeight)),
          Positioned(
              top: coverHeight - (coverHeight / 4),
              child: CoverImageProfile(coverHeight / 2)),
        ]);
  }

  Widget SocialIcon(IconData icon, ontap) => CircleAvatar(
        radius: 25,
        child: Material(
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: InkWell(
            onTap: ontap,
            child: Center(
                child: Icon(
              icon,
              size: 32,
            )),
          ),
        ),
      );
  Widget profileMethode(double imageHeight) {
    return Container(
      child: Container(
        color: Colors.green,
        child: Image.asset(
          'assets/img/1.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: imageHeight,
        ),
      ),
    );
  }

  Widget CoverImageProfile(imageHeight) => Container(
        child: CircleAvatar(
          backgroundColor: Colors.green,
          foregroundImage: AssetImage("assets/img/default.png"),
          child: Text(
            'user',
          ),
          radius: imageHeight / 2,
        ),
      );
}
