import 'package:go_survey/models/database/crud_operationService.dart';
import 'package:go_survey/models/questionnaires/questionnaire.dart';

class QuestionnaireService {
  late CrudOperation _savedataSurvey;
  QuestionnaireService() {
    _savedataSurvey = CrudOperation();
  }

  saveQuestion(QuestionnaireModel recensement) async {
    return await _savedataSurvey.insertData(
        "questionnaires", recensement.questionnaireMap());
  }

  getQuestionByIdRubrique(rubriqueValue) async {
    return await _savedataSurvey.readDataByContraints(
        'questionnaires', 'rubriqueId', rubriqueValue);
  }

  getQuestionById(id) async {
    return await _savedataSurvey.readDataById('questionnaires', id);
  }
}
