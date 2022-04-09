import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/models/userModel.dart';
import 'package:login_app/services/AuthService_controller.dart';
import 'package:provider/provider.dart';

class drawers extends StatelessWidget {
  const drawers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    final users = AuthServiceControllerProvider().currentUser();
    Future<UserModel?> userss =
        Provider.of<AuthServiceControllerProvider>(context, listen: false)
            .currentUser();

    //print(user);
    print(users);
    print(users.toString());
    print(userss.asStream().map((event) => print(event!.email)));
    return Drawer(
      child: ListView(padding: EdgeInsets.all(0), children: <Widget>[
        /*DrawerHeader(
          child: Text('Hello'),
          decoration: BoxDecoration(
            color: Colors.red,
          ),
        ),*/

        UserAccountsDrawerHeader(
          accountName: Text('${user!.displayName}'),
          accountEmail: Text('${user.email}'),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(
              '',
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Oyebayo Femi'),
          subtitle: Text('Head developer'),
          trailing: Icon(Icons.edit_sharp),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text('Email'),
          subtitle: Text('oyebayo1000@yahoo.com'),
          trailing: Icon(Icons.edit_sharp),
        )
      ]),
    );
  }
}
