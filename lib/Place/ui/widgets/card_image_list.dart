import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertripapp/Place/model/place.dart';
import 'package:fluttertripapp/Place/ui/widgets/card_image_with_fab_icon.dart';
import 'package:fluttertripapp/User/bloc/bloc_user.dart';
import 'package:fluttertripapp/User/model/user.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class CardImageList extends StatefulWidget {
  User user;

  CardImageList(@required this.user);

  @override
  State<StatefulWidget> createState() {
    return _CardImageList();
  }
}

BlocUser blocUser;

class _CardImageList extends State<CardImageList> {
  @override
  Widget build(BuildContext context) {
    blocUser = BlocProvider.of<BlocUser>(context);

    return Container(
        height: 350.0,
        child: StreamBuilder(
            stream: blocUser.placesStream,
            builder: (context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                case ConnectionState.done:
                default:
                  return listViewPlaces(blocUser.buildPlaces(
                      snapshot.data.documents, widget.user));
              }
            }));
  }

  Widget listViewPlaces(List<Place> places) {
    void setLiked(Place place) {
      setState(() {
        place.liked = !place.liked;
        place.likes = place.liked ? place.likes + 1 : place.likes - 1;
        blocUser.placeSelectedSink.add(place);
        blocUser.likePlace(place, widget.user.uid);
      });
    }

    return ListView(
      padding: EdgeInsets.all(25.0),
      scrollDirection: Axis.horizontal,
      children: places.map((place) {
        return GestureDetector(
            onTap: () {
              print("CLICK PLACE: ${place.name}");
              blocUser.placeSelectedSink.add(place);
            },
            child: CardImageWithFabIcon(
              pathImage: place.urlImage,
              width: 300.0,
              height: 250.0,
              left: 20.0,
              iconData: place.liked?Icons.favorite:Icons.favorite_border,
              onPressedFabIcon: () {
                setLiked(place);
              },
              internet: true,
            ),
        );
      }).toList(),
    );
  }
}
