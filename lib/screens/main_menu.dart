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
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = new ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );
  }

  @override
  void didChangeDependencies() {
    Future.delayed(Duration(milliseconds: 300)).then((value) => _toEnd());

    super.didChangeDependencies();
  }

  void _toEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 10000),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(context),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              "assets/images/background.jpg",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: screenSize.height / 25),
                      height: screenSize.height / 5,
                      width: screenSize.height / 5,
                      child: Image.asset('assets/images/logo.png')),
                  SizedBox(height: screenSize.height / 50),
                  TypewriterAnimatedTextKit(
                      speed: Duration(milliseconds: 100),
                      totalRepeatCount: 1,
                      repeatForever: false,
                      pause: Duration(milliseconds: 1000),
                      text: ["Welcome to noline \n connecting lines online."],
                      textAlign: TextAlign.center,
                      textStyle: Theme.of(context)
                          .textTheme
                          .headline5
                          .merge(TextStyle(color: Colors.black87)),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true),
                  //Container(child: Image.asset('assets/images/illustration.png')),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    child: Container(
                      width: screenSize.height * 2,
                      height: screenSize.height / 3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/illustration.png',
                          ),
                          fit: BoxFit.fill,
                          repeat: ImageRepeat.noRepeat,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height / 20),
                  Container(
                    width: screenSize.height * 0.65,
                    child: RaisedButton(
                        color: Colors.white.withOpacity(0.20),
                        onPressed: () {
                          // Move to "enter line code page"
                          Navigator.pushNamed(context, '/join-line');
                        },
                        child: Container(
                          width: screenSize.width / 4,
                          height: screenSize.height / 15,
                          child: FittedBox(
                              child: Text(
                            'Join a line',
                            style: Theme.of(context).textTheme.headline1.merge(
                                TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w300)),
                          )),
                        )),
                  ),
                  SizedBox(height: screenSize.height / 40),
                  Container(
                    width: screenSize.height * 0.65,
                    child: RaisedButton(
                        color: Colors.white.withOpacity(0.20),
                        onPressed: () {
                          // Move to "enter line code page"
                          Navigator.pushNamed(context, '/manager-login');
                        },
                        child: Container(
                          width: screenSize.width / 2,
                          height: screenSize.height / 15,
                          child: FittedBox(
                              child: Text(
                            'Manage a line of your own',
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .merge(TextStyle(color: Colors.black87)),
                          )),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
