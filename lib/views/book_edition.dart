import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/controllers/author_controller.dart';
import 'package:gestion_bibliotheque/controllers/category_controller.dart';
import 'package:gestion_bibliotheque/models/author.dart';
import 'package:gestion_bibliotheque/models/book.dart';
import 'package:gestion_bibliotheque/controllers/book_controller.dart';
import 'package:gestion_bibliotheque/models/categorie.dart';

class EditionBook extends StatefulWidget {
  final Book?
      book; // Catégorie existante à modifier (peut être null pour une nouvelle catégorie)
  const EditionBook({this.book, super.key});

  @override
  State<EditionBook> createState() => _EditionBookState();
}

class _EditionBookState extends State<EditionBook> {
  TextEditingController txtBookLibelle =
      TextEditingController();
  TextEditingController txtBookDescription =
      TextEditingController();
  TextEditingController txtBookImage =
      TextEditingController();
  TextEditingController txtBooknbPage =
      TextEditingController(); // Contrôleur pour récupérer le texte du champ
  final keyform = GlobalKey<FormState>(); // Clé pour valider le formulaire

  late bool isEditing; // Variable pour savoir si on est en mode édition
  /// En fonction du mode Edition , on va ajouter ou modifier
  List<Author> authorsList = []; // Liste des auteurs
  List<Categorie> categoriesList = []; // Liste des catégories
  int? selectedAuthorId; // Auteur sélectionné
  int? selectedCategoryId; // Catégorie sélectionnée


  @override
void initState() {
  super.initState();
  isEditing = widget.book != null;
  if (widget.book != null) {
    txtBookLibelle.text = widget.book!.libelle!;
    txtBookDescription.text = widget.book!.description!;
    txtBookImage.text = widget.book!.image!;
    txtBooknbPage.text = widget.book!.nbPage.toString();
    selectedAuthorId = widget.book!.authorId;
    selectedCategoryId = widget.book!.categorieId;
  }
  _loadData(); // Charge les auteurs et catégories
}

Future<void> _loadData() async {
  authorsList = await AuthorController.authorsList();
  categoriesList = await CategorieController.categoriesList();
  setState(() {}); // Met à jour l'interface
}


  /// Construit l'interface utilisateur de l'écran d'édition
  @override
Widget build(BuildContext context) {
  // Vérifie si les listes d'auteurs ou de catégories sont vides
  if (authorsList.isEmpty || categoriesList.isEmpty) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Modification" : "Ajout d'un livre"),
      ),
      body: Center(
        child: Text(
          "Aucun auteur ou catégorie disponible. Veuillez en ajouter avant de créer un livre.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  // Si les listes ne sont pas vides, affiche le formulaire
  return Scaffold(
    appBar: AppBar(
      title: Text(isEditing ? "Modification" : "Ajout d'un livre"),
    ),
    body: Form(
      key: keyform,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Bouton pour sélectionner une icône ou une image
          MaterialButton(
            onPressed: () {},
            child: const CircleAvatar(
              radius: 50,
              child: Icon(Icons.category),
            ),
          ),
          // Champ de saisie pour le titre du livre
          TextFormField(
            controller: txtBookLibelle,
            decoration: const InputDecoration(labelText: "Nom du livre"),
            validator: (value) => value!.isEmpty ? "Champ Obligatoire" : null,
          ),
          TextFormField(
            controller: txtBookDescription,
            decoration: const InputDecoration(labelText: "Description"),
            validator: (value) => value!.isEmpty ? "Champ Obligatoire" : null,
          ),
          TextFormField(
            controller: txtBookImage,
            decoration: const InputDecoration(labelText: "Image"),
            validator: (value) => value!.isEmpty ? "Champ Obligatoire" : null,
          ),
          TextFormField(
            controller: txtBooknbPage,
            decoration: const InputDecoration(labelText: "Nombre de pages"),
            validator: (value) => value!.isEmpty ? "Champ Obligatoire" : null,
          ),
          // Dropdown pour sélectionner un auteur
          DropdownButtonFormField<int>(
            value: selectedAuthorId,
            items: authorsList.map((author) {
              return DropdownMenuItem<int>(
                value: author.id,
                child: Text(author.name ?? "Auteur inconnu"),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedAuthorId = value;
              });
            },
            decoration: const InputDecoration(labelText: "Auteur"),
            validator: (value) =>
                value == null ? "Veuillez sélectionner un auteur" : null,
          ),
          const SizedBox(height: 20), // Espacement
          // Dropdown pour sélectionner une catégorie
          DropdownButtonFormField<int>(
            value: selectedCategoryId,
            items: categoriesList.map((category) {
              return DropdownMenuItem<int>(
                value: category.id,
                child: Text(category.libelle ?? "Catégorie inconnue"),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCategoryId = value;
              });
            },
            decoration: const InputDecoration(labelText: "Catégorie"),
            validator: (value) =>
                value == null ? "Veuillez sélectionner une catégorie" : null,
          ),
          const SizedBox(height: 20),
          // Bouton pour enregistrer
          ElevatedButton(
            onPressed: () {
              _submit();
            },
            child: Text(isEditing ? "Modifier" : "Ajouter"),
          ),
        ],
      ),
    ),
  );
}


  /// Fonction permettant de soumettre le formulaire et d'enregistrer la catégorie
  Future<void> _submit() async {
  if (keyform.currentState!.validate()) {
    if (widget.book == null) {
      // Création d'un nouveau livre
      Book newBook = Book(
        libelle: txtBookLibelle.text,
        description: txtBookDescription.text,
        image: txtBookImage.text,
        nbPage: int.tryParse(txtBooknbPage.text),
        authorId: selectedAuthorId,
        categorieId: selectedCategoryId,
      );
      await BookController.addBook(newBook);
    } else {
      // Mise à jour d'un livre existant
      Book existedBook = widget.book!;
      existedBook.libelle = txtBookLibelle.text;
      existedBook.description = txtBookDescription.text;
      existedBook.image = txtBookImage.text;
      existedBook.nbPage = int.tryParse(txtBooknbPage.text);
      existedBook.authorId = selectedAuthorId;
      existedBook.categorieId = selectedCategoryId;
      await BookController.updateBook(existedBook);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }
}

}