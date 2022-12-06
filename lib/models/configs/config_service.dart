import 'package:go_survey/models/configs/config.dart';
import 'package:go_survey/models/database/crud_operationService.dart';

class ConfigService {
  late CrudOperation _savedataSurvey;
  ConfigService() {
    _savedataSurvey = CrudOperation();
  }

  saveConfig(ConfigModel data) async {
    return await _savedataSurvey.insertData("configs", data.configMap());
  }

  updateConfig(id, champ, champValue) async {
    return await _savedataSurvey.updateDataQuery(
        'configs', champ, champValue, id);
  }

  getAllConfigs() async {
    return await _savedataSurvey.readData('configs');
  }

  getConfigById(id) async {
    return await _savedataSurvey.readDataById('configs', id);
  }
}
