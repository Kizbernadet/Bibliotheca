// Création d'une classe pour les auteurs
class Author {
  // Les attributs de classe
  String? id;
  String? name;
  String? firstname;
  String? mail;

  // Constructeur de la classe
  Author({this.id, this.name, this.firstname, this.mail});

  Author.fromMap(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    firstname = json["firstname"];
    mail = json["mail"];
  }

  // get desciption => null;
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["name"] = name;
    map["firstname"] = firstname;
    map["mail"] = mail;
    return map;
  }
}
