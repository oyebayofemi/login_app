import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/screens/register_page.dart';
import 'package:login_app/screens/reset.dart';
import 'package:login_app/services/AuthService_controller.dart';
import 'package:login_app/shared/form_field_decoration.dart';
import 'package:login_app/shared/snackbar.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:login_app/shared/validate_email.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();

  String? email, password;

  //To check fields during submit
  checkFields() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    void _showButtonPressDialog(BuildContext context, String provider) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$provider Button Pressed!'),
        backgroundColor: Colors.black26,
        duration: Duration(milliseconds: 400),
      ));
    }

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                  ),
                  child: Container(
                    height: 200,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 50,
                          child: Text(
                            'Hello',
                            style: TextStyle(
                              fontFamily: 'Truneo',
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 95,
                          child: Text(
                            'There',
                            style: TextStyle(
                              fontFamily: 'Truneo',
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                            top: 143,
                            left: 182,
                            child: CircleAvatar(
                              maxRadius: 9,
                              backgroundColor: Colors.green,
                            ))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'EMAIL:',
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Truneo',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onChanged: (value) => this.email = value,
                          //autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => value!.isEmpty
                              ? 'Email Field cant be empty'
                              : validateEmail(value, context),
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFormDecoration(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'PASSWORD:',
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Truneo',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) => this.password = value,
                          validator: (value) {
                            if (value!.length < 6) {
                              return 'Password must be more than 6 characters';
                            } else if (value.isEmpty) {
                              return 'Password Field cant be empty';
                            }
                          },
                          keyboardType: TextInputType.text,
                          decoration: textFormDecoration(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/reset');
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 15),
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontFamily: 'Truneo',
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ButtonTheme(
                          buttonColor: Colors.green,
                          minWidth: double.infinity,
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(34)),
                          child: RaisedButton(
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                AuthServiceControllerProvider()
                                    .signin(email!, password!, context);
                              }
                            },
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Truneo',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Divider(),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Column(
                    children: [
                      ButtonTheme(
                        minWidth: double.infinity,
                        height: 900,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: Colors.black)),
                        child: SignInButton(
                          Buttons.Google,
                          onPressed: () async {
                            final provider =
                                Provider.of<AuthServiceControllerProvider>(
                                    context,
                                    listen: false);

                            provider.signInWithGoogle();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('New Account?'),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: Text(
                          'Register Here',
                          style: TextStyle(
                              color: Colors.green,
                              fontFamily: 'Truneo',
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
