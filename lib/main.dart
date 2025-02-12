import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/controllers/category_controller.dart';
import 'package:gestion_bibliotheque/models/categorie.dart';
import "package:gestion_bibliotheque/views/home_page.dart";

void main() {
  runApp(const MainApp());
  Categorie category = Categorie(libelle: "Poème");
  CategorieController.createCategory(category);
}

Future<void> afficher() async {
  var maps = await CategorieController.categoriesList();
  if (kDebugMode) {
    print(maps.map((e) => e.toMap()).toList());
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
