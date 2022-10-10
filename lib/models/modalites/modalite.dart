class ModaliteModel {
  int? id;
  String? description;
  int? userId;
  modaliteMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['description'] = description!;
    mapping['userId'] = userId!;
    return mapping;
  }
}
