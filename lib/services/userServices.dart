import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forsanway/models/featuresModel.dart';
import 'package:forsanway/models/userModel.dart';
import 'package:forsanway/services/apiUrls.dart';
import 'package:forsanway/services/travelService.dart';
import 'package:forsanway/views/homePage/homeNavigation.dart';
import 'package:forsanway/widgets/changeScreen.dart';
import 'package:forsanway/widgets/sharedPrefs.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

Client _client = Client();

class UserServices {
  Future<String> logInUser(String email, String password, BuildContext context) async {
    String url = ApiUrls.login;

    final response = await client.post(
      Uri.parse(url),
      body: {
        'email': email,
        'password': password,
      },
    );

    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      Fluttertoast.showToast(msg: 'Login successful');
      saveEmail(result['access_token']);
      changeScreenReplacement(context, HomeNavigation());
      return result['user']['email'];
    } else {
      Fluttertoast.showToast(msg: 'Wrong email or password');
      return null;
    }
  }

  Future<Users> createUser(String title, String fullName, String email, String mobileNumber, String password, String confirmPassword, String identityType,
      String identityNumber, BuildContext context) async {
    String url = ApiUrls.registration;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await _client.post(
      Uri.parse(url),
      body: {
        "name": fullName,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "mobile": mobileNumber,
        "title": title,
        "identity_type": identityType,
        "identity_number": identityNumber,
        "user_image": "patrick.jpg"
      },
    );
    final Map result = json.decode(response.body);
    print(response.statusCode);
    try {
      if (response.statusCode == 201) {
        Fluttertoast.showToast(msg: 'Registration Successful');
        await logInUser(email, password, context);
      }
      return Users.fromJson(json.decode(response.body));
    } catch (e) {
      print(response.body);
      print('the error is ' + e.toString());
      return null;
    }
  }

  Future<List<MainFeatures>> mainFeatures() async {
    String url = ApiUrls.mainFeatures;
    final response = await _client.get(Uri.parse(url));
    final Map result = json.decode(response.body);

    List<MainFeatures> features = [];

    if (response.statusCode == 201) {
      for (Map json_ in result['main_features']) {
        features.add(MainFeatures.fromJson(json_));
      }
      return features;
    } else {
      print('error');
      return null;
    }
  }
}
