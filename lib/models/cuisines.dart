class CuisineModel {
  int? id;
  String? name;
  bool? isSelected;

  CuisineModel({this.id, this.name, this.isSelected});

  CuisineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['isSelected'] = isSelected;
    return data;
  }
}