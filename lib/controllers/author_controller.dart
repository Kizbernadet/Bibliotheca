// Creation d'une classe dategorie controleur
import "package:gestion_bibliotheque/models/database/dao.dart";
import "package:gestion_bibliotheque/models/author.dart";

class AuthorController {
  static Future<List<Author>> authorsList() async {
    final db = await Dao.database;
    var maps = await db.query("authors", columns: ["*"]);
    if (maps.isNotEmpty) {
      return maps.map((e) => Author.fromMap(e)).toList();
    } else {
      return [];
    }
  }

  static Future<Author> addAuthor(Author author) async {
    final db = await Dao.database;
    var id = await db.insert("authors", author.toMap());
    author.id = id as String?;
    return author;
  }

  static Future<int> updateAuthor(Author author) async {
    final db = await Dao.database;
    return await db.update("authors", author.toMap(),
    where: "id = ?", whereArgs: [author.id]);
  }

  static Future<int> deleteAuthor(int id) async {
    final db = await Dao.database;
    return await db.delete("authors", where: "id = ?", whereArgs: [id]);
  }
}
