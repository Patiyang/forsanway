import 'package:flutter/material.dart';
import 'package:forsanway/services/apiUrls.dart';
import 'package:forsanway/services/cityServices.dart';
import 'package:forsanway/views/homePage/HomeNavWidgets/homePage/shipment/shipment.dart';
import 'package:forsanway/views/homePage/HomeNavWidgets/homePage/travel/travel.dart';
import 'package:forsanway/widgets/customButton.dart';
import 'package:forsanway/widgets/customText.dart';
import 'package:forsanway/widgets/loading.dart';
import 'package:forsanway/widgets/styling.dart';
import 'package:transparent_image/transparent_image.dart';

enum Pages { travel, shipment }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Pages selectedPage = Pages.travel;
  CityServices cityServices = new CityServices();
  List<String> cities = [];

  String origin = '';
  String destination = '';
  String originUrl;
  String destinationUrl;
  List destinationImages = [];

  int originId = 0;
  int destinationId = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      primary: false,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            // alignment: Alignment.topCenter,
            children: [
              originUrl == null || destinationUrl == null
                  ? Container(
                      height: MediaQuery.of(context).size.height * .3,
                      width: MediaQuery.of(context).size.width,
                      color: grey[200],
                      child: FutureBuilder(
                        future: cityServices.getCityList(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            cities.clear();
                            Map result = snapshot.data;
                            for (int i = 0; i < result['cities'].length; i++) {
                              cities.add(result['cities'][i]['name']);
                              // print(cities);
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: white),
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          icon: Icon(Icons.arrow_drop_down),
                                          hint: CustomText(text: 'What state are you from?', color: black),
                                          value: origin.isNotEmpty ? origin : null,
                                          onChanged: (val) {
                                            setState(() {
                                              origin = val;
                                            });
                                          },
                                          items: cities
                                              .map((e) => DropdownMenuItem(
                                                    onTap: () {
                                                      for (int i = 0; i < cities.length; i++) {
                                                        // print(cities.indexOf(e));
                                                        originUrl = result['cities'][cities.indexOf(e)]['images'][0]['url'];
                                                      }
                                                      print(originUrl);
                                                      setState(() {
                                                        originId = result['cities'][cities.indexOf(e)]['id'];
                                                      });
                                                    },
                                                    child: CustomText(text: e),
                                                    value: e,
                                                  ))
                                              .toList())),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: white),
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          icon: Icon(Icons.arrow_drop_down),
                                          hint: CustomText(text: 'What state are you going to?', color: black),
                                          value: destination.isNotEmpty ? destination : null,
                                          onChanged: (val) {
                                            setState(() {
                                              destination = val;
                                            });
                                          },
                                          items: cities
                                              .map((e) => DropdownMenuItem(
                                                    onTap: () {
                                                      destinationUrl = result['cities'][cities.indexOf(e)]['images'][0]['url'];
                                                      print(destinationUrl);
                                                      setState(() {
                                                        for (int i = 0; i < result['cities'][cities.indexOf(e)]['images'].length; i++) {
                                                          destinationImages.add(result['cities'][cities.indexOf(e)]['images'][i]['url']);
                                                        }
                                                        print(destinationImages);
                                                        destinationId = result['cities'][cities.indexOf(e)]['id'];
                                                      });
                                                    },
                                                    child: CustomText(text: e),
                                                    value: e,
                                                  ))
                                              .toList())),
                                )
                              ],
                            );
                          }
                          if ((snapshot.connectionState == ConnectionState.waiting)) {
                            return Loading(
                              text: 'Fetching Cities. Please wait...',
                            );
                          }
                          if (!snapshot.hasData) {
                            return Center(
                              child: CustomText(text: 'No data found...'),
                            );
                          }
                          return Container();
                        },
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * .3,
                      width: MediaQuery.of(context).size.width,
                      color: grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(child: LoadingImages(color: Colors.transparent)),
                              FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: '${ApiUrls.imageUrl}' + originUrl,
                                  fit: BoxFit.fill,
                                  height: (MediaQuery.of(context).size.height * .3) / 2,
                                  width: MediaQuery.of(context).size.width),
                              Container(
                                  decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue.withOpacity(.9), Colors.indigo.withOpacity(.2)])),
                                  height: (MediaQuery.of(context).size.height * .3) / 2,
                                  width: MediaQuery.of(context).size.width),
                              Padding(
                                padding: const EdgeInsets.only(right: 198.0, top: 38),
                                child: CustomText(
                                  text: origin.toUpperCase(),
                                  color: white,
                                  size: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(child: LoadingImages(color: Colors.transparent)),
                              FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: '${ApiUrls.imageUrl}' + destinationUrl,
                                  fit: BoxFit.fill,
                                  height: (MediaQuery.of(context).size.height * .3) / 2,
                                  width: MediaQuery.of(context).size.width),
                              Container(
                                  decoration:
                                      BoxDecoration(gradient: LinearGradient(colors: [Colors.blue[200].withOpacity(.8), Colors.indigo.withOpacity(.2)])),
                                  height: (MediaQuery.of(context).size.height * .3) / 2,
                                  width: MediaQuery.of(context).size.width),
                              Padding(
                                padding: const EdgeInsets.only(right: 198.0, top: 38),
                                child: CustomText(
                                  text: destination.toUpperCase(),
                                  color: white,
                                  size: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 185),
                  child: Container(
                    height: 35,
                    width: MediaQuery.of(context).size.width * .6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: white,
                      boxShadow: [
                        BoxShadow(
                          color: grey[300],
                          blurRadius: 3,
                          spreadRadius: 2,
                          offset: Offset(2, 1),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: CustomFlatButton(
                                color: selectedPage == Pages.travel ? blue : grey,
                                height: 25,
                                text: 'Travel',
                                radius: 30,
                                callback: () {
                                  setState(() {
                                    selectedPage = Pages.travel;
                                    destinationUrl = null;
                                    originUrl = null;
                                  });
                                },
                                icon: Icons.location_on,
                                width: 80),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: CustomFlatButton(fontSize: 10,
                                color: selectedPage == Pages.shipment ? blue : grey,
                                height: 25,
                                text: 'Shipment',
                                radius: 30,
                                callback: () {
                                  setState(() {
                                    selectedPage = Pages.shipment;
                                    destinationUrl = null;
                                    originUrl = null;
                                  });
                                },
                                icon: Icons.delivery_dining,
                                width: 80),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10),
        selectedService()
      ],
    );
  }

  Widget selectedService() {
    switch (selectedPage) {
      case Pages.shipment:
        return Shipment(
          destination: destination,
          origin: origin,
          originId: originId,
          destinationId: destinationId,
          destinationImages: destinationImages,
        );
        break;
      case Pages.travel:
        return Travel(
          destination: destination,
          origin: origin,
          originId: originId,
          destinationId: destinationId,
          destinationImages: destinationImages,
        );
        break;
      default:
        return Container();
    }
  }
}
