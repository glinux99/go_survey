import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:go_survey/admin/dashbord.dart';
import 'package:go_survey/auth/login.dart';
import 'package:go_survey/components/screen/introduction_screen.dart';
import 'package:go_survey/save.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool show = true, logPref = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  logPref = prefs.getBool('login') ?? false;
  show = prefs.getBool("go_surveys") ?? true;
  final themeService = await ThemeService.instance;
  var initTheme = themeService.initial;
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      animationDuration: Duration(seconds: 2),
      nextScreen: show
          ? AcceuilScreen()
          : logPref
              ? Dashboard(
                  RouteLink: "mainDashboard",
                )
              : const LoginSignup(),
    );
  }
}
