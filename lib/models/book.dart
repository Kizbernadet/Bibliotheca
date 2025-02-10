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
}
