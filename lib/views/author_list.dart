import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/controllers/author_controller.dart';
import 'package:gestion_bibliotheque/models/author.dart';
import 'package:gestion_bibliotheque/views/author_edition.dart';

class ListeAuthors extends StatefulWidget {
  const ListeAuthors({super.key});

  @override
  State<ListeAuthors> createState() => _ListeAuthorsState();
}

class _ListeAuthorsState extends State<ListeAuthors> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Auteurs")),
        floatingActionButton: FloatingActionButton(
          onPressed: () => openAuthorEdition(), // Appelle la fonction d'édition
          child: const Icon(Icons.add), // Icône "plus"
        ),
        body: FutureBuilder(
            future: AuthorController.authorsList(),
            initialData: const [],
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
               // Gestion des erreurs
              if (snapshot.hasError) {
                return Center(
                  child:
                      Text("Erreur : ¨${snapshot.error}"), // Affiche l'erreur
                );
              }
               // Cas où il n'y a pas de données ou si la liste est vide
              if (snapshot.data!.isEmpty || !snapshot.hasData) {
                return Center(
                  child: Text(
                      "Aucun élément trouvé"), // Message pour indiquer qu'il n'y a rien
                );
              }
            }
      ),
  );
  openAuthorEdition({Author? author}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditionAuthor(
                  author: author, // Passage de la catégorie en paramètre
                )));
    setState(() {});
  }
}
