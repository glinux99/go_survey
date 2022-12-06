import 'package:flutter/material.dart';
import 'package:go_survey/models/configs/config.dart';
import 'package:go_survey/models/configs/config_service.dart';

class ServeurAccess extends StatelessWidget {
  const ServeurAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuration du Serveur"),
      ),
      body: ServeurAccessHome(),
    );
  }
}

class ServeurAccessHome extends StatefulWidget {
  const ServeurAccessHome({super.key});

  @override
  State<ServeurAccessHome> createState() => _ServeurAccessHomeState();
}

class _ServeurAccessHomeState extends State<ServeurAccessHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          serveurwidget(
            titre: "Nom du Serveur",
            hintText: "GoSurvey Server",
            champ: "serveur",
          ),
          serveurwidget(
            titre: "Url",
            hintText: "https://",
            champ: "",
          ),
          serveurwidget(
            titre: "Nom d'Utilisateur",
            hintText: "GoSurvey Server",
          ),
          serveurwidget(
            titre: "Mot de pass",
            hintText: "************",
            obscure: true,
          ),
        ],
      ),
    );
  }
}

class serveurwidget extends StatefulWidget {
  const serveurwidget(
      {Key? key,
      required this.titre,
      required this.hintText,
      this.obscure,
      this.champ})
      : super(key: key);

  final String? champ;
  final String titre, hintText;
  final bool? obscure;

  @override
  State<serveurwidget> createState() => _serveurwidgetState();
}

class _serveurwidgetState extends State<serveurwidget> {
  late List<ConfigModel> configList;

  var _paramsService = ConfigService();

  @override
  void initState() {
    super.initState();
    configList = <ConfigModel>[];
    // getAllConfigs();
  }

  getAllConfigs() async {
    var result = _paramsService.getAllConfigs();
    result.forEach((e) {
      var config = ConfigModel();
      config.serveur = e['serveur'];
      configList.add(config);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(widget.titre),
            subtitle: TextField(
              onChanged: (value) async {
                var output =
                    await _paramsService.updateConfig(1, widget.champ, value);
                var config = ConfigModel();
                config.serveur = value.toString();
                config.userId = 1;
                output = _paramsService.saveConfig(config);
                print(output);
              },
              obscureText: widget.obscure ?? false,
              decoration: InputDecoration(
                  hintText: widget.hintText, border: InputBorder.none),
            ),
          ),
          Divider(
            color: Colors.green,
            height: 2,
          )
        ],
      ),
    );
  }
}
