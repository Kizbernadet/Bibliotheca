import "package:gestion_bibliotheque/controllers/author_controller.dart";
import "package:gestion_bibliotheque/controllers/category_controller.dart";
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

  static Future<void> deleteBook(int bookId) async {
  final db = await Dao.database;

  // Récupère les informations du livre à supprimer
  var bookData = await db.query("books", where: "id = ?", whereArgs: [bookId]);
  if (bookData.isNotEmpty) {
    var book = Book.fromMap(bookData.first);

    // Supprime le livre
    await db.delete("books", where: "id = ?", whereArgs: [bookId]);

    // Vérifie si l'auteur doit être supprimé
    await AuthorController.deleteAuthorIfNoBooks(book.authorId!);

    // Vérifie si la catégorie doit être supprimée
    await CategorieController.deleteCategoryIfNoBooks(book.categorieId!);
  }
}

}