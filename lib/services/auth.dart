import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user object 
  User _userFirebase(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFirebase);
  }

  //Sign in Guest
  Future signInGuest () async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //Sign in with Email & Pass

  //Register with Email & Pass

  //Sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}