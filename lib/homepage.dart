import 'package:flutter/material.dart';
import 'widgets/customs.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  

  final String title;

  

  @override
  MyHomePageState createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  //GlobalKey<MyHomePageState> myWidgetStateKey = new GlobalKey<MyHomePageState>();
  
  List<String> villes = [];
  String villeChoisie;
  String key = 'ville';

@override
void initState() {
    // TODO: implement initState
    super.initState();
    obtenir();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
     
      drawer: new Drawer(
        child: Container(
          color: Colors.blue,
          child: new ListView.builder(
            itemCount: villes.length + 2,
            itemBuilder: (context, i) {
              if (i == 0) {
                return DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      texteStyle("mes Villes", fontSize: 22.0),
                      RaisedButton(
                        child: texteStyle("Ajouter une Ville", color: Colors.blue),
                        color: Colors.white,
                        onPressed: ajoutVille,
                      )
                    ],
                  ),
                );
              } else if (i == 1) {
                return ListTile(
                    title: texteStyle("ma ville actuelle"),
                    onTap: () {
                      setState(() {
                        villeChoisie = null;
                        Navigator.pop(context);
                      });
                    });
              } else {
                String ville = villes[i-2];
                return ListTile(
                  title: texteStyle(ville),
                  onTap: () {
                    setState(() {
                      villeChoisie = ville;
                      Navigator.pop(context);
                    });
                  }
                );
              }
            }
          )
        )
      ),
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(widget.title),
      ),
      body: new Center(
          child: Text(villeChoisie == null ? 'ville actuelle' : villeChoisie)),
    );    
  }

Future<Null> ajoutVille() async {
  
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext buildcontext) {
        return SimpleDialog(
          contentPadding: EdgeInsets.all(20.0),
          title: texteStyle("ajouter une ville", fontSize: 22.0, color: Colors.blue),
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "ville: "),
              onSubmitted: (String str) {
                ajouter(str);
                Navigator.pop(buildcontext);
              },
            )
          ],
        );
  
      },
    
     );
    
}
  
void obtenir() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  List<String> liste = sharedPreferences.getStringList(key);
  if(liste != null) {
    setState(() {
     villes = liste; 
    });
  }
}

void ajouter(String str) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  villes.add(str);
  await sharedPreferences.setStringList(key, villes);
  obtenir();
}

}
