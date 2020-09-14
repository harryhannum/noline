import 'package:flutter/material.dart';
import 'package:noLine/screens/main_menu.dart';
import 'package:noLine/screens/manager_login.dart';

void main() {
  runApp(MyApp());
}

class MyAppBar extends AppBar {
  MyAppBar(BuildContext context)
      : super(
          title: Text('My Title'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyAppBar appBar = MyAppBar(context);
    return MaterialApp(
        title: 'NOLINE',
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => MainMenu(appBar),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/manager-login': (context) => ManagerLogin(appBar)
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ));
  }
}
