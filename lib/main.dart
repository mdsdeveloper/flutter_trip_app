import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertripapp/platzi_trips.dart';
import 'package:fluttertripapp/User/bloc/bloc_user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'platzi_trips_cupertino.dart';
import 'package:fluttertripapp/User/ui/screens/sign_in_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: BlocUser(),
      child: MaterialApp(title: 'Flutter Demo',
//          home: PlatziTrips()
      home: SignInScreen(),
//      home: PlatziTripsCupertino(),
          ),
    );
  }
}
