import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/crew.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  // Colecction reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future createUserData(String name, String lastname, String phone) async{
    return await userCollection.document(uid).setData({
      'name': name,
      'lastname': lastname,
      'phone': phone,
      'uid': uid,
    });
  }

  // Crew List
  List<CrewMember> _crewListSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return CrewMember(
        name: doc.data['name'] ?? '',
        lastname: doc.data['lastname'] ?? '',
        phone: doc.data['phone'] ?? '',
        uid: doc.data['uid'] ?? ''
      );
    }).toList();
  }

  // gets To Do's stream
  Stream<List<CrewMember>> get crew {
    return userCollection.snapshots().map(_crewListSnapshot);
  }

}