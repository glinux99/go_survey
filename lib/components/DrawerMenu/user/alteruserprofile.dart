import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_survey/components/colors/colors.dart';
import 'package:go_survey/models/users/user.dart';
import 'package:go_survey/models/users/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEdit extends StatefulWidget {
  final User userUnique;
  const ProfileEdit({super.key, required this.userUnique});
  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  Widget build(BuildContext context) {
    double coverHeight = MediaQuery.of(context).size.height / 3;
    return Scaffold(
        appBar: AppBar(
          title: Text("Editer mon profile"),
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
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: widget.userUnique.name.toString(),
                icon: Icon(
                  Icons.person,
                  color: kGreen,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.email,
                    color: kGreen,
                  ),
                  hintText: widget.userUnique.email.toString()),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  icon: Icon(
                    FontAwesomeIcons.lock,
                    color: kGreen,
                  ),
                  hintText: '******************'),
            ),
            SizedBox(
              height: 16,
            ),
            TextButton(
              onPressed: () async {
                var user = User();
                var userservice = UserService();
                var logPref = await SharedPreferences.getInstance();
                var result = await userservice.loginUser(
                    widget.userUnique.email.toString(),
                    widget.userUnique.password.toString());
                print(result);
                result.forEach((el) {
                  setState(() {
                    user.name = nameController.text != ''
                        ? nameController.text
                        : el['name'];
                    user.email = emailController.text != ''
                        ? emailController.text
                        : el['email'].toString();
                    user.phone = el['phone'];
                    user.id = el['id'];
                    user.password = passwordController.text != ''
                        ? passwordController.text
                        : el['password'].toString();
                  });
                });
                result = userservice.update(user);
              },
              child: Text(
                "Enregistrer",
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                  side: const BorderSide(width: 1, color: kGrey),
                  minimumSize: const Size(145, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  // primary: kWhite,
                  backgroundColor: kGreen),
            ),
            SizedBox(
              height: 16,
            ),
            Divider(
              height: 2,
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
                SocialIcon(Icons.save, () {
                  print('ok');
                }),
                SizedBox(
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
        ),
      )),
    );
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
          foregroundImage: AssetImage("assets/img/1.jpg"),
          child: Text(
            'user',
          ),
          radius: imageHeight / 2,
        ),
      );
}
