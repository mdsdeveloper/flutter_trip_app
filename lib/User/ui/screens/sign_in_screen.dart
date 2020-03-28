import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertripapp/Place/ui/screens/platzi_trips.dart';
import 'package:fluttertripapp/User/bloc/bloc_user.dart';
import 'package:fluttertripapp/widgets/buttton_green_sign_in.dart';
import 'package:fluttertripapp/widgets/gradient_back.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignInScreen();
  }
}

class _SignInScreen extends State<SignInScreen> {

  BlocUser blocUser;
  @override
  Widget build(BuildContext context) {
    blocUser = BlocProvider.of(context);
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession(){
    return StreamBuilder(
      stream: blocUser.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        // snapshot contiene los datos del usuario
        if(!snapshot.hasData || snapshot.hasError){
          return signInGoogleUI();
        }else{
          return PlatziTrips();
        }
      },
    );
  }
  Widget signInGoogleUI() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GradientBack("", null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center ,
            children: <Widget>[
              Text(
                "Welcome \n This is your travel app",
                style: TextStyle(
                    fontFamily: "Lato",
                    fontSize: 37,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ButtonGreenSignIn(text: "Login with email", onPressed: (){
              blocUser.signIn().then((FirebaseUser user) => print("El usuario es ${user.displayName}"));
            }, width: 300.0, height: 50.0,)],
          )
        ],
      ),
    );
  }
}
