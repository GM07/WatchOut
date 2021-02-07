class FoodList {
  DateTime date;
  List<Ingredient> items;

  FoodList({this.items, this.date});

  Map toJson() {
    List<Map> items =
        this.items != null ? this.items.map((i) => i.toJson()).toList() : null;

    return {'date': date.toString(), 'items': items};
  }
}

class DechetList {
  String nom;
  int quantite;
  DechetList({this.nom, this.quantite});

  Map toJson() {
    return {'nom': nom, 'quantite': quantite.toString};
  }
}

class Ingredient {
  String title;
  DateTime date;
  int quantity;
  bool bought;

  Ingredient({this.title, this.date, this.quantity, this.bought = false});

  Ingredient.fromMap(Map<String, dynamic> map) {
    this.title = map['title'];
    this.quantity = map['quantity'];
    this.date = DateTime.parse(map['date']);
  }

  Ingredient.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.quantity = 0;
    this.bought = false;
    this.date = DateTime.now();
  }

  Map toJson() =>
      {'date': date.toString(), 'title': title, 'quantity': quantity};
}

List<Ingredient> generateIngredients(int length) {
  return List.generate(
      length,
      (int index) => Ingredient(
          date: DateTime.now(),
          quantity: index,
          title: DateTime.now().hashCode.toString()));
}

List<Ingredient> testList = List.generate(
    10,
    (int index) => Ingredient(
        date: DateTime.now(),
        quantity: index,
        title: DateTime.now().hashCode.toString()));
