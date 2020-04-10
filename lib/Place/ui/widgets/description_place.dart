import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertripapp/Place/model/place.dart';
import 'package:fluttertripapp/User/bloc/bloc_user.dart';
import 'package:fluttertripapp/widgets/button_purple.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class DescriptionPlace extends StatelessWidget {
  String namePlace;
  int stars;
  String descriptionPlace;

  DescriptionPlace(this.namePlace, this.stars, this.descriptionPlace);

  @override
  Widget build(BuildContext context) {
    BlocUser blocUser = BlocProvider.of<BlocUser>(context);

    final star_half = Container(
      margin: EdgeInsets.only(top: 353.0, right: 3.0),
      child: Icon(
        Icons.star_half,
        color: Color(0xFFf2C611),
      ),
    );

    final star_border = Container(
      margin: EdgeInsets.only(top: 353.0, right: 3.0),
      child: Icon(
        Icons.star_border,
        color: Color(0xFFf2C611),
      ),
    );

    final star = Container(
      margin: EdgeInsets.only(top: 353.0, right: 3.0),
      child: Icon(
        Icons.star,
        color: Color(0xFFf2C611),
      ),
    );

    Widget titleStars(Place place) {
      return Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 350.0, left: 20.0, right: 20.0),
            child: Text(
              place.name,
              style: TextStyle(
                  fontFamily: "Lato",
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 370.0),
            child: Text(
              "Likes: ${place.likes}",
              style: TextStyle(
                  fontFamily: "Lato",
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.amber),
              textAlign: TextAlign.left,
            ),
          )
        ],
      );
    }

    Widget descriptionWidget(String descriptionPlace) {
      return Container(
        margin: new EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: new Text(
          descriptionPlace,
          style: const TextStyle(
              fontFamily: "Lato",
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF56575a)),
        ),
      );
    }

    return StreamBuilder(
        stream: blocUser.placeSelectedStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Place place = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                titleStars(place),
                descriptionWidget(place.description),
                ButtonPurple(
                  buttonText: "Navigate",
                  onPressed: () {},
                )
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 400.0, left: 20.0, right: 20.0),
                  child: Text(
                    "Selecciona un lugar",
                    style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            );
          }
        });
  }
}
