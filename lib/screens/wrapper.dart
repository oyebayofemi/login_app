import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/models/userModel.dart';
import 'package:login_app/screens/Home_page.dart';
import 'package:login_app/screens/login_page.dart';
import 'package:login_app/screens/register_page.dart';
import 'package:login_app/screens/reset.dart';
import 'package:login_app/services/AuthService_controller.dart';
import 'package:login_app/shared/loading.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    return Consumer<UserModel?>(builder: (context, user, child) {
      if (user != null) {
        final userData = _auth.currentUser;
        return HomePage(uid: userData!.uid);
      } else {
        return LoginPage();
      }
    });
  }
}
