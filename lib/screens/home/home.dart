import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text("To Do's List"),
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
    );
  }
}