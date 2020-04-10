import 'package:flutter/material.dart';

class FloatingActionButtonGreen extends StatefulWidget {
  final IconData iconData;
  final VoidCallback onPressed;

  FloatingActionButtonGreen({Key key, @required this.iconData, @required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FloatingActionButtonGreen();
  }
}

class _FloatingActionButtonGreen extends State<FloatingActionButtonGreen> {
  bool pressedButton = false;

/*  void onPressedFav() {
    setState(() {
      pressedButton = !pressedButton;
    });
    Scaffold.of(context).showSnackBar(SnackBar(
      content: pressedButton
          ? Text("Agregaste a tus favoritos")
          : Text("Quitaste de tus favoritos"),
    ));
  }*/

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color(0xFF11DA53),
      mini: true,
      tooltip: "Fav",
      onPressed: widget.onPressed,
      child: Icon(widget.iconData),
      heroTag: null,
    );
  }
}
