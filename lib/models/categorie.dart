// Creation d'une classe Categorie pour les livres
class Categorie {
  // Attributs d'instance
  int? id;
  String? libelle;

  Categorie({this.id, this.libelle});

  Categorie.fromMap(Map<String, dynamic> json) {
    id = json["id"];
    libelle = json["libelle"];
  }

  // get desciption => null;
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["libelle"] = libelle;
    return map;
  }
}
