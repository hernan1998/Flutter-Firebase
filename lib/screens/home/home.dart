import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/crew.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/screens/home/crew_list.dart';
import 'package:flutter_firebase/models/products.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<CrewMember>>.value(
        value: DatabaseService().crew,
        child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Text("Friend´s shopping list"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon( 
              icon: Icon(Icons.person), 
              label: Text("Log Out"),
              onPressed: ()async{
                await _auth.signOut();
              },
              )
          ],
        ),
        body: CrewList(),
        floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //Replace strings with search content, if null all elements will be obtained
          Products().search(category: "VERDURA", term: "pa");          
        },
        label: Text('Your List'),
        icon: Icon(Icons.local_mall),
        backgroundColor: Colors.pink,
      ),
      ),
    );
  }
}