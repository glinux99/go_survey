import 'package:go_survey/models/database/crud_operationService.dart';
import 'package:go_survey/models/recensements/recensement.dart';

class RecensementService {
  late CrudOperation _savedataSurvey;
  RecensementService() {
    _savedataSurvey = CrudOperation();
  }

  saveSurvey(RecensementModel recensement) async {
    return await _savedataSurvey.insertData(
        "recensements", recensement.recensementMap());
  }

  getSurveyById(id) async {
    return await _savedataSurvey.readDataById('recensements', id);
  }
}
