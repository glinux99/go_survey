class QuestionnaireModel {
  int? id;
  String? question;
  String? typeReponse;
  int? userId;
  int? rubriqueId;
  questionnaireMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['question'] = question!;
    mapping['typeReponse'] = typeReponse!;
    mapping['userId'] = userId!;
    mapping['rubriqueId'] = rubriqueId!;
    return mapping;
  }
}
