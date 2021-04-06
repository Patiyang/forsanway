import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forsanway/services/userServices.dart';
import 'package:forsanway/views/homePage/homeNavigation.dart';
import 'package:forsanway/views/loginRegistration/loginMain.dart';
import 'package:forsanway/views/loginRegistration/onboarding.dart';
import 'package:forsanway/widgets/customText.dart';
import 'package:forsanway/widgets/loading.dart';
import 'package:forsanway/widgets/styling.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool onboardingChecked = false;
  String email = '';
  bool loading = false;

  @override
  void initState() {
    super.initState();
    checkLogin();
   
  }

  @override
  Widget build(BuildContext context) {
    return email == ''
        ? Scaffold(
            body: FutureBuilder(
              future: checkOnboarding(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  onboardingChecked = snapshot.data;
                  return onboardingChecked == true ? LoginMain() : OnBoarding();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loading(text: 'Connecting. Please wait...', spinkitColor: white, color: blue, textColor: white);
                }
                return Container();
              },
            ),
          )
        : HomeNavigation();
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
