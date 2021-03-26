import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forsanway/widgets/changeScreen.dart';
import 'package:forsanway/widgets/customText.dart';
import 'package:forsanway/widgets/sharedPrefs.dart';
import 'package:forsanway/widgets/styling.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'loginMain.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final pageController = PageController();
  int currentIndex = 0;
  String selectedLanguage = '';

  @override
  void initState() {
    selectedLanguage = 'Eng';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Container(
        height: 10,
        // color: green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => showLangDialog(),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: 40,
                width: 90,
                decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)), color: white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomText(text: selectedLanguage),
                    Icon(Icons.language),
                  ],
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            Expanded(
              child: Center(child: Image.asset('assets/images/logo.png')),
            ),
          ],
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: CustomText(
          text: '''SECOND PAGE Lorem ipsum dolor sit amet, consectetur adipiscing elit, 
              sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
              Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
              Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur''',
          textAlign: TextAlign.center,
          color: white,
          size: 20,
          maxLines: 20,
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: CustomText(
          text: '''THIRD PAGELorem ipsum dolor sit amet, consectetur adipiscing elit, 
              sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
              Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
              Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur''',
          textAlign: TextAlign.center,
          color: white,
          size: 20,
          maxLines: 20,
        ),
      )
    ];
    return Scaffold(
      backgroundColor: blue,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(40),
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool('onboarding', true);
                  changeScreenReplacement(context, LoginMain());
                },
                child: CustomText(
                  text: 'Skip',
                  size: 20,
                  color: white,
                )),
            alignment: Alignment.topRight,
          ),
          Expanded(
            child: PageView(
                onPageChanged: (val) {
                  setState(() {
                    currentIndex = val;
                  });
                },
                controller: pageController,
                allowImplicitScrolling: false,
                children: pages),
          ),
          Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(3, (index) => buildDot(index, context))),
          ),
          Container(
            padding: EdgeInsets.all(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    child: CustomText(text: 'Next', size: 20, color: white),
                    onTap: () async {
                      Fluttertoast.showToast(msg: 'msg');
                      if (currentIndex == 2) {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setBool('onboarding', true);
                        changeScreenReplacement(context, LoginMain());
                      } else {
                        pageController.nextPage(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.bounceOut,
                        );
                      }
                      // print(pageController.)
                    }),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: white,
                )
              ],
            ),
            alignment: Alignment.bottomRight,
            width: MediaQuery.of(context).size.width,
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 5,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white,
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
                                  selectedLanguage = 'Eng';
                                });
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
}
