import 'package:flutter/material.dart';
import 'package:noLine/screens/line_management.dart';
import 'package:noLine/screens/line_view.dart';
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
          backgroundColor: Colors.transparent,
          textTheme: Theme.of(context).textTheme,
          title: Text(''),
          elevation: 0,
          toolbarHeight: MediaQuery.of(context).size.height / 15,
          leading: !Navigator.canPop(context)
              ? null
              : new IconButton(
                  icon: new Icon(
                    Icons.arrow_back,
                    color: Colors.black54,
                  ),
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
    return MaterialApp(
        title: 'noline',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => FirebaseLoginWrapper(),
          '/manager-login': (context) => ManagerLogin(),
          '/join-line': (context) => JoinLine(),
          '/line-mangement': (context) =>
              LineManagement(lineId: ModalRoute.of(context).settings.arguments),
          '/line-view': (context) =>
              LineView(ModalRoute.of(context).settings.arguments)
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ));
  }
}
