import 'package:go_survey/models/database/crud_operationService.dart';
import 'package:go_survey/models/users/user.dart';

class UserService {
  late CrudOperation _savedataUser;
  UserService() {
    _savedataUser = CrudOperation();
  }
  saveUser(User user) async {
    return await _savedataUser.insertData("users", user.userMap());
  }

  loginUser(email, password) async {
    return await _savedataUser.readDataLogin('users', email, password);
  }

  // update(User data) async {
  //   return await _savedataUser.updateData('users', data.userMap());
  // }
  update(id, champ, champValue) async {
    return await _savedataUser.updateDataQuery('users', champ, champValue, id);
  }

  getUserById(id) async {
    return await _savedataUser.readDataById('users', id);
  }
}
