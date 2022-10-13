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

  getById() async {
    return await _savedataUser.readDataById('reponses', 1);
  }

  getReponsesByRubriqueId(rubriqueId) async {
    return await _savedataUser.readDataByContraints(
        'reponses', 'rubriqueId', rubriqueId);
  }

  getAllReponse() async {
    return await _savedataUser.readData('reponses');
  }

  getReponseById(id) async {
    return await _savedataUser.readDataById('reponses', id);
  }
}
