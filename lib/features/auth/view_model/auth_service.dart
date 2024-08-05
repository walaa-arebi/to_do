import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

class AuthServices {
  static final auth = FirebaseAuth.instance;

  Future<Either<String, User?>> createUser(
      String email, String pass, String name) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      User? user = userCredential.user;
      await user?.updateDisplayName(name);
      User? updatedUser = FirebaseAuth.instance.currentUser;
      return Right(updatedUser);
    } on FirebaseAuthException catch (e) {
      return Left(e.message.toString());
    }
  }

  Future<Either<String, User?>> login( String email, String pass) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      User? user = userCredential.user;

      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(e.message.toString());
    }
  }

  Future<void> signOut()async{
    try {
       await auth.signOut();
    } catch(e) {
      // TODO
      log(e.toString());
    }
}

}
