// Creation d'une classe dategorie controleur
import "package:gestion_bibliotheque/models/categorie.dart";
import "package:sqflite/sqflite.dart";
import "package:gestion_bibliotheque/models/database/dao.dart";

class CategorieController {
  static Future<List<Categorie>> categoriesList() async {
     final db = await Dao.database;
    var maps = await db.query("catogories", columns: ["*"]);
    if (maps.isNotEmpty) {
      return maps.map((e) => Categorie.fromMap(e)).toList();
    } else {
      return [];
    }
  }

  static Future<Categorie> createCategory(Categorie categorie) async {
    final db = await Dao.database;
    var id = await db.insert("Categorie", categorie.toMap() as Map<String, Object?>);
    categorie.id = id;
    return categorie;
  }

  static Future<int> updateCategory(Categorie categorie) async {
    final db = await Dao.database;
    return await db.update("categorie", categorie.toMap() as Map<String, Object?>,
        where: "id : ?", whereArgs: [categorie.id]);
  }

  static Future<int> deleteCategory(int id) async {
    final db = await Dao.database;
    return await db.delete("categorie", where: "id : ?", whereArgs: [id]);
  }
}
