import 'package:flutter/material.dart';
import 'package:forsanway/views/homePage/HomeNavWidgets/cart.dart';
import 'package:forsanway/views/homePage/HomeNavWidgets/homePage/homePage.dart';
import 'package:forsanway/views/homePage/HomeNavWidgets/orders.dart';
import 'package:forsanway/views/homePage/HomeNavWidgets/profile.dart';
import 'package:forsanway/views/homePage/HomeNavWidgets/settings.dart';
import 'package:forsanway/views/loginRegistration/login.dart';
import 'package:forsanway/widgets/changeScreen.dart';
import 'package:forsanway/widgets/customButton.dart';
import 'package:forsanway/widgets/customText.dart';
import 'package:forsanway/widgets/sharedPrefs.dart';
import 'package:forsanway/widgets/styling.dart';

enum Pages { settings, profile, home, cart, orders }

///THIS IS THE VERY FIRST PAGE THAT IS DISPLAYED TO THE USER UPON SUCCESSFUL LOGIN/REGISTRATION
///IT IS ALSO THE ROOT WIDGET TO THE BOTTOM NABIGATION BAR PAGES
// ignore: must_be_immutable
class HomeNavigation extends StatefulWidget {
  String appBarTitle;
  int currentIndex;
 
  HomeNavigation({Key key, this.appBarTitle, this.currentIndex}) : super(key: key);
  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int currentIndex = 0;
  String appBarText = '';
  Pages screens = Pages.home;
  List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.settings), title: CustomText(text: 'Settings')),
    BottomNavigationBarItem(icon: Icon(Icons.person), title: CustomText(text: 'Profile')),
    BottomNavigationBarItem(
        icon: Container(
            decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: blue, blurRadius: 3, spreadRadius: 15)]),
            child: Image.asset('assets/images/steeringWheel.png', height: 27,width: 27,)),
        title: SizedBox.shrink()),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), title: CustomText(text: 'Cart')),
    BottomNavigationBarItem(icon: Icon(Icons.store_mall_directory_outlined), title: CustomText(text: 'Orders'))
  ];
  @override
  void initState() {
    super.initState();
    // currentIndex = 2;
    widget.appBarTitle = 'Home';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: blue,
          title: CustomText(text: appBarTitles[widget.currentIndex??2], color: white),
          actions: [IconButton(icon: Icon(Icons.exit_to_app), onPressed: () => showLogoutDialog())],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: blue),
                accountName: CustomText(text: 'Patrick Mwangi', color: white, size: 16),
                accountEmail: CustomText(text: 'test@gmail.com', color: white, size: 20),
              )
            ],
          ),
        ),
        body: tabs[widget.currentIndex ?? 2],
        bottomNavigationBar: BottomNavigationBar(
          unselectedIconTheme: IconThemeData(color: blue, size: 17),
          selectedIconTheme: IconThemeData(color: blue),
          showUnselectedLabels: true,
          items: bottomNavBarItems,
          currentIndex: widget.currentIndex ?? 2,
          onTap: (int index) {
            setState(() {
              widget.currentIndex = index;
            });
            selectedPage();
            // togglePages();
          },
        ),
      ),
    );
  }

  dynamic selectedPage() {
    switch (widget.currentIndex) {
      case 0:
        return widget.appBarTitle = 'Settings';
        break;
      case 1:
        return widget.appBarTitle = 'Profile';
        break;
      case 2:
        return widget.appBarTitle = 'Home';
        break;
      case 3:
        return widget.appBarTitle = 'Cart';
        break;
      case 4:
        return widget.appBarTitle = 'Orders';
        break;

      default:
        return widget.appBarTitle = 'Home';
    }
  }

  List<Widget> tabs = [Settings(), Profile(), HomePage(), Cart(), Orders()];
  List<String> appBarTitles = ['Settings', 'Profile', 'Home', 'Cart', 'Orders', 'Home'];
  Widget selectedScreen() {
    switch (screens) {
      case Pages.settings:
        return Settings();
        break;
      case Pages.profile:
        return Profile();
        break;
      case Pages.home:
        return HomePage();
        break;
      case Pages.cart:
        return Cart();
        break;
      case Pages.orders:
        return Orders();
        break;
      default:
        return HomeNavigation();
    }
  }

  togglePages() {
    if (currentIndex == 0) {
      setState(() {
        screens = Pages.settings;
      });
    }
    if (currentIndex == 1) {
      setState(() {
        screens = Pages.profile;
      });
    }
    if (currentIndex == 2) {
      setState(() {
        screens = Pages.home;
      });
    }
    if (currentIndex == 3) {
      setState(() {
        screens = Pages.cart;
      });
    }
    if (currentIndex == 4) {
      setState(() {
        screens = Pages.orders;
      });
    }
  }

  showLogoutDialog() {
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
                        text: 'Are you sure you wat to log out?',
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
                            GestureDetector(
                              onTap: () {
                                saveEmail('').then((value) => changeScreenReplacement(context, SignIn()));
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: CustomText(text: 'YES', size: 17, overflow: TextOverflow.visible),
                            ),
                            SizedBox(width: 70),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: CustomText(text: 'NO', size: 17, overflow: TextOverflow.visible),
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
