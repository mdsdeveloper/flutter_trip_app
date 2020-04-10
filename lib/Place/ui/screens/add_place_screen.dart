import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertripapp/Place/model/place.dart';
import 'package:fluttertripapp/Place/ui/widgets/card_image_with_fab_icon.dart';
import 'package:fluttertripapp/Place/ui/widgets/title_input_location.dart';
import 'package:fluttertripapp/User/bloc/bloc_user.dart';
import 'package:fluttertripapp/widgets/button_purple.dart';
import 'package:fluttertripapp/widgets/gradient_back.dart';
import 'package:fluttertripapp/widgets/text_input.dart';
import 'package:fluttertripapp/widgets/title_header.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class AddPlaceScreen extends StatefulWidget {
  final File image;

  AddPlaceScreen({Key key, this.image});

  @override
  State<StatefulWidget> createState() {
    return _AddPlaceScreen();
  }
}

class _AddPlaceScreen extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    BlocUser blocUser = BlocProvider.of<BlocUser>(context);
    final _controllerTitlePlace = TextEditingController();
    final _controllerTitleDescriptonPlace = TextEditingController();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradientBack(height: 300.0),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 25.0, left: 5.0),
                child: SizedBox(
                  height: 45.0,
                  width: 45.0,
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left,
                        color: Colors.white, size: 45),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Flexible(
                  child: Container(
                padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 10.0),
                child: TitleHeader(
                  title: "Add a new place",
                ),
              ))
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 120.0, bottom: 20.0),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: CardImageWithFabIcon(
                    pathImage: widget.image.path,
                    // "assets/img/beach_palm.jpeg",
                    iconData: Icons.camera_alt,
                    width: 350.0,
                    height: 250.0,
                    left: 0.0,
                    internet: false,
                  ),
                ), // Foto
                Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextInput(
                      hintText: "Title",
                      inputType: null,
                      maxLines: 1,
                      controller: _controllerTitlePlace),
                ),
                TextInput(
                  hintText: "Description",
                  inputType: TextInputType.multiline,
                  maxLines: 4,
                  controller: _controllerTitleDescriptonPlace,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: TitleInputLocation(
                    hintText: "Add Location",
                    iconData: Icons.location_on,
                  ),
                ),
                Container(
                  width: 70.0,
                  child: ButtonPurple(
                    buttonText: "Add place",
                    onPressed: () {
                      // ID del usuario logeado actualmente
                      blocUser.currentUser.then((FirebaseUser user) {
                        if (user != null) {
                          String uid = user.uid;
                          String path = "$uid/${DateTime.now().toString()}.jpg";
                          //1 firebase storage
                          // url imagen
                          blocUser
                              .uploadFile(path, widget.image)
                              .then((StorageUploadTask storageUploadTask) {
                            storageUploadTask.onComplete
                                .then((StorageTaskSnapshot snapshot) {
                              snapshot.ref.getDownloadURL().then((urlImage) {
                                print("URLIMAGE: ${urlImage}");
                                //2 cloud firestore api
                                // place-title, description, userowner, likes
                                blocUser
                                    .updatePlaceData(Place(
                                        name: _controllerTitlePlace.text,
                                        description:
                                            _controllerTitleDescriptonPlace.text,
                                        urlImage: urlImage,
                                        likes: 0,
                                        liked: false))
                                    .whenComplete(() {
                                  print("TERMINO");
                                  Navigator.pop(context);
                                });
                              });
                            });
                          });
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
