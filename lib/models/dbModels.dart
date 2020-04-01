class User {
  int id;
  String name;
  String surname;

  User({
		this.id,
    this.name,
    this.surname
  });

  factory User.fromMap(Map<String, dynamic> json) => new User(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
      );
      
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "surname": surname,
      };
}

class Products {
  int id;
  String name;
  String category;
  double calories;
  double squi;
  double fats;
  double carboh;
  DateTime date;

  Products({
		this.id,
    this.name,
    this.category,
    this.calories,
    this.squi,
    this.fats,
    this.carboh,
    this.date,
  });

  factory Products.fromMap(Map<String, dynamic> json) => new Products(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        calories: json["calories"],
        squi: json["squi"],
        fats: json["fats"],
        carboh: json["carboh"],
        date: DateTime.fromMillisecondsSinceEpoch(json["date"]),
      );
      
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "category": category,
        "calories": calories,
        "squi": squi,
        "fats": fats,
        "carboh": carboh,
        "date": epochFromDate( date ),
      };

      epochFromDate(DateTime dt) {  
        return dt.millisecondsSinceEpoch ~/ 1000;
      }
}