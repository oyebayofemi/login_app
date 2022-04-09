import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_app/models/userModel.dart';
import 'package:login_app/screens/login_page.dart';
import 'package:login_app/screens/register_page.dart';
import 'package:login_app/screens/reset.dart';
import 'package:login_app/screens/wrapper.dart';
import 'package:login_app/services/AuthService_controller.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthServiceControllerProvider(),
        ),
        StreamProvider<UserModel?>(
          catchError: (User, UserModel) => null,
          create: (context) =>
              context.read<AuthServiceControllerProvider>().onAuthStateChanged,
          initialData: null,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes: {
          '/reset': (context) => ResetPage(),
          '/register': (context) => RegisterPage(),
          '/login': (context) => LoginPage(),
        },
      ),
    );
  }
}
