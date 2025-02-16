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
            builder: (context, snapshot) {
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
              return ListView.builder(
                itemCount: snapshot.data!.length,
                 itemBuilder: (context, i){
                  var newAuthor = snapshot.data![i];
                  return ListTile(
                      leading: Icon(Icons.person), // Icône devant chaque catégorie
                      title: Text(newAuthor.name), // Nom de la catégorie
                      trailing: const Icon(Icons.refresh), // Icône à droite

                      // Appel de la fonction d'édition en cliquant sur l'élément
                      onTap: () => openAuthorEdition(author: newAuthor),

                      // Appel d'une boîte de dialogue de confirmation en cas d'appui long
                      onLongPress: () => {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  title:
                                      const Text("Confirmer la suppression ? "),
                                  content: const Text(
                                      "Voulez-vous supprimer supprimer"),
                                  actions: [
                                    // Bouton pour annuler la suppression
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); // Ferme la boîte de dialogue
                                        },
                                        child: const Text("Annuler")),

                                    // Bouton pour confirmer la suppression
                                    TextButton(
                                      onPressed: () {
                                        // Suppression de la catégorie via le contrôleur
                                        AuthorController.deleteAuthor(
                                            snapshot.data![i].id);

                                        // Met à jour l'état pour rafraîchir la liste
                                        setState(() {});

                                        // Ferme la boîte de dialogue
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Supprimer",
                                          style: TextStyle(color: Colors.red)),
                                    )
                                  ]);
                            })
                      },
                    );
                 },
              );
            }),
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
