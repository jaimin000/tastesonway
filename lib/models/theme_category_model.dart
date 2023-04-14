class ThemeCategoryModel {
  String categoryName;
  dynamic categoryIndex;

  ThemeCategoryModel({this.categoryName="", this.categoryIndex=0});

  factory ThemeCategoryModel.fromJson(Map<String, dynamic> json) {
    return ThemeCategoryModel(
      categoryName: json['categoryName'] ?? "",
      categoryIndex: json['categoryIndex'] ?? 0,
    );
  }
}