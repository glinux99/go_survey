class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['name'] = name!;
    mapping['email'] = email!;
    mapping['phone'] = phone!;
    mapping['password'] = password!;
    return mapping;
  }
}
