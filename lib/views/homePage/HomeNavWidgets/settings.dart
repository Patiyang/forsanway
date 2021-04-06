import 'package:flutter/material.dart';
import 'package:forsanway/views/homePage/homeNavigation.dart';
import 'package:forsanway/widgets/changeScreen.dart';
import 'package:forsanway/widgets/customListTIle.dart';
import 'package:forsanway/widgets/customText.dart';
import 'package:forsanway/widgets/sharedPrefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String selectedLanguage = '';

  @override
  void initState() {
    super.initState();
    checkSelectedLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomListTile(
              callBack: () => changeScreenReplacement(context, HomeNavigation(currentIndex: 3)), leadingIcon: Icons.shopping_cart_sharp, text: 'My Bookings'),
          SizedBox(height: 10),
          CustomListTile(
              callBack: () => changeScreenReplacement(context, HomeNavigation(currentIndex: 4)), leadingIcon: Icons.monetization_on, text: 'My Orders'),
          SizedBox(height: 10),
          CustomListTile(
              callBack: () => showLangDialog(), leadingIcon: Icons.language, text: 'Languages', trailing: CustomText(text: selectedLanguage, size: 17)),
          SizedBox(height: 10),
          CustomListTile(leadingIcon: Icons.call_to_action_rounded, text: 'My Wallet')
        ],
      ),
    );
  }

  showLangDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  width: MediaQuery.of(context).size.width,
                  // height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Select your preffered language below',
                        size: 20,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedLanguage = 'English';
                                });
                                saveLanguage('English');
                                Navigator.pop(context);
                              },
                              child: CustomText(text: 'English', size: 17, overflow: TextOverflow.visible),
                            ),
                            SizedBox(width: 70),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedLanguage = 'Arabic';
                                });
                                saveLanguage('Arabic');
                                Navigator.pop(context);
                              },
                              child: CustomText(text: 'Arabic', size: 17, overflow: TextOverflow.visible),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          );
        });
  }

  checkSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString('language') ?? 'English';
    });
  }
}
