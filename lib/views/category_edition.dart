import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/models/categorie.dart';
import "package:gestion_bibliotheque/controllers/category_controller.dart";

/// Classe représentant l'écran d'édition d'une catégorie.
/// Elle permet d'ajouter ou de modifier une catégorie.
class EditionCategorie extends StatefulWidget {
  final Categorie?
      categorie; // Catégorie existante à modifier (peut être null pour une nouvelle catégorie)
  const EditionCategorie({this.categorie, super.key});

  @override
  State<EditionCategorie> createState() => _EditionCategorieState();
}

/// État de l'écran d'édition de catégorie.
class _EditionCategorieState extends State<EditionCategorie> {
  TextEditingController txtCategorie =
      TextEditingController(); // Contrôleur pour récupérer le texte du champ
  final keyform = GlobalKey<FormState>(); // Clé pour valider le formulaire

  late bool isEditing; // Variable pour savoir si on est en mode édition
  /// En fonction du mode Edition , on va ajouter ou modifier

  @override
  void initState() {
    super.initState();
    isEditing = widget.categorie !=
        null; // Vérifie si une catégorie est passée pour activer le mode édition
    if (widget.categorie != null) {
      txtCategorie.text = widget.categorie!
          .libelle!; // Pré-remplit le champ texte si on modifie une catégorie
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
              // Champ de saisie pour le nom de la catégorie
              TextFormField(
                controller: txtCategorie,
                decoration:
                    const InputDecoration(labelText: "Nouvelle Categorie"),
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
      if (widget.categorie == null) {
        // Création d'une nouvelle catégorie
        Categorie categorie = Categorie();
        categorie.libelle = txtCategorie.text;
        await CategorieController.createCategory(
            categorie); // Appelle le contrôleur pour enregistrer
      } else {
        // Mise à jour d'une catégorie existante
        Categorie categorie = widget.categorie!;
        categorie.libelle = txtCategorie.text;
        await CategorieController.updateCategory(
            categorie); // Mise à jour via le contrôleur
      }
      if (mounted) {
      Navigator.pop(context);
      }
    }
  }
}
