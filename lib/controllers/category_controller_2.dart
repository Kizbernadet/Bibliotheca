import 'package:gestion_bibliotheque/models/categorie.dart';
import 'package:sqflite/sqflite.dart';
import 'package:gestion_bibliotheque/models/database/dao.dart';

class CategorieController {
  // Récupération de la base de données de manière asynchrone
  static Future<Database> getDatabase() async => await Dao.database;

  // Récupérer la liste des catégories
  static Future<List<Categorie>> categoriesList() async {
    final db = await getDatabase(); // Attendre l'initialisation de la BD
    var maps = await db.query("categories", columns: ["*"]);
    
    return maps.isNotEmpty ? maps.map((e) => Categorie.fromMap(e)).toList() : [];
  }

  // Créer une nouvelle catégorie
  static Future<Categorie> createCategory(Categorie categorie) async {
    final db = await getDatabase();
    var id = await db.insert("categories", categorie.toMap());
    categorie.id = id;
    return categorie;
  }

  // Mettre à jour une catégorie
  static Future<int> updateCategory(Categorie categorie) async {
    final db = await getDatabase();
    return await db.update(
      "categories",
      categorie.toMap(),
      where: "id = ?",
      whereArgs: [categorie.id],
    );
  }

  // Supprimer une catégorie
  static Future<int> deleteCategory(int id) async {
    final db = await getDatabase();
    return await db.delete("categories", where: "id = ?", whereArgs: [id]);
  }
}
