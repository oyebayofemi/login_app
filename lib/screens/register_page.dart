import 'package:flutter/material.dart';
import 'package:login_app/screens/login_page.dart';
import 'package:login_app/services/AuthService_controller.dart';
import 'package:login_app/shared/form_field_decoration.dart';
import 'package:login_app/shared/snackbar.dart';
import 'package:login_app/shared/validate_email.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formkey = GlobalKey<FormState>();
  String? email, password, fullname;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Container(
                height: 200,
                width: 350,
                child: Stack(
                  children: [
                    Positioned(
                        top: 50,
                        left: 70,
                        child: Text(
                          'Signup',
                          style: TextStyle(
                              fontFamily: 'Truneo',
                              fontSize: 60,
                              fontWeight: FontWeight.bold),
                        )),
                    Positioned(
                        top: 108,
                        left: 240,
                        child: CircleAvatar(
                          minRadius: 7,
                          backgroundColor: Colors.green,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'FULLNAME:',
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
                      onChanged: (value) => this.fullname = value,
                      validator: (value) => value!.isEmpty
                          ? 'Fullname Field cant be empty'
                          : null,
                      keyboardType: TextInputType.text,
                      decoration: textFormDecoration(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                      height: 40,
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
                                .signUp(email!, password!, context);
                            showSnackBar(context, 'Registration Successful!!!');
                          }
                        },
                        child: Text(
                          'REGISTER',
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
              SizedBox(
                height: 60,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                },
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontFamily: 'Truneo',
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
