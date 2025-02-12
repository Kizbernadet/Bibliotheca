import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/controllers/category_controller.dart';

class ListeCategorie extends StatefulWidget {
  const ListeCategorie({super.key});
  @override
  State<ListeCategorie> createState() => _ListeCategorieState();
}

class _ListeCategorieState extends State<ListeCategorie> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Liste de catégories")),
        floatingActionButton: FloatingActionButton(
          onPressed: () => (),
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder(
            future: CategorieController.categoriesList(),
            initialData: const [],
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if(snapshot.hasError){
                return Center(child: Text("Erreur : ¨${snapshot.error}"),);
              }

              if(snapshot.data!.isEmpty || snapshot.hasData){
                return Center(child: Text("Aucun élément trouvé"),);
              }

              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      leading: Icon(Icons.category),
                      title: Text(snapshot.data![i].libelle),
                      trailing: const Icon(Icons.refresh),
                      onTap: () => (),
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
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Annuler")),
                                    TextButton(
                                      onPressed: () {
                                          CategorieController.deleteCategory(
                                              snapshot.data![i].id);
                                              setState(() {
                                                
                                              });
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
}
