import 'package:flutter/material.dart';
import 'package:fluttertripapp/widgets/buttton_green_sign_in.dart';
import 'package:fluttertripapp/widgets/gradient_back.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignInScreen();
  }
}

class _SignInScreen extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return signInGoogleUI();
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
            ButtonGreenSignIn(text: "Login with email", onPressed: (){}, width: 300.0, height: 50.0,)],
          )
        ],
      ),
    );
  }
}
