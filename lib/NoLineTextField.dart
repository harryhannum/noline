import 'package:flutter/material.dart';

class NoLineTextField extends StatelessWidget {

  final TextEditingController _controller;
  final double _width;
  final double _height;

  NoLineTextField(this._controller, this._width, this._height);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      child: TextField(
        controller: _controller,
        style: TextStyle(fontFamily: 'LinLibertine'),
      ),
    );
  }
}