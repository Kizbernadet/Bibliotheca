import "package:gestion_bibliotheque/models/book.dart";
import "package:gestion_bibliotheque/models/database/dao.dart";

class BookController {
  static Future<List<Book>> booksList() async {
     final db = await Dao.database;
    var maps = await db.query("books", columns: ["*"]);
    if (maps.isNotEmpty) {
      return maps.map((e) => Book.fromMap(e)).toList();
    } else {
      return [];
    }
  }

  static Future<Book> addBook(Book book) async {
    final db = await Dao.database;
    var id = await db.insert("books", book.toMap());
    book.id = id;
    return book;
  }

  static Future<int> updateBook(Book book) async {
    final db = await Dao.database;
    return await db.update("books", book.toMap(),
    where: "id = ?", whereArgs: [book.id]);
  }

  static Future<int> deleteBook(int id) async {
    final db = await Dao.database;
    return await db.delete("books", where: "id = ?", whereArgs: [id]);
  }
}