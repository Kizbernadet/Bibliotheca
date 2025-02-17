import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/models/book.dart';
import 'package:gestion_bibliotheque/controllers/book_controller.dart';

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

  @override
  void initState() {
    super.initState();
    isEditing = widget.book !=
        null; // Vérifie si une catégorie est passée pour activer le mode édition
    if (widget.book != null) {
      txtBookLibelle.text = widget.book!
          .libelle!;
      txtBookDescription.text = widget.book!
          .description!;
      txtBookImage.text = widget.book!
          .nbPage! as String;// Pré-remplit le champ texte si on modifie une catégorie
    }
  }

  /// Construit l'interface utilisateur de l'écran d'édition
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? "Modification" : "Ajout"),
        ),
        body: Form(
          key: keyform,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Bouton pour sélectionner une icône ou une image (pas encore implémenté)
              MaterialButton(
                onPressed: () {},
                child: const CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.category),
                ),
              ),
              // Champ de saisie pour le nom du livre
              TextFormField(
                controller: txtBookLibelle,
                decoration:
                    const InputDecoration(labelText: "Nom du livre"),
                validator: (value) =>
                    value!.isEmpty ? "Champ Obligatoire" : null,
              ),
              TextFormField(
                controller: txtBookDescription,
                decoration:
                    const InputDecoration(labelText: "Description"),
                validator: (value) =>
                    value!.isEmpty ? "Champ Obligatoire" : null,
              ),
              TextFormField(
                controller: txtBookImage,
                decoration:
                    const InputDecoration(labelText: "Image"),
                validator: (value) =>
                    value!.isEmpty ? "Champ Obligatoire" : null,
              ),
              TextFormField(
                controller: txtBooknbPage,
                decoration:
                    const InputDecoration(labelText: "Nombre de pages"),
                validator: (value) =>
                    value!.isEmpty ? "Champ Obligatoire" : null,
              ),
              TextFormField(
                controller: txtBookDescription,
                decoration:
                    const InputDecoration(labelText: "Description"),
                validator: (value) =>
                    value!.isEmpty ? "Champ Obligatoire" : null,
              ),
              const SizedBox(
                height: 20,
              ),
              // Bouton pour enregistrer la catégorie
              ElevatedButton(
                onPressed: () {
                  _submit();
                },
                child: Text(isEditing ? "Modifier" : "Ajouter"),
              )
            ],
          ),
        ),
      );

  /// Fonction permettant de soumettre le formulaire et d'enregistrer la catégorie
  Future<void> _submit() async {
    if (keyform.currentState!.validate()) {
      // Vérifie que le formulaire est valide
      if (widget.book == null) {
        // Création d'une nouvelle catégorie
        Book book = Book();
        book.libelle = txtBookLibelle.text;
        await BookController.addBook(
            book); // Appelle le contrôleur pour enregistrer
      } else {
        // Mise à jour d'une catégorie existante
        Book book = widget.book!;
        book.libelle = txtBookLibelle.text;
        await BookController.updateBook(
            book); // Mise à jour via le contrôleur
      }
      if (mounted) {
      Navigator.pop(context);
      }
    }
  }
}