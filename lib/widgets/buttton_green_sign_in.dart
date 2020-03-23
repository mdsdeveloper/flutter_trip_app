import 'package:flutter/material.dart';

class ButtonGreenSignIn extends StatefulWidget {
  final String text;
  double height = 0.0;
  double width = 0.0;
  final VoidCallback onPressed;

  ButtonGreenSignIn(
      {Key key,
      @required this.text,
      @required this.onPressed,
      this.width,
      this.height});

  @override
  State<StatefulWidget> createState() {
    return _ButtonGreenSignIn();
  }
}

class _ButtonGreenSignIn extends State<ButtonGreenSignIn> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                colors: [Color(0xFFa7ff84), Color(0xFF1cbb78)],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp)),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
                fontSize: 18.0, fontFamily: "Lato", color: Colors.white),
          ),
        ),
      ),
    );
  }
}
