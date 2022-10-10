class Config {
  int? id;
  int? userId;
  String? theme;
  String? serveur;
  String? tailleTexte;
  int? langue;
  int? misAjourForm;
  int? sendAuto;
  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['userId'] = userId!;
    mapping['theme'] = theme!;
    mapping['serveur'] = serveur!;
    mapping['tailleTexte'] = tailleTexte!;
    mapping['langue'] = langue!;
    mapping['misAjourForm'] = misAjourForm!;
    mapping['sendAuto'] = sendAuto!;
    return mapping;
  }
}
