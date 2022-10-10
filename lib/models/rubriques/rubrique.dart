class RubriqueModel {
  int? id;
  String? description;
  int? userId;
  rubriqueMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['description'] = description!;
    mapping['userId'] = userId!;
    return mapping;
  }
}
