import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/crew.dart';

class CrewTitle extends StatelessWidget {

  final CrewMember crew;
  CrewTitle({this.crew});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
          ),
          title: Text(crew.name),
          subtitle: Text('Last Name: ${crew.lastname},  Phone number: ${crew.phone}'),
        ),
      ),
    );
  }
}