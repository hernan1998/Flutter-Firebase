import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth.dart';

class SignUp extends StatefulWidget {

  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

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
       title: Text("Register for To Do's app"), 
       actions: <Widget>[
         FlatButton.icon(
           onPressed: (){
             widget.toggleView();
           }, 
           icon: Icon(Icons.person), 
           label: Text("Sign In")
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
                  'Sign Up',
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