import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  //Variables
  final AuthService _auth = AuthService();

  //Text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
       backgroundColor: Colors.brown[400],
       elevation: 0.0,
       title: Text("Sign in for To Do's app"), 
       actions: <Widget>[
         FlatButton.icon(
           onPressed: (){
             widget.toggleView();
           }, 
           icon: Icon(Icons.person), 
           label: Text("Register")
           )
       ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                onChanged: (val){
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async{

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}