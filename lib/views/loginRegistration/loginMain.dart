import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forsanway/services/userServices.dart';
import 'package:forsanway/views/loginRegistration/registration.dart';
import 'package:forsanway/widgets/changeScreen.dart';
import 'package:forsanway/widgets/customButton.dart';
import 'package:forsanway/widgets/customText.dart';
import 'package:forsanway/widgets/loading.dart';
import 'package:forsanway/widgets/styling.dart';
import 'package:forsanway/widgets/textField.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginMain extends StatefulWidget {
  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  final formKey = new GlobalKey<FormState>();
  // --------------------------------SignIn FORM PARAMETERS-------------------------------
  final emailController = new TextEditingController();
  final passwordControler = new TextEditingController();
  bool obscureText = true;
  bool obscureConfirmText = true;
// ----------------------------------REGISTER & CURRENT USER AUTH-------------------------------
  UserServices _userService = new UserServices();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        color: white,
        child: Stack(
          // alignment: Alignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 70),
              height: MediaQuery.of(context).size.height * .4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)), color: blue),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  CustomText(
                    text: 'Log In to your account',
                    size: 19,
                    color: white,
                  ),
                  Expanded(
                      child: Hero(
                          tag: 'login',
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 250,
                            width: 250,
                          )))
                ],
              ),
            ),
            Center(
              child: FittedBox(
                child: Container(
                  margin: EdgeInsets.all(20),
                  // height: 450,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: grey[100]),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(height: 20),
                          LoginTextField(
                            radius: 10,
                            hint: 'Email Address',
                            controller: emailController,
                            validator: (v) {
                              if (v.isEmpty) {
                                return 'Email Cannot be empty';
                              }
                              Pattern pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = new RegExp(pattern);
                              if (!regex.hasMatch(v))
                                return 'Please make sure your email address format is valid';
                              else
                                return null;
                            },
                          ),
                          SizedBox(height: 10),
                          LoginTextField(
                            iconTwo: obscureText == true
                                ? IconButton(
                                    icon: Icon(Icons.lock),
                                    onPressed: () {
                                      setState(() {
                                        obscureText = false;
                                        
                                      });
                                      
                                    })
                                : IconButton(
                                    icon: Icon(Icons.lock_open),
                                    onPressed: () {
                                      setState(() {
                                        obscureText = true;
                                    
                                      });
                                    }),
                            obscure: obscureText,
                            radius: 10,
                            hint: 'Password',
                            controller: passwordControler,
                            validator: (v) {
                              if (v.isEmpty) {
                                return 'Password field cannot be left empty';
                              }
                              if (v.length < 8) {
                                return 'the password length must not be less than 8';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          CustomFlatButton(
                              textColor: white,
                              iconColor: white,
                              radius: 30,
                              icon: Icons.check,
                              text: 'Sign In',
                              callback: () => signIn(emailController.text, passwordControler.text, context)),
                          SizedBox(height: 10),
                          CartItemRich(
                            lightFont: 'Don\'t have an account? ',
                            boldFont: 'Sign Up',
                            callback: () {
                              changeScreenReplacement(context, Registration());
                            },
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: loading == true,
              child: Center(
                child: Loading(
                  text: 'Verifying your credentials...',
                  size: 17,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  signIn(String email, String password, BuildContext context) async {
    if (formKey.currentState.validate()) {
      print('valid');
      setState(() {
        loading = true;
      });
      await _userService.logInUser(email, password, context);
      setState(() {
        loading = false;
      });
    }
  }
}
