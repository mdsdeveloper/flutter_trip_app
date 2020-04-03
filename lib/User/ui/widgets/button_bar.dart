import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertripapp/Place/ui/screens/add_place_screen.dart';
import 'package:fluttertripapp/User/bloc/bloc_user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'circle_button.dart';

class ButtonsBar extends StatelessWidget {
  BlocUser blocUser;

  @override
  Widget build(BuildContext context) {
    blocUser = BlocProvider.of(context);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
//            CircleButton(true, Icons.turned_in_not, 20.0, Color.fromRGBO(255, 255, 255, 1)),
            CircleButton(true, Icons.vpn_key, 20.0,
                Color.fromRGBO(255, 255, 255, 0.6), () => {}),
            CircleButton(
                false, Icons.add, 40.0, Color.fromRGBO(255, 255, 255, 1), () {
              File image = null;
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AddPlaceScreen(image: image)));
            }),
//            Cierra sesion
            CircleButton(
                true,
                Icons.exit_to_app,
                20.0,
                Color.fromRGBO(255, 255, 255, 0.6),
                () => {blocUser.signOuth()}),
//            CircleButton(true, Icons.person, 20.0, Color.fromRGBO(255, 255, 255, 0.6))
          ],
        ));
  }
}
