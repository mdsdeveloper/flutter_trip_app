import 'package:flutter/material.dart';
import 'package:fluttertripapp/User/bloc/bloc_user.dart';
import 'package:fluttertripapp/User/model/user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'profile_place.dart';
import '../../../Place/model/place.dart';

class ProfilePlacesList extends StatelessWidget {
  BlocUser blocUser;
  final User user;
  ProfilePlacesList(@required this.user);

  @override
  Widget build(BuildContext context) {
    blocUser = BlocProvider.of<BlocUser>(context);
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: StreamBuilder(
          stream: blocUser.myPlacesListSream(user.uid),
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.active:
              case ConnectionState.done:
              default:
                return Column(
                  children: blocUser.buildMyPlaces(snapshot.data.documents),
                );
            }
          }),
    );
  }
}
