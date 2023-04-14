class ThemeImageModel{
  String id;
  String name;
  String picture;


  ThemeImageModel({this.id="",this.name="",this.picture=""});

  ThemeImageModel.fromJson(json)
      :  id = json['id'].toString(),
        name = json['name'].toString(),
        picture = json['picture'].toString();

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'picture': picture,
  };
}
