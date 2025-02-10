import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Fonction pour afficher la liste des catégories
  void _showCategories() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.science, color: Colors.blue),
                title: Text("Science"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.history, color: Colors.blue),
                title: Text("Histoire"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.computer, color: Colors.blue),
                title: Text("Informatique"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.art_track, color: Colors.blue),
                title: Text("Art"),
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Bienvenue sur Bibliotheca"),
        ),
        body: GridView(
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: [
            MaterialButton(
                textColor: Colors.blue,
                onPressed: () {},
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.book, color: Colors.blue),
                    SizedBox(width: 10, height: 10),
                    Text(
                      "Livres",
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                )),
            MaterialButton(
                textColor: Colors.blue,
                onPressed: () {},
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, color: Colors.blue),
                    SizedBox(width: 10, height: 10),
                    Text(
                      "Auteurs",
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                )),
            MaterialButton(
                textColor: Colors.blue,
                onPressed: _showCategories, // Ouvre la liste des catégories
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.category, color: Colors.blue),
                    SizedBox(width: 10, height: 10),
                    Text(
                      "Catégories",
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                )),
          ],
        ),
      );
}
