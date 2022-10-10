class RecensementModel {
  int? id;
  String? description;
  int? userId;
  recensementMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['description'] = description!;
    mapping['userId'] = userId!;
    return mapping;
  }
}
