import 'package:go_survey/models/database/crud_operationService.dart';
import 'package:go_survey/models/modalites/modalite.dart';

class ModaliteService {
  late CrudOperation _savedataSurvey;
  ModaliteService() {
    _savedataSurvey = CrudOperation();
  }

  saveModalite(ModaliteModel recensement) async {
    return await _savedataSurvey.insertData(
        "modalites", recensement.modaliteMap());
  }

  getModaliteById(id) async {
    return await _savedataSurvey.readDataById('modalites', id);
  }
}
