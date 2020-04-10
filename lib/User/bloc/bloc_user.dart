import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertripapp/Place/model/place.dart';
import 'package:fluttertripapp/Place/repository/firebase_storage_repository.dart';
import 'package:fluttertripapp/Place/ui/widgets/card_image_with_fab_icon.dart';
import 'package:fluttertripapp/User/model/user.dart';
import 'package:fluttertripapp/User/repository/auth_repository.dart';
import 'package:fluttertripapp/User/repository/cloud_firestore_api.dart';
import 'package:fluttertripapp/User/repository/cloud_firestore_repository.dart';
import 'package:fluttertripapp/User/ui/widgets/profile_place.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class BlocUser implements Bloc {
  final _auth_repository = AuthRepository();

  //Flujo de datos - Streams
  //Stream - Firebase
  //StreamController
  Stream<FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => FirebaseAuth.instance.onAuthStateChanged;
  Future<FirebaseUser> get currentUser => FirebaseAuth.instance.currentUser();



  //Casos uso
  //1. SignIn a la aplicación Google
  Future<FirebaseUser> signIn() =>_auth_repository.signInFirebase();
  signOut() => _auth_repository.signOut();

  //2. Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(User user) => _cloudFirestoreRepository.updateUserDataFirestore(user);
  Future<void> updatePlaceData(Place place) => _cloudFirestoreRepository.updatePlaceData(place);
  Stream<QuerySnapshot> placesListStream = Firestore.instance.collection(CloudFirestoreAPI().PLACES).snapshots();
  Stream<QuerySnapshot> get placesStream => placesListStream;
  //List<CardImageWithFabIcon> buildPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreRepository.buildPlaces(placesListSnapshot);
  List<Place> buildPlaces(List<DocumentSnapshot> placesListSnapshot, User user) => _cloudFirestoreRepository.buildPlaces(placesListSnapshot, user);
  Future likePlace(Place place, String uid) => _cloudFirestoreRepository.likePlace(place,uid);

  Stream<QuerySnapshot> myPlacesListSream(String uid) =>
      Firestore.instance.collection(CloudFirestoreAPI().PLACES)
          .where("userOwner", isEqualTo: Firestore.instance.document("${CloudFirestoreAPI().USERS}/${uid}"))
          .snapshots();
  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreRepository.buildMyPlaces(placesListSnapshot);


  final _firebaseStorageRepository = FirebaseStorageRepository();

  Future<StorageUploadTask> uploadFile(String path, File image) => _firebaseStorageRepository.uploadFile(path, image);

  StreamController placeSelectedStreamController = StreamController();
  Stream get placeSelectedStream => placeSelectedStreamController.stream;
  StreamSink get placeSelectedSink => placeSelectedStreamController.sink;


  @override
  void dispose() {
    placeSelectedStreamController.close();
  }
}
