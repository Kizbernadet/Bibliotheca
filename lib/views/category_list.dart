import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/controllers/category_controller.dart';
import 'package:gestion_bibliotheque/models/categorie.dart';
import 'package:gestion_bibliotheque/views/category_edition.dart';

// Widget principal qui représente la liste des catégories
class ListeCategorie extends StatefulWidget {
  const ListeCategorie({super.key});

  @override
  State<ListeCategorie> createState() => _ListeCategorieState();
}

class _ListeCategorieState extends State<ListeCategorie> {
  @override
  Widget build(BuildContext context) => Scaffold(
        // AppBar avec un titre
        appBar: AppBar(title: const Text("Liste de catégories")),

        // Bouton flottant permettant d'ajouter ou de modifier une catégorie
        floatingActionButton: FloatingActionButton(
          onPressed: () => openEdition(), // Appelle la fonction d'édition
          child: const Icon(Icons.add), // Icône "plus"
        ),

        // Utilisation de FutureBuilder pour gérer les données asynchrones
        body: FutureBuilder(
            future: CategorieController.categoriesList(), // Appel API ou DB pour obtenir les catégories
            initialData: const [], // Valeur initiale (liste vide)
            builder: (context, snapshot) {
              // Affichage d'un indicateur de chargement si les données ne sont pas encore disponibles
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Gestion des erreurs
              if (snapshot.hasError) {
                return Center(
                  child: Text("Erreur : ¨${snapshot.error}"), // Affiche l'erreur
                );
              }

              // Cas où il n'y a pas de données ou si la liste est vide
              if (snapshot.data!.isEmpty || !snapshot.hasData) {
                return Center(
                  child: Text("Aucun élément trouvé"), // Message pour indiquer qu'il n'y a rien
                );
              }

              // Affichage des données avec un ListView.builder
              return ListView.builder(
                  itemCount: snapshot.data!.length, // Nombre d'éléments dans la liste
                  itemBuilder: (context, i) {
                    var cat = snapshot.data![i]; // Récupération de chaque catégorie
                    return ListTile(
                      leading: Icon(Icons.category), // Icône devant chaque catégorie
                      title: Text(cat.libelle), // Nom de la catégorie
                      trailing: const Icon(Icons.refresh), // Icône à droite

                      // Appel de la fonction d'édition en cliquant sur l'élément
                      onTap: () => openEdition(categorie: cat),

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
                                        CategorieController.deleteCategory(
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
                  });
            }),
      );

  /// Fonction pour ouvrir la page d'édition des catégories
  /// Si une catégorie est fournie, elle sera modifiée, sinon une nouvelle catégorie sera créée
  openEdition({Categorie? categorie}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditionCategorie(
                  categorie: categorie, // Passage de la catégorie en paramètre
                )));
    // Met à jour l'état pour refléter les modifications après le retour de l'édition
    setState(() {});
  }
}
