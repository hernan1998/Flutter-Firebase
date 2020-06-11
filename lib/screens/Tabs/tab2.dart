import 'package:flutter/material.dart';
import 'package:flutter_firebase/Shared/loading.dart';
import 'package:flutter_firebase/models/crew.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:provider/provider.dart';

class FriendsShoppingList extends StatefulWidget {
  @override
  _FriendsShoppingListState createState() => _FriendsShoppingListState();
}

class _FriendsShoppingListState extends State<FriendsShoppingList> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final crews = Provider.of<List<CrewMember>>(context, listen: true);
    final user = Provider.of<User>(context, listen: false);
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/segunda');
                },
              ),
              title: Text("Friend's Shopping List"),
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
            ),
            body: Container(
              margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 80.0),
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: crews.length,
                  itemBuilder: (BuildContext context, int index) {
                    String nombre = "";
                    if (crews[index].uid == user.uid) {
                      nombre = "My List";
                    } else {
                      nombre = crews[index].name + " " + crews[index].lastname;
                    }
                    return Column(
                      children: <Widget>[
                        Card(
                          margin: EdgeInsets.fromLTRB(20.0, 1.0, 20.0, 1.0),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 10.0, 20.0, 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      nombre,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      crews[index].total,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                RawMaterialButton(
                                  onPressed: crews[index].uid != user.uid
                                      ? () {
                                          setState(() {
                                            if (crews[index].agregarLista ==
                                                false) {
                                              crews[index].onSelectList(true);
                                            } else {
                                              crews[index].onSelectList(false);
                                            }
                                          });
                                        }
                                      : null,
                                  elevation: 2.0,
                                  fillColor: Colors.white,
                                  child: crews[index].icono,
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        )
                      ],
                    );
                  }),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  loading = true;
                });
                Navigator.pop(context);
                Navigator.pushNamed(context, '/cuarta');
              },
              label: Text('Refresh'),
              icon: Icon(Icons.refresh),
              backgroundColor: Colors.pink,
            ),
          );
  }
}
