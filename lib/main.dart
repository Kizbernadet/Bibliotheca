import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/controllers/author_controller.dart';
import 'package:gestion_bibliotheque/controllers/category_controller.dart';
import 'package:gestion_bibliotheque/models/author.dart';
import 'package:gestion_bibliotheque/models/categorie.dart';
import "package:gestion_bibliotheque/views/home_page.dart";

void main() {
  runApp(const MainApp());
  Categorie category = Categorie(libelle: "Poème");
  CategorieController.createCategory(category);

  Author author = Author(name: "Kishimoto", firstname: 'Masashi', mail: "kisimotosan@gmail.com");
  AuthorController.addAuthor(author);
  if (kDebugMode) {
    print('Auteur inséré avec id : ${author.id}');
  }
}

Future<void> afficher() async {
  var categoryMaps = await CategorieController.categoriesList();
  var authorsMaps = await AuthorController.authorsList();

  if (kDebugMode) {
    print(categoryMaps.map((e) => e.toMap()).toList());
  }

  if(kDebugMode){
    print(authorsMaps.map((e) => e.toMap()).toList());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
