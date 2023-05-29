class MenuItemModel {
  int id;
  int menu_id;
  String name;
  int price;
  String image;
  String type;
  String description;
  bool isChecked;
  List<dynamic> menuItemIngredients;

  MenuItemModel({
    this.id=0,
    this.menu_id=0,
    this.description="",
    this.name="empty",
    this.type="",
    this.price=0,
    this.image="",
    this.isChecked=false,
    this.menuItemIngredients = const [],
  });

}
