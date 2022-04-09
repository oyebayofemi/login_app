import 'package:flutter/material.dart';
import 'package:login_app/screens/login_page.dart';
import 'package:login_app/services/AuthService_controller.dart';
import 'package:login_app/shared/form_field_decoration.dart';
import 'package:login_app/shared/snackbar.dart';
import 'package:login_app/shared/validate_email.dart';

class ResetPage extends StatefulWidget {
  ResetPage({Key? key}) : super(key: key);

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final formkey = GlobalKey<FormState>();
  String? email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: formkey,
        child: Column(
          children: [
            SizedBox(
              height: 130,
            ),
            Container(
              height: 200,
              width: 350,
              child: Stack(
                children: [
                  Positioned(
                      top: 50,
                      left: 70,
                      child: Text(
                        'Reset',
                        style: TextStyle(
                            fontFamily: 'Truneo',
                            fontSize: 60,
                            fontWeight: FontWeight.bold),
                      )),
                  Positioned(
                      top: 94,
                      left: 225,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value!.isEmpty
                        ? 'Email Field cant be empty'
                        : validateEmail(value, context),
                    keyboardType: TextInputType.emailAddress,
                    decoration: textFormDecoration(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonTheme(
                    buttonColor: Colors.green,
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(34)),
                    child: RaisedButton(
                      onPressed: () {
                        try {
                          if (formkey.currentState!.validate()) {
                            AuthServiceControllerProvider()
                                .resetPasswordLink(email!);
                            showSnackBar(context, 'Mail sent to email');
                          }
                        } catch (e) {
                          showSnackBar(context, e.toString());
                        }
                      },
                      child: Text(
                        'RESET',
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
                'Go Back',
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
      )),
    );
  }
}
