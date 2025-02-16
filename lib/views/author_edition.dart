import 'package:gestion_bibliotheque/models/author.dart';
import 'package:gestion_bibliotheque/controllers/author_controller.dart';
import 'package:flutter/material.dart';

class EditionAuthor extends StatefulWidget {
  final Author?
      author; // Catégorie existante à modifier (peut être null pour une nouvelle catégorie)
  const EditionAuthor({this.author, super.key});

  @override
  State<EditionAuthor> createState() => _EditionAuthorState();
}

class _EditionAuthorState extends State<EditionAuthor> {
  TextEditingController txtAuthorName =
      TextEditingController();
  TextEditingController txtAuthorFirstname =
      TextEditingController();
  TextEditingController txtAuthorMail =
      TextEditingController();
   // Contrôleur pour récupérer le texte du champ
  final keyform = GlobalKey<FormState>();
  late bool isEditing;

  @override
  void initState() {
    super.initState();
    isEditing = widget.author !=
        null; // Vérifie si une catégorie est passée pour activer le mode édition
    if (widget.author != null) {
      txtAuthorName.text = widget.author!
          .name! ;
      txtAuthorFirstname.text = widget.author!
          .firstname! ;
      txtAuthorMail.text = widget.author!
          .mail! ; // Pré-remplit le champ texte si on modifie une catégorie
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
          title: Text(isEditing ? "Modification" : "Ajout d'un nouvel auteur"),
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
                  child: Icon(Icons.person),
                ),
              ),
              // Champ de saisie pour le nom de l'auteur
              TextFormField(
                controller: txtAuthorName,
                decoration:
                    const InputDecoration(labelText: "Nom"),
                validator: (value) =>
                    value!.isEmpty ? "Champ Obligatoire" : null,
              ),
              // Champ Saisie Prenom
               TextFormField(
                controller: txtAuthorFirstname,
                decoration:
                    const InputDecoration(labelText: "Prenom"),
                validator: (value) =>
                    value!.isEmpty ? "Champ Obligatoire" : null,
              ),

              // Champ Saisie Mail
               TextFormField(
                controller: txtAuthorMail,
                decoration:
                    const InputDecoration(labelText: "Adresse Mail"),
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
  Future<void> _submit() async{
    if (keyform.currentState!.validate()) {
      // Vérifie que le formulaire est valide
      if (widget.author == null) {
        // Création d'une nouvelle catégorie
        Author newAuthor = Author();
        newAuthor.name = txtAuthorName.text;
        newAuthor.name = txtAuthorFirstname.text;
        newAuthor.name = txtAuthorMail.text;
        await AuthorController.addAuthor(
            newAuthor); // Appelle le contrôleur pour enregistrer
      } else {
        // Mise à jour d'une catégorie existante
        Author existedAuthor = widget.author!;
        existedAuthor.name = txtAuthorName.text;
        existedAuthor.firstname = txtAuthorFirstname.text;
        existedAuthor.mail = txtAuthorMail.text;
        await AuthorController.updateAuthor(
            existedAuthor); // Mise à jour via le contrôleur
      }
      if (mounted) {
      Navigator.pop(context);
      }
    }
  }
}
