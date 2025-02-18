// Création d'une classe pour les auteurs
class Author {
  // Les attributs de classe
  int? id;
  String? name;
  String? firstname;
  String? mail;

  // Constructeur de la classe
  Author({this.id, this.name, this.firstname, this.mail});

  factory Author.fromMap(Map<String, dynamic> map) {
    return Author(
      id : map['id'] as int?, // Si id est un int, ça va.
      name : map['name'], // Assure-toi que c'est bien un String.
      firstname : map['firstname']?.toString(), // Convertit en String si besoin.
      mail : map['mail']?.toString(), 
    ); // Convertit en String si besoin.
  }

  // get desciption => null;
   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'firstname': firstname,
      'mail': mail,
    };
  }
}
