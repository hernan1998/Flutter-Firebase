import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/products.dart';
import 'package:flutter_firebase/models/products_info.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/wrapper.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          value: AuthService().user,
        ),
        FutureProvider<List<ProductsInfo>>(
          create: (_) => Products().search(),
        ),
      ],
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
