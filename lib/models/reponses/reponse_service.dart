import 'package:go_survey/models/database/crud_operationService.dart';
import 'package:go_survey/models/reponses/reponses.dart';

class ReponseService {
  late CrudOperation _savedataUser;
  ReponseService() {
    _savedataUser = CrudOperation();
  }
  saveReponses(ReponsesModel user) async {
    return await _savedataUser.insertData(
        "reponses", user.reponseQuestionMap());
  }

  getReponsesByQuestionId(questionId) async {
    return await _savedataUser.readDataByContraints(
        'reponses', 'questionId', questionId);
  }

  getReponseById(id) async {
    return await _savedataUser.readDataById('reponses', id);
  }
}
