/* Creation d'un composant - les étapes
 * Créer une classe correspondante à notre correspondant qui héritera de la
 * classe StateFulWidget
 * 
 * Importer le module material.dart
 * class <composant_name>
 */

// Modules Utilisés
import 'package:flutter/material.dart';
import 'package:gestion_bibliotheque/views/category_list.dart';
import 'package:path/path.dart';

// Classe HomePage - fille de la classe StateFulWidget
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Bienvenue sur Bibliotheca"),
        ),
        body: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
          (crossAxisCount: 2),
          children: [
            MaterialButton(
              textColor: Colors.blue, 
              onPressed: (){

              },
              child : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book, color: Colors.blue,),
                  SizedBox(width: 10, height: 10,),
                  Text(
                    "Livres",
                    style : TextStyle(fontSize: 17),
                  )
                ],
              )
              ),
              MaterialButton(
              textColor: Colors.blue, 
              onPressed: (){

              },
              child : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book, color: Colors.blue,),
                  SizedBox(width: 10, height: 10,),
                  Text(
                    "Auteurs",
                    style : TextStyle(fontSize: 17),
                  )
                ],
              )
              ),
              MaterialButton(
              textColor: Colors.blue, 
              onPressed: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const ListeCategorie())
                )
              },
              child : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book, color: Colors.blue,),
                  SizedBox(width: 10, height: 10,),
                  Text(
                    "Categories",
                    style : TextStyle(fontSize: 17),
                  )
                ],
              )
              ),
          ],
          ),
      );
  /*
    On  utilise la widget Scaffold pour créer notre composante 
   */
}
