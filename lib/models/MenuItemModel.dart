class MenuItemModel {
  int id;
  int menu_id;
  String name;
  int price;
  String image;
  String description;
  bool isChecked;
  String  toppingName;
  // List <String> toppingPrice;

  MenuItemModel({
    this.id=0,
    this.menu_id=0,
    this.description="",
    this.name="empty",
    this.price=0,
    this.image="",
    this.isChecked=false,
    this.toppingName="",
    // required this.toppingPrice
  });

}
