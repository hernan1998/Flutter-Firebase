import 'package:flutter/material.dart';
import 'package:flutter_firebase/Shared/loading.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/Shared/constans.dart';

class SignUp extends StatefulWidget {

  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  //Variables
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Text field state
  String email = '';
  String password = '';
  String name = '';
  String lastname = '';
  String phone = '';
  String error ='';

  
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
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
          key: _formKey,
          child: Column(
            children: <Widget>[
              Title(
                color: Colors.black, 
                child: Text(
                  'Register new User',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: TextInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter a email' : null,
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: TextInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password of 6 chars long' : null,
                onChanged: (val){
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: TextInputDecoration.copyWith(hintText: 'Name'),
                validator: (val) => val.isEmpty ? 'Enter a Name' : null,
                onChanged: (val){
                  setState(() => name = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: TextInputDecoration.copyWith(hintText: 'Last Name'),
                validator: (val) => val.isEmpty ? 'Enter a Last name' : null,
                onChanged: (val){
                  setState(() => lastname = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: TextInputDecoration.copyWith(hintText: 'Phone number'),
                validator: (val) => !val.contains(new RegExp(r'^[0-9]*$')) ? 'Enter a Phone number valid' : null,
                onChanged: (val){
                  setState(() => phone = val);
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
                  if(_formKey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signUpWithEmailPassword(email, password, name, lastname, phone);
                    if(result == null){
                      setState((){
                        error = 'Please supply a valid email';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12.0,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}