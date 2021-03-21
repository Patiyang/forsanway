import 'package:flutter/material.dart';
import 'package:forsanway/views/loginRegistration/login.dart';
import 'package:forsanway/widgets/styling.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Helvetica',
        // primarySwatch: Colors.blue,
        accentColor: blue,
        iconTheme: IconThemeData(color: blue),
        appBarTheme: AppBarTheme(
          
            backgroundColor: blue,
            centerTitle: true,
            elevation: .3,
            textTheme: TextTheme(
              headline6: TextStyle(fontSize: 17, color: white),
            )),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignIn(),
    );
  }
}
