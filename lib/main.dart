import 'package:flutter/material.dart';
import 'package:noLine/screens/main_menu.dart';
import 'package:noLine/screens/manager_login.dart';

import 'package:noLine/client/clientMain.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(App());
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

class App extends StatelessWidget {
  // Create the initilization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    MyAppBar appBar = MyAppBar(context);

    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
            home: Text("Error Connecting to firebase")
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
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
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          home: Text("Loading...")
        );
      },
    );
  }
}