import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:noLine/main.dart';

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
          margin: EdgeInsets.only(top: screenSize.height / 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(child: Image.asset('assets/images/tmp_icon.png')),
              SizedBox(height: screenSize.height / 50),
              TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 100),
                  totalRepeatCount: 1,
                  repeatForever: false,
                  pause: Duration(milliseconds: 1000),
                  text: ["Welcome to noline, connecting lines online."],
                  textStyle: Theme.of(context).textTheme.headline5,
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true),
              Container(
                  width: screenSize.height / 2,
                  child: Image.asset('assets/images/line.jpg')),
              SizedBox(height: screenSize.height / 20),
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
