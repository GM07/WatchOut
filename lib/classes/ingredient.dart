class Ingredient {
  String title;
  DateTime date;
  int quantity;
  bool bought;

  Ingredient({this.title, this.date, this.quantity, this.bought = false});

  Ingredient.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.quantity = 0;
    this.bought = false;
    this.date = DateTime.now();
  }
}

List<Ingredient> testList = List.generate(
    10,
    (int index) => Ingredient(
        date: DateTime.now(),
        quantity: index,
        title: DateTime.now().hashCode.toString()));
