import 'package:go_survey/models/database/crud_operationService.dart';
import 'package:go_survey/models/users/user.dart';

class UserService {
  late CrudOperation _savedataUser;
  UserService() {
    _savedataUser = CrudOperation();
  }
  SaveUser(User user) async {
    return await _savedataUser.insertData("users", user.userMap());
  }
}
