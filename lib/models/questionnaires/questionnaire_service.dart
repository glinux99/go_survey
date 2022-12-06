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

  getQuestionByIdRubrique2(rubriqueValue) async {
    return await _savedataSurvey.readDataByContraints(
        'questionnaires', 'rubriqueId', rubriqueValue);
  }

  getQuestionByIdRubrique(rubriqueValue) async {
    return await _savedataSurvey.readDataByQuestion(
        'questionnaires', 'rubriqueId', rubriqueValue);
  }

  getQuestionById(id) async {
    return await _savedataSurvey.readDataById('questionnaires', id);
  }

  getQuestionUpdate(id, data) async {
    return await _savedataSurvey.updateDataQuery(
        'questionnaires', 'question', data, id);
  }

  getAll() async {
    return await _savedataSurvey.readData('questionnaires');
  }

  deleteQuestion(id) async {
    return await _savedataSurvey.deleteDataById('questionnaires', id);
  }
}
