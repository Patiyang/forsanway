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
    checkOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return email == ''
        ? Stack(
            children: [
              onboardingChecked == false ? OnBoarding() : LoginMain(),
              Visibility(
                visible: loading == true,
                child: Scaffold(
                    body: Loading(
                        text: 'Connecting. Please wait...',
                        spinkitColor: white,
                        color: blue,
                        textColor: white)),
              )
            ],
          )
        : HomeNavigation();
  }

  checkOnboarding() async {
    setState(() {
      loading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      onboardingChecked = prefs.getBool('onboarding') ?? false;
      loading = false;
    });
    print('THE VALUE OF ONBOARDING IS ' + onboardingChecked.toString());
    setState(() {
      loading = false;
    });
  }

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? '';
    });
  }
}
