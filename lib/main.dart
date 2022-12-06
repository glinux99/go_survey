import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:go_survey/admin/dashbord.dart';
import 'package:go_survey/auth/login.dart';
import 'package:go_survey/components/screen/introduction_screen.dart';
import 'package:go_survey/save.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

bool show = true, logPref = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  logPref = prefs.getBool('login') ?? false;
  show = prefs.getBool("go_survey") ?? true;
  runApp(const MyApp());
}

class ThemeService {
  ThemeService._();
  static late SharedPreferences prefs;
  static ThemeService? _instance;

  static Future<ThemeService> get instance async {
    if (_instance == null) {
      prefs = await SharedPreferences.getInstance();
      _instance = ThemeService._();
    }
    return _instance!;
  }

  final allThemes = <String, ThemeData>{
    'dark': darkTheme,
    'light': lightTheme,
    'pink': pinkTheme,
    'darkBlue': darkBlueTheme,
    'halloween': halloweenTheme,
  };

  String get previousThemeName {
    String? themeName = prefs.getString('previousThemeName');
    if (themeName == null) {
      final isPlatformDark =
          WidgetsBinding.instance!.window.platformBrightness == Brightness.dark;
      themeName = isPlatformDark ? 'light' : 'dark';
    }
    return themeName;
  }

  get initial {
    String? themeName = prefs.getString('theme');
    if (themeName == null) {
      final isPlatformDark =
          WidgetsBinding.instance!.window.platformBrightness == Brightness.dark;
      themeName = isPlatformDark ? 'dark' : 'light';
    }
    return allThemes[themeName];
  }

  save(String newThemeName) {
    var currentThemeName = prefs.getString('theme');
    if (currentThemeName != null) {
      prefs.setString('previousThemeName', currentThemeName);
    }
    prefs.setString('theme', newThemeName);
  }

  ThemeData getByName(String name) {
    return allThemes[name]!;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

// Demander l autorisation au system android ou ios de vouloir creer un dossier et y enregistrer des donnees si possible
  createDir() async {
    Directory? directory;
    String monDossier = "";
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          // print(directory!.path);

          List<String> dossiers = directory!.path.split('/');
          for (var i = 0; i < dossiers.length; i++) {
            String dossier = dossiers[i];
            if (dossier != "Android") {
              monDossier += "/$dossier";
            } else {
              break;
            }
          }
          monDossier = "$monDossier/GoSurvey";
          directory = Directory(monDossier);
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        }
      }
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    createDir();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isPlatformDark =
        WidgetsBinding.instance!.window.platformBrightness == Brightness.dark;

    Color animated = isPlatformDark ? Colors.black : Colors.green;
    final initTheme = isPlatformDark ? darkTheme : lightTheme;
    return ThemeProvider(
      initTheme: initTheme,
      builder: (_, myTheme) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: myTheme,
            debugShowCheckedModeBanner: false,
            home: AnimatedScreen(
              animated: animated,
            ));
      },
    );
  }
}

class AnimatedScreen extends StatefulWidget {
  const AnimatedScreen({super.key, required this.animated});
  final Color animated;
  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/lotties/loading.json'),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      splashIconSize: 255,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 2),
      nextScreen: show
          ? AcceuilScreen()
          : logPref
              ? const Dashboard(
                  RouteLink: "mainDashboard",
                )
              : const LoginSignup(),
    );
  }
}
