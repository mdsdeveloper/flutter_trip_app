import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertripapp/User/model/user.dart';
import 'package:fluttertripapp/User/repository/auth_repository.dart';
import 'package:fluttertripapp/User/repository/cloud_firestore_repository.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class BlocUser implements Bloc {
  final _authRepository = AuthRepository();
// Flujo de datos- Streams Controla el estado de la autenticacion del usuario
  Stream<FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => streamFirebase;

  // Case SignIn con Google
  Future<FirebaseUser> signIn(){
    return _authRepository.signInFirebase();
  }
  signOuth(){
    _authRepository.signOuth();
  }

//  Registrar usuario en bd
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(User user) => _cloudFirestoreRepository.updateUserDataFirestore(user);

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
