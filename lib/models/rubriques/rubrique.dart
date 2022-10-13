class RubriqueModel {
  int? id;
  String? description;
  int? userId;
  int? questCount;
  rubriqueMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['description'] = description!;
    mapping['userId'] = userId!;
    mapping['questCount'] = questCount!;
    return mapping;
  }
}
