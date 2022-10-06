import 'package:flutter/foundation.dart';

final String questionnaires = 'questions';

class QuestionnaireFields {
  static final String id = '_id';
  static final String description = 'description';
  static final String type_reponse = 'type_reponse';
  static final String id_rubrique = 'id_rubrique';
}

class Questionnaire {
  final int? id;
  final String description;
  final int type_reponse;
  final int id_rubrique;
  const Questionnaire({
    required this.id,
    required this.description,
    required this.type_reponse,
    required this.id_rubrique,
  });
  Questionnaire copy({
    int? id,
    String? description,
    int? type_reponse,
    int? id_rubrique,
  }) =>
      Questionnaire(
          id: id ?? this.id,
          description: description ?? this.description,
          type_reponse: type_reponse ?? this.type_reponse,
          id_rubrique: id_rubrique ?? this.id_rubrique);
  Map<String, dynamic> toJson() {
    return {
      QuestionnaireFields.id: id,
      QuestionnaireFields.description: description,
      QuestionnaireFields.type_reponse: type_reponse,
      QuestionnaireFields.id_rubrique: id_rubrique
    };
  }

  @override
  String toString() {
    return 'Questionnaire{id: $id, description: $description, type_reponse: $type_reponse, id_rubrique: $id_rubrique}';
  }
}
