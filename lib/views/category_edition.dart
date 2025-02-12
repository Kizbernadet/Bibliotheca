import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/models/categorie.dart';
import "package:gestion_bibliotheque/controllers/category_controller.dart";

class EditionCategorie extends StatefulWidget {
  final Categorie? categorie;
  const EditionCategorie({this.categorie, super.key});

  @override
  State<EditionCategorie> createState() => _EditionCategorieState();
}

class _EditionCategorieState extends State<EditionCategorie> {
  TextEditingController txtCategorie = TextEditingController();
  final keyform = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.categorie != null) {
      txtCategorie.text = widget.categorie!.libelle!;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Edition Categorie"),
        ),
        body: Form(
          key: keyform,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              MaterialButton(
                onPressed: () {},
                child: const CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.category),
                ),
              ),
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
              ElevatedButton(
                onPressed: () {
                  _submit();
                },
                child: const Text("Enregistrer"),
              )
            ],
          ),
        ),
      );

  Future<void> _submit() async {
    if (keyform.currentState!.validate()) {
      if (widget.categorie == null) {
        Categorie categorie = Categorie();
        categorie.libelle = txtCategorie.text;
        await CategorieController.createCategory(categorie);
      } else {
        Categorie categorie = Categorie();
        categorie.libelle = widget.categorie!.libelle;
        await CategorieController.updateCategory(categorie);
      }
    }
  }
}
