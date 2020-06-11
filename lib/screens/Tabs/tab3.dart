import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/products_info.dart';
import 'package:flutter_firebase/services/calculos.dart';
import 'package:provider/provider.dart';

class CompleteShoppingList extends StatefulWidget {
  @override
  _CompleteShoppingListState createState() => _CompleteShoppingListState();
}

class _CompleteShoppingListState extends State<CompleteShoppingList> {
  List<ProductsInfo> misProductos;
  Calculo c = new Calculo();

  @override
  Widget build(BuildContext context) {
    final List<ProductsInfo> productos =
        Provider.of<List<ProductsInfo>>(context, listen: false);
    misProductos = c.mostrarProductos(productos);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/tercera');
          },
        ),
        title: Text("Shopping List"),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 25.0,
          ),
          Expanded(
            flex: 1,
            child: Text(
              'My Shopping List',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView.builder(
                itemCount: misProductos.length,
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
                                (index + 1).toString() +
                                    ".     " +
                                    misProductos[index].number.toString() +
                                    " " +
                                    misProductos[index].name,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
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
          Expanded(
            child: Text(
              'Total ' + c.totalMisProductos(misProductos).toString(),
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          //Expanded para selected shopping friend
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/');
        },
        label: Text('Close'),
        icon: Icon(Icons.close),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
