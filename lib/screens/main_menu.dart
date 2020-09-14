import 'package:flutter/material.dart';
import 'package:noLine/main.dart';
import 'package:noLine/screens/manager_login.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  double buttonWidth = 200;
  double buttonHeight = 50;
  double buttonsDistance = 30;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: MyAppBar(context),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: screenSize.height / 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.purple,
                padding: EdgeInsets.symmetric(vertical: screenSize.height / 40, horizontal: screenSize.width / 20),
                child: Text(
                  'NOLINE',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenSize.height / 10,
                      fontFamily: "Razuchka"),
                ),
              ),
              SizedBox(height: screenSize.height / 4),
              RaisedButton(
                  onPressed: () {
                    // Move to "enter line code page"
                    Navigator.pushNamed(context, '/join-line');
                  },
                  child: Container(
                    width: screenSize.width / 4,
                    height: screenSize.height / 15,
                    child: FittedBox(child: Text('Join a line')),
                  )),
              SizedBox(height: buttonsDistance),
              InkWell(
                onTap: () {
                  // Move to line management page
                  Navigator.pushNamed(context, '/manager-login');
                },
                child: Text(
                  'or create a line of your own',
                  style: TextStyle(fontSize: screenSize.height / 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
