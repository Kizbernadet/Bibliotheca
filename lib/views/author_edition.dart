import 'package:gestion_bibliotheque/models/author.dart';
import 'package:gestion_bibliotheque/controllers/author_controller.dart';
import 'package:flutter/material.dart';

/// Classe Stateful permettant l'ajout ou la modification d'auteurs.
/// - Si un auteur est passé en paramètre (via widget.author), l'écran agit en mode édition.
/// - Sinon, il s'agit d'un ajout d'un nouvel auteur.
class EditionAuthor extends StatefulWidget {
  final Author? author; // Auteur existant à modifier (null pour un nouvel auteur)

  const EditionAuthor({this.author, super.key});

  @override
  State<EditionAuthor> createState() => _EditionAuthorState();
}

class _EditionAuthorState extends State<EditionAuthor> {
  // Contrôleurs pour les champs de saisie
  TextEditingController txtAuthorName = TextEditingController();
  TextEditingController txtAuthorFirstname = TextEditingController();
  TextEditingController txtAuthorMail = TextEditingController();

  final keyform = GlobalKey<FormState>(); // Clé pour la validation du formulaire

  late bool isEditing; // Indique si on est en mode "édition" ou "ajout"

  @override
  void initState() {
    super.initState();
    // Détecte si un auteur est passé pour activer le mode édition
    isEditing = widget.author != null;

    // Pré-remplit les champs si un auteur est fourni
    if (isEditing) {
      txtAuthorName.text = widget.author!.name ?? '';
      txtAuthorFirstname.text = widget.author!.firstname ?? '';
      txtAuthorMail.text = widget.author!.mail ?? '';
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? "Modification d'un auteur" : "Ajout d'un auteur"),
        ),
        body: Form(
          key: keyform,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Bouton pour sélectionner une icône ou une image (à implémenter)
              MaterialButton(
                onPressed: () {},
                child: const CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person),
                ),
              ),
              // Champ de saisie pour le nom de l'auteur
              _buildTextField(
                "Nom",
                txtAuthorName,
                (value) => value!.isEmpty ? "Champ Obligatoire" : null,
              ),
              // Champ de saisie pour le prénom de l'auteur
              _buildTextField(
                "Prénom",
                txtAuthorFirstname,
                (value) => value!.isEmpty ? "Champ Obligatoire" : null,
              ),
              // Champ de saisie pour l'adresse e-mail de l'auteur
              _buildTextField(
                "Adresse Mail",
                txtAuthorMail,
                (value) {
                  if (value == null || value.isEmpty) {
                    return "Champ Obligatoire";
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
                    return "Adresse email invalide";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Bouton pour soumettre le formulaire
              ElevatedButton(
                onPressed: _submit,
                child: Text(isEditing ? "Modifier" : "Ajouter"),
              ),
            ],
          ),
        ),
      );

  /// Méthode pour construire un champ de saisie réutilisable.
  /// 
  /// @param label       Le texte qui s'affiche comme label du champ.
  /// @param controller  Le contrôleur pour gérer le texte saisi.
  /// @param validator   La fonction de validation pour vérifier le contenu du champ.
  /// 
  /// @return Un widget TextFormField prêt à être intégré dans le formulaire.
  Widget _buildTextField(String label, TextEditingController controller,
      String? Function(String?) validator) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: validator,
    );
  }

  /// Méthode pour soumettre le formulaire.
  /// 
  /// - Valide les champs du formulaire.
  /// - Si un auteur n'existe pas encore, crée un nouvel auteur.
  /// - Sinon, met à jour les informations de l'auteur existant.
  /// - Retourne à l'écran précédent une fois terminé.
  Future<void> _submit() async {
    if (keyform.currentState!.validate()) {
      if (widget.author == null) {
        // Création d'un nouvel auteur
        Author newAuthor = Author(
          name: txtAuthorName.text,
          firstname: txtAuthorFirstname.text,
          mail: txtAuthorMail.text,
        );
        await AuthorController.addAuthor(newAuthor);
      } else {
        // Mise à jour d'un auteur existant
        Author existedAuthor = widget.author!;
        existedAuthor.name = txtAuthorName.text;
        existedAuthor.firstname = txtAuthorFirstname.text;
        existedAuthor.mail = txtAuthorMail.text;
        await AuthorController.updateAuthor(existedAuthor);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}
