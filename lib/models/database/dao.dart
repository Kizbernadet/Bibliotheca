// Creation d'une classe de gestion des bases de données

// Importation de la librairie Database
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class Dao {
  /* 
    On crée une propriété de classe database car l'on souhaite créer une seule
    base de données , pour les cas inverses on peut déclarer en tant que variable
    d'instance 
  */
  static Database? _database;

  /// Cette méthode permet la création d'une base de données
  static Future<Database> get database async {
    /*
      On ajoute des conditions qui créent une nouvelle bdd s'il n'existe pas ou 
      renvoie l'instance de la bdd si elle existe déjà
     */
    if (_database != null) {
      return _database!; // Le point ! montre que la valeur renvoyée est not null
    }
    _database = await _initDB("bibliotheca.db");
    return _database!;
  }

  static Future<Database> _initDB(String filePath) async {
    /**
     * Le mot-clé Final est utilisé pour specifier des variables constantes
     */
    //databaseFactory = databaseFactoryFfi;
    databaseFactory = databaseFactoryFfiWeb;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath , filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  static Future _createDB(Database db, int version) async {
    await db.execute(''' CREATE TABLE categories (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      libelle VARCHAR(255) NOT NULL
      )''');
    await db.execute(''' CREATE TABLE authors (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      name VARCHAR(255) NOT NULL,
      email VARCHAR(255) NOT NULL
      )''');
    await db.execute(''' CREATE TABLE books (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      libelle VARCHAR(255) NOT NULL,
      description VARCHAR(255) NOT NULL,
      nbpages INTEGER,
      image VARCHAR(255) NOT NULL,
      author_id INTEGER NOT NULL,
      category_id INTEGER NO NULL
      )''');
  }

  //
}
