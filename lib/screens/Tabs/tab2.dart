import 'package:flutter/material.dart';

class FriendsShoppingList extends StatefulWidget {
  @override
  _FriendsShoppingListState createState() => _FriendsShoppingListState();
}

class _FriendsShoppingListState extends State<FriendsShoppingList> {
  Icon _affectedByStateChange = new Icon(
    Icons.add,
    color: Colors.pinkAccent,
  );

  bool icon = false;

  @override
  Widget build(BuildContext context) {
    _thisWillAffectTheState() {
      _affectedByStateChange = new Icon(Icons.add, color: Colors.pinkAccent);
    }

    _thisWillAlsoAffectTheState() {
      _affectedByStateChange = new Icon(Icons.delete, color: Colors.pinkAccent);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Friend's Shopping List"),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 80.0),
        child: ListView.builder(
          itemBuilder: (context, position) {
            return Column(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Nombre del amigo",
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Precio de la lista",
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          setState(() {
                            if (icon == false) {
                              _thisWillAlsoAffectTheState();
                              icon = true;
                            } else {
                              _thisWillAffectTheState();
                              icon = false;
                            }
                          });
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: _affectedByStateChange,
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                )
              ],
            );
          },
          itemCount: 3,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Refresh'),
        icon: Icon(Icons.refresh),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
