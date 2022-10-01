import 'package:flutter/material.dart';
import 'package:go_survey/auth/login.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AcceuilScreen extends StatelessWidget {
  AcceuilScreen({super.key});
  final List<PageViewModel> pages = [
    PageViewModel(
        title: "Go Survey",
        body: "Description",
        footer: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 39, 176, 46),
            // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            // textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
          ),
          child: const Text("Debuter les statistiques"),
          onPressed: () async {
            final url = Uri.parse('https://www.subnetcongo.net');
            if (await canLaunchUrl(url)) {
              // await launchUrl(url);
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
        ),
        image: Center(
          child: Image.asset('assets/img/1.jpg'),
        ),
        decoration: const PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
    PageViewModel(
        title: "Go Survey",
        body: "Description",
        footer: ElevatedButton(
          child: const Text("Debuter les statistiques"),
          onPressed: () async {
            final url = Uri.parse('https://www.subnetcongo.net');
            if (await canLaunchUrl(url)) {
              // await launchUrl(url);
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 39, 176, 46),
            // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            // textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
          ),
        ),
        image: Center(
          child: Image.asset('assets/img/2.png'),
        ),
        decoration: const PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
    PageViewModel(
        title: "Go Survey",
        body: "Description",
        footer: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 39, 176, 46),
            // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            // textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
          ),
          child: const Text("Debuter les statistiques"),
          onPressed: () async {
            final url = Uri.parse('https://www.subnetcongo.net');
            if (await canLaunchUrl(url)) {
              // await launchUrl(url);
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
        ),
        image: Center(
          child: Image.asset('assets/img/2.png'),
        ),
        decoration: const PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: IntroductionScreen(
          pages: pages,
          dotsDecorator: const DotsDecorator(
              size: Size(20, 20),
              activeColor: Color.fromARGB(255, 54, 244, 63),
              activeSize: Size.square(15)),
          showDoneButton: true,
          done: const Text("Suivant"),
          showSkipButton: true,
          skip: const Text("Ignorer"),
          showNextButton: true,
          next: const Icon(
            Icons.arrow_forward,
            size: 20,
          ),
          onDone: () => onDone(context),
          curve: Curves.bounceOut,
        ),
      ),
    ));
  }

  void onDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("go_survey", false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginSignup()));
  }
}

// var _url = Uri.parse("www.subnetcongo.net");
// _launchURL() async {
//   if (!await launchUrl(_url)) throw 'Impossible d\'ouvrir le lien $_url';
// }
