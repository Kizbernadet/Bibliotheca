import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/models/categorie.dart';
import 'package:gestion_bibliotheque/controllers/category_controller_2.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Clé pour valider le formulaire

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajouter une Catégorie")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Nom de la catégorie"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ce champ est obligatoire";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Créer une nouvelle catégorie
                    Categorie newCategorie = Categorie(_nameController.text);
                    await CategorieController.createCategory(newCategorie);

                    // Retour à la page précédente avec succès
                    Navigator.pop(context, true);
                  }
                },
                child: Text("Enregistrer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
