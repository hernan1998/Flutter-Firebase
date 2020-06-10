import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/models/crew.dart';
import 'package:flutter_firebase/models/products_info.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:provider/provider.dart';

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  List<TextEditingController> _text;

  //VALIDO CUALES SON LOS PRODUCTOS QUE ELEGI ENTRE TODOS LOS DISPONIBLES
  List<ProductsInfo> misProductos;
  void mostrarProductos(List<ProductsInfo> products) {
    int cont = 0;
    for (var i = 0; i < products.length; i++) {
      if (products[i].number > 0) {
        cont++;
      }
    }
    misProductos = new List(cont);
    cont = 0;
    for (var i = 0; i < products.length; i++) {
      if (products[i].number > 0) {
        misProductos[cont] = products[i];
        cont++;
      }
    }
  }

  @override
  void dispose() {
    for (var i = 0; i < _text.length; i++) {
      _text[i].dispose();
      super.dispose();
    }
  }

  //CALCULO EL TOTAL DEL PRECIO DE TODOS LOS PRODUCTOS
  double totalMisProductos(List<ProductsInfo> products) {
    double total = 0;
    for (var i = 0; i < products.length; i++) {
      total += products[i].number.toDouble() * products[i].price;
      print(products[i].number.toDouble());
      print(products[i].price);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    //MULTIPROVIDERS
    final productos = Provider.of<List<ProductsInfo>>(context, listen: true);
    final crews = Provider.of<List<CrewMember>>(context, listen: true);
    final user = Provider.of<User>(context, listen: false);

    //GENERO UNA LISTA CONTROLADORA DE TEXTFIELD
    _text = List.generate(productos.length, (i) => TextEditingController());
    for (var i = 0; i < _text.length; i++) {
      _text[i].text = productos[i].number.toString();
    }

    //SCAFFOLD
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
            //VEO CUALES TEXTFIELD NO ESTAN VACIOS Y LOS GUARDO EN UN ARRAY QUE EN UN FUTURO SERAN MI LISTA
            for (var i = 0; i < _text.length; i++) {
              if (_text[i].text.isNotEmpty) {
                productos[i].onChangeNumber(int.parse(_text[i].text));
              }
            }
            //LLAMO LA  FUNCION PARA GUARDAR LOS PRODUCTOS EN MI LISTA
            mostrarProductos(productos);
            for (var i = 0; i < crews.length; i++) {
              if (crews[i].uid == user.uid) {
                crews[i].totalPrecio = totalMisProductos(misProductos).toInt();
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
