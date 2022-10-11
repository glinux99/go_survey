class ReponsesModel {
  int? id;
  String? reponse;
  int? questionId;
  int? userId;
  reponseQuestionMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['reponse'] = reponse!;
    mapping['questionId'] = questionId!;
    mapping['userId'] = userId!;
    return mapping;
  }
}
