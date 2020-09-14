import 'package:flutter/material.dart';
import 'package:progress_button/progress_button.dart';

class ManagerLogin extends StatefulWidget {
  ManagerLogin({Key key}) : super(key: key);

  @override
  _ManagerLoginState createState() => _ManagerLoginState();
}

class _ManagerLoginState extends State<ManagerLogin> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    TextStyle titleStyle =
        TextStyle(fontSize: screenSize.width / 10, fontWeight: FontWeight.bold);
    TextStyle subTitleStyle = TextStyle(fontSize: screenSize.width / 20);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              "Line Manager",
              style: titleStyle,
            ),
            Text(
              "Enter existing line code",
              style: subTitleStyle,
            ),
            SizedBox(
              height: screenSize.height / 20,
            ),
            Form(
              child: Column(
                children: [
                  Container(child: TextField()),
                  Container(
                    width: screenSize.width * 0.8,
                    child: ProgressButton(
                      onPressed: () {},
                      child: Text(
                        "submit",
                        style:
                            subTitleStyle.merge(TextStyle(color: Colors.white)),
                      ),
                      buttonState: ButtonState.normal,
                      progressColor: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
