// Creation d'une classe dategorie controleur
import "package:gestion_bibliotheque/models/categorie.dart";
import "package:gestion_bibliotheque/models/database/dao.dart";

class CategorieController {
  static Future<List<Categorie>> categoriesList() async {
     final db = await Dao.database;
    var maps = await db.query("categories", columns: ["*"]);
    if (maps.isNotEmpty) {
      return maps.map((e) => Categorie.fromMap(e)).toList();
    } else {
      return [];
    }
  }

  static Future<Categorie> createCategory(Categorie categorie) async {
    final db = await Dao.database;
    var id = await db.insert("categories", categorie.toMap());
    categorie.id = id;
    return categorie;
  }

  static Future<int> updateCategory(Categorie categorie) async {
    final db = await Dao.database;
    return await db.update("categories", categorie.toMap(),
    where: "id = ?", whereArgs: [categorie.id]);
  }

  static Future<int> deleteCategory(int id) async {
    final db = await Dao.database;
    return await db.delete("categories", where: "id = ?", whereArgs: [id]);
  }

  static Future<void> deleteCategoryIfNoBooks(int categoryId) async {
  final db = await Dao.database;

  // Vérifie s'il reste des livres associés à cette catégorie
  var books = await db.query("books", where: "categorieId = ?", whereArgs: [categoryId]);
  if (books.isEmpty) {
    // Aucune catégorie associée, supprime la catégorie
    await db.delete("categories", where: "id = ?", whereArgs: [categoryId]);
  }
}

}
