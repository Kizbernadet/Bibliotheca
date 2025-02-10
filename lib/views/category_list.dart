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
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      leading: Icon(Icons.category),
                      title : Text(snapshot.data![i]),
                      trailing: const Icon(Icons.refresh),
                      onTap: () => (),
                      onLongPress: () => (),
                    );
                  });
            }),
      );
}