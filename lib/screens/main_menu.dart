import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onPressed: () {},
                  child: Container(
                    width: 300,
                    height: 50,
                    child: Center(child: Text('TEST')),
                  )),
              Text(
                'Look at',
              ),
              Text(
                'isaacgarzon',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
