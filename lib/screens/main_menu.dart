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
    return Scaffold(
      appBar: MyAppBar(context),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.purple,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text(
                  'NOLINE',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontFamily: "Razuchka"),
                ),
              ),
              SizedBox(height: 200),
              RaisedButton(
                  onPressed: () {
                    // Move to "enter line code page"
                    Navigator.pushNamed(context, '/join-line');

                    setState(() {
                      this.buttonWidth *= 1.02;
                      this.buttonHeight *= 1.02;
                    });
                  },
                  child: Container(
                    width: buttonWidth,
                    height: buttonHeight,
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
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
