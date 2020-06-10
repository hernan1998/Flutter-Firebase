import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/models/products_info.dart';
import 'package:provider/provider.dart';

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  List<TextEditingController> _text;
  bool _validate = false;

  @override
  void dispose() {
    for (var i = 0; i < _text.length; i++) {
      _text[i].dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final productos = Provider.of<List<ProductsInfo>>(context, listen: false);
    _text = List.generate(productos.length, (i) => TextEditingController());
    for (var i = 0; i < _text.length; i++) {
      _text[i].text = productos[i].number.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shopping List"),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 80.0),
        child: ListView.builder(
            itemCount: productos.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  Card(
                    elevation: 5.0,
                    margin: EdgeInsets.fromLTRB(20.0, 1.0, 20.0, 1.0),
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            productos[index].name,
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Flexible(
                            child: Container(
                              width: 50.0,
                              child: TextField(
                                controller: _text[index],
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  )
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            for (var i = 0; i < _text.length; i++) {
              if (_text[i].text.isNotEmpty) {
                productos[i].onChangeNumber(int.parse(_text[i].text));
                _validate = false;
              } else {
                _validate = true;
              }
            }
          });
          Navigator.pushNamed(context, '/tercera');
        },
        label: Text('Update'),
        icon: Icon(Icons.update),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
