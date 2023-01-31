import 'package:flutter_ml_precios_casas/screens/precios_form.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Diabetes ML App",
      debugShowCheckedModeBanner: false,
      home: PreciosForm()
    );
  }

}