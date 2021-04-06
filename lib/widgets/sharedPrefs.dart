import 'package:shared_preferences/shared_preferences.dart';

Future<String>saveEmail(String emailAddress) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', emailAddress);
  return emailAddress;
}

saveLanguage(String language) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('language', language);
  return language;
}
saveOnboarding(bool onboarding) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('onboarding', onboarding);
  
}

getOnboarding(String onboarding) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getBool(onboarding);
  return onboarding;
}
