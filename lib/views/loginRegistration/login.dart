import 'dart:io';
import 'package:flutter/material.dart';
import 'package:forsanway/services/userServices.dart';
import 'package:forsanway/views/homePage/homeNavigation.dart';
import 'package:forsanway/views/loginRegistration/loginMain.dart';
import 'package:forsanway/views/loginRegistration/onboarding.dart';
import 'package:forsanway/widgets/loading.dart';
import 'package:forsanway/widgets/styling.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = new GlobalKey<FormState>();
  // --------------------------------SignIn FORM PARAMETERS-------------------------------
  final emailController = new TextEditingController();
  final passwordControler = new TextEditingController();

  bool obscureText = true;
  bool obscureConfirmText = true;
  File profileImage;
  bool onboardingChecked = false;
  String email = '';
// ----------------------------------REGISTER & CURRENT USER AUTH-------------------------------
  UserServices _userService = new UserServices();
  // FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return email == '' ?FutureBuilder(
      future: checkOnboarding(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == true) {
          return LoginMain();
        }
        if (snapshot.data == false) {
          return OnBoarding();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Loading(
              color: white,
              text: 'Loading...',
            ),
          );
        }
        return Container(color: white);
      },
    ): HomeNavigation();
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

  Future<bool> checkOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      onboardingChecked = prefs.getBool('onboarding') ?? false;
    });

    return onboardingChecked;
  }

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? '';
    });
  }
}
