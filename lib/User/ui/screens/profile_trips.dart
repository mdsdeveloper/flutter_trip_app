import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertripapp/User/bloc/bloc_user.dart';
import 'package:fluttertripapp/User/model/user.dart';
import 'package:fluttertripapp/User/ui/screens/profile_header.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '../widgets/profile_places_list.dart';
import '../widgets/profile_background.dart';

class ProfileTrips extends StatelessWidget {
  BlocUser blocUser;

  @override
  Widget build(BuildContext context) {
    blocUser = BlocProvider.of<BlocUser>(context);

    return StreamBuilder(
      stream: blocUser.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.active:
          case ConnectionState.done:
          default:
            return showProfileData(snapshot);
        }
      },
    );
  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      print("No logeado");
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[Text("Usuario no logeado. Haz login")],
          ),
        ],
      );
    } else {
      print("Logeado");
      var user = User(
          uid: snapshot.data.uid,
          name: snapshot.data.displayName,
          email: snapshot.data.email,
          photoUrl: snapshot.data.photoUrl);

      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[ProfileHeader(user), ProfilePlacesList(user)],
          ),
        ],
      );
    }
  }
}
