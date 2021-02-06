class Ingredient {
  String title;
  DateTime date;
  int quantity;
  bool bought;

  Ingredient({this.title, this.date, this.quantity, this.bought = false});
}

List<Ingredient> testList = List.generate(
    10,
    (int index) => Ingredient(
        date: DateTime.now(),
        quantity: index,
        title: DateTime.now().hashCode.toString()));
