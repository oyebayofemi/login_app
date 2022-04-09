import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_app/models/userModel.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:login_app/shared/snackbar.dart';

class AuthServiceControllerProvider extends ChangeNotifier {
  late bool _isSigningIn;
  //UserModel? userModel;
  FirebaseAuth _auth = FirebaseAuth.instance;

  AuthServiceControllerProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  UserModel? _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return UserModel(
        email: user.email,
        id: user.uid,
        name: user.displayName,
        pictureModel: user.photoURL);
  }

  Stream<UserModel?> get onAuthStateChanged {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebase(user!));
  }

  Future<UserModel?> signUp(
      String email, String password, BuildContext context) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = authResult.user;

      return _userFromFirebase(user!);
      // return Future.value(true);
    } catch (error) {
      switch (error.toString()) {
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          showSnackBar(context, "Email Already Exists");
          break;
        case 'ERROR_INVALID_EMAIL':
          showSnackBar(context, "Invalid Email Address");
          break;
        case 'ERROR_WEAK_PASSWORD':
          showSnackBar(context, "Please Choose a stronger password");
          break;
      }
      return Future.value(null);
    }
  }

  Future<UserModel?> signin(
      String email, String password, BuildContext context) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;

      return _userFromFirebase(user!);
      // return Future.value(true);
    } catch (e) {
      // simply passing error code as a message
      print(e.toString());
      showSnackBar(context, e.toString());
      switch (e.toString()) {
        case 'ERROR_INVALID_EMAIL':
          showSnackBar(context, e.toString());
          break;
        case 'ERROR_WRONG_PASSWORD':
          showSnackBar(context, e.toString());
          break;
        case 'ERROR_USER_NOT_FOUND':
          showSnackBar(context, e.toString());
          break;
        case 'ERROR_USER_DISABLED':
          showSnackBar(context, e.toString());
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          showSnackBar(context, e.toString());
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          showSnackBar(context, e.toString());
          break;
      }
      // since we are not actually continuing after displaying errors
      // the false value will not be returned
      // hence we don't have to check the valur returned in from the signin function
      // whenever we call it anywhere
      return Future.value(null);
    }
  }

  Future<UserModel?> signInWithGoogle() async {
    isSigningIn = true;

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      isSigningIn = false;
      final authResult = await _auth.signInWithCredential(credential);

      // userModel = UserModel(
      //     email: googleUser.email,
      //     id: googleUser.id,
      //     pictureModel: googleUser.photoUrl,
      //     name: googleUser.displayName);

      User? user = authResult.user;

      return _userFromFirebase(user!);

      //notifyListeners();
    } else {
      isSigningIn = false;
      return null;
    }
  }

  Future<UserModel?> currentUser() async {
    final user = await _auth.currentUser;
    return _userFromFirebase(user!);
  }

  resetPasswordLink(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  Future signout() async {
    _auth.signOut();
    FacebookAuth.i.logOut();
    // nbvawait GoogleSignIn.signOut();
    GoogleSignIn().signOut();
    //userModel = null;

    final user = await _auth.currentUser;
    User users = user!;
    print(users.providerData[1].providerId);
    if (users.providerData[1].providerId == 'google.com') {
      await GoogleSignIn().signOut();
    }
    await _auth.signOut();
    notifyListeners();
  }
}
