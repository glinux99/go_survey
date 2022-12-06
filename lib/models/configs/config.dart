class ConfigModel {
  int? id;
  int? userId;
  String? theme;
  String? serveur;
  String? tailleTexte;
  int? langue;
  int? misAjourForm;
  int? sendAuto;
  configMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['userId'] = userId ?? null;
    mapping['theme'] = theme ?? null;
    mapping['serveur'] = serveur ?? null;
    mapping['tailleTexte'] = tailleTexte ?? null;
    mapping['langue'] = langue ?? null;
    mapping['misAjourForm'] = misAjourForm ?? null;
    mapping['sendAuto'] = sendAuto ?? null;
    return mapping;
  }
}
