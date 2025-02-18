class Book {
  int? id;
  String? libelle;
  String? description;
  String? image;
  int? nbPage;
  int? authorId; // Clé étrangère vers l'auteur
  int? categorieId; // Clé étrangère vers la catégorie

  Book({
    this.id,
    this.libelle,
    this.description,
    this.image,
    this.nbPage,
    this.authorId,
    this.categorieId,
  });

  // Méthode pour créer un objet Book à partir d'une Map
  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      libelle: map['libelle'],
      description: map['description'],
      image: map['image'],
      nbPage: map['nbPage'],
      authorId: map['authorId'],
      categorieId: map['categorieId'],
    );
  }

  // Méthode pour convertir un objet Book en Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'libelle': libelle,
      'description': description,
      'image': image,
      'nbPage': nbPage,
      'authorId': authorId,
      'categorieId': categorieId,
    };
  }
}
