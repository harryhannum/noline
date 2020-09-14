import 'package:flutter/material.dart';
import 'package:noLine/screens/line_management.dart';
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
          title: Text('NOLINE'),
          leading: !Navigator.canPop(context)
              ? null
              : new IconButton(
                  icon: new Icon(Icons.arrow_back),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                ),
        );
}

enum FirebaseState { Loading, Error, Done }

class FirebaseLoginWrapper extends StatelessWidget {
  FirebaseLoginWrapper();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    MyAppBar appBar = MyAppBar(context);

    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          FirebaseState connectionState = snapshot.hasError
              // ignore: unnecessary_statements
              ? FirebaseState.Error
              : (snapshot.connectionState == ConnectionState.done)
                  ? FirebaseState.Done
                  : FirebaseState.Loading;

          switch (connectionState) {
            case FirebaseState.Loading:
              return Text("loading");
              break;
            case FirebaseState.Error:
              return Text("error");
              break;
            case FirebaseState.Done:
              return MainMenu();
              break;
          }

          return Text("fuck");
        });
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyAppBar appBar = MyAppBar(context);

    return MaterialApp(
        title: 'NOLINE',
        initialRoute: '/',
        routes: {
          '/': (context) => FirebaseLoginWrapper(),
          '/manager-login': (context) => ManagerLogin(),
          '/join-line': (context) => JoinLine(),
          '/line-mangement': (context) => LineManagement()
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ));
  }
}
