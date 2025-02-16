// Classe de modélisation des livres
class Book {
  // Attributs d'instance de la classe Book
  int? id;
  String? libelle;
  String? description;
  String? image;
  int? nbPage;
  int? authorId;
  int? categorieId;

  // Constructeur de la classe Book
  Book({
    this.id,
    this.libelle,
    this.description,
    this.image,
    this.nbPage,
    this.authorId,
    this.categorieId,
  });

  Book.fromMap(Map<String, dynamic> json) {
    id = json["id"];
    libelle = json["libelle"];
    description = json["description"];
    image = json["image"];
    nbPage = json["nbPage"];
    authorId = json["authorId"];
    categorieId = json["categorieId"];
  }

  // get desciption => null;
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["libelle"] = libelle;
    map["image"] = image;
    map["nbPage"] = nbPage;
    map["authorId"] = authorId;
    map["categorieId"] = categorieId;
    return map;
  }
}
