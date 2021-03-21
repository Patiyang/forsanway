import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forsanway/models/featuresModel.dart';
import 'package:forsanway/services/apiUrls.dart';
import 'package:forsanway/services/travelService.dart';
import 'package:forsanway/services/userServices.dart';
import 'package:forsanway/views/homePage/HomeNavWidgets/homePage/travel/travelSearch.dart';
import 'package:forsanway/widgets/changeScreen.dart';
import 'package:forsanway/widgets/customButton.dart';
import 'package:forsanway/widgets/customText.dart';
import 'package:forsanway/widgets/loading.dart';
import 'package:forsanway/widgets/styling.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class Travel extends StatefulWidget {
  final String origin;
  final String destination;
  final List destinationImages;
  final int originId;
  final int destinationId;

  const Travel({Key key, this.origin, this.destination, this.originId, this.destinationId, this.destinationImages}) : super(key: key);
  @override
  _TravelState createState() => _TravelState();
}

class _TravelState extends State<Travel> {
  String weekDay = '';
  String month = '';
  String dateOfMonth = '';
  int passengerCount = 1;
  DateTime dateTime = DateTime.now();
  String tripDate = DateTime.now().toString().substring(0, 10);
  List<int> featuresId = [];
  List<String> selectedServices = [];
  String selectedFeatures = '';

  List<MainFeatures> mainFeatures = [];
  List<CarFeaturesModel> carFeatures = [];
  UserServices userServices = new UserServices();
  TravelService travelService = new TravelService();

  bool loadCarFeatures = false;
  @override
  void initState() {
    super.initState();
    getCarFeatures();
    getMainFeatures();
    getCurrentDate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      currentTime: dateTime,
                      onConfirm: (val) {
                        setState(() {
                          dateOfMonth = val.day.toString();
                          month = DateFormat.MMMM().format(DateTime.parse(val.toString()));
                          weekDay = DateFormat.EEEE().format(DateTime.parse(val.toString()));
                          dateTime = val;
                        });
                        tripDate = val.toString().substring(0, 10);
                        print(tripDate);
                      },
                    );
                  },
                  child: Container(
                    height: 120,
                    width: 180,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        children: [
                          CustomText(text: 'DEPARTURE', textAlign: TextAlign.center, size: 19, fontWeight: FontWeight.w800, color: grey),
                          SizedBox(height: 14),
                          Expanded(
                            child: Container(
                              height: 70,
                              // width: 170,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomText(text: dateOfMonth, size: 90, color: blue),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        FittedBox(child: CustomText(text: month, size: 30, fontWeight: FontWeight.bold, color: grey)),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        CustomText(text: weekDay, size: 25, fontWeight: FontWeight.w800, color: grey)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: white,
                      boxShadow: [
                        BoxShadow(
                          color: grey[300],
                          blurRadius: 2,
                          spreadRadius: 1,
                          // offset: Offset(2, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 120,
                    width: 180,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        children: [
                          CustomText(text: 'PASSENGER', textAlign: TextAlign.center, size: 19, fontWeight: FontWeight.w800, color: grey),
                          SizedBox(height: 14),
                          Container(
                            height: 70,
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomText(text: passengerCount.toString(), color: blue, size: 90),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () => addPassengers(),
                                      child: Container(
                                        child: Icon(Icons.add, size: 20, color: grey[900]),
                                        width: 50,
                                        height: 25,
                                        decoration:
                                            BoxDecoration(border: Border.all(color: grey[300], width: 2), borderRadius: BorderRadius.all(Radius.circular(20))),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    InkWell(
                                      onTap: () => decreasePassengers(),
                                      child: Container(
                                        child: Icon(Icons.remove, size: 20, color: grey[900]),
                                        width: 50,
                                        height: 25,
                                        decoration:
                                            BoxDecoration(border: Border.all(color: grey[300], width: 2), borderRadius: BorderRadius.all(Radius.circular(20))),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: white,
                      boxShadow: [
                        BoxShadow(
                          color: grey[300],
                          blurRadius: 2,
                          spreadRadius: 1,
                          // offset: Offset(2, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      // padding: EdgeInsets.only(left: 30),
                      scrollDirection: Axis.horizontal,
                      primary: false,
                      itemCount: carFeatures.length,
                      itemBuilder: (BuildContext context, int index) {
                        var carFeature = carFeatures[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: GestureDetector(
                            onTap: () {
                              featuresId.contains(carFeature.id) ? featuresId.remove(carFeature.id) : featuresId.add(carFeature.id);
                              selectedServices.contains(carFeature.name) ? selectedServices.remove(carFeature.name) : selectedServices.add(carFeature.name);
                              setState(() {
                                selectedFeatures =
                                    featuresId.toString().replaceAll(RegExp(r' '), '').replaceAll(RegExp(r'\['), '').replaceAll(RegExp(r'\]'), '');
                              });

                              print(carFeature.images['url']);

                              // print(selectedServices);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration:
                                  BoxDecoration(border: Border.all(color: grey[300]), borderRadius: BorderRadius.all(Radius.circular(10)), color: white),
                              child: Container(
                                height: 47,
                                width: 47,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)), color: featuresId.contains(carFeature.id) ? green[300] : grey[200]),
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: Stack(
                                      children: [
                                        LoadingImages(),
                                        FadeInImage.memoryNetwork(
                                            placeholder: kTransparentImage,
                                            image: '${ApiUrls.imageUrl}' + carFeature.images['url'],
                                            fit: BoxFit.fill,
                                            height: (MediaQuery.of(context).size.height * .3) / 2,
                                            width: MediaQuery.of(context).size.width),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Visibility(
                    visible: loadCarFeatures == true,
                    child: Loading(
                      text: 'Fetching car features',
                      size: 19,
                    ))
              ],
            ),
            SizedBox(height: 10),
            CustomText(text: 'Selected Services', fontWeight: FontWeight.w600, color: grey),
            SizedBox(height: 10),
            CustomText(
              text: selectedServices.length > 0
                  ? '${selectedServices.toString().replaceAll(RegExp(r'\['), '').replaceAll(RegExp(r'\]'), '')}'
                  : 'No services chosen yet..',
              size: selectedServices.length > 0 ? 17 : 14,
              letterSpacing: .3,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 10),
            CustomFlatButton(
              icon: Icons.search,
              callback: () => showTripDialog(),
              color: green[700],
              radius: 30,
              text: 'Search',
              fontSize: 17,
              iconSize: 27,
            ),
          ],
        ),
      ),
    );
  }

  getCurrentDate() {
    setState(() {
      weekDay = DateFormat.EEEE().format(DateTime.now());
      month = DateFormat.MMMM().format(DateTime.now());
      dateOfMonth = DateTime.now().day.toString();
    });
  }

  addPassengers() {
    setState(() {
      passengerCount++;
    });
    print(passengerCount);
  }

  decreasePassengers() {
    if (passengerCount > 1) {
      setState(() {
        passengerCount--;
      });
    }
  }

  showTripDialog() {
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
                        text: 'Select the kind of trip you want',
                        size: 20,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: mainFeatures
                                .map(
                                  (e) => GestureDetector(
                                    onTap: () {
                                      if (widget.destination.length > 0 && widget.origin.length > 0) {
                                        Navigator.pop(context);
                                        changeScreen(
                                            context,
                                            TravelSearch(
                                              travelResults: travelService.getTravelSearch('2020-12-13', e.id.toString(), widget.originId, widget.destinationId,
                                                  passengerCount.toString(), e.id, selectedFeatures),
                                              origin: widget.origin,
                                              destination: widget.destination,
                                              destinationImages: widget.destinationImages,
                                              tripDate: tripDate,
                                              selectedFeatures: featuresId,
                                              passengerCount: passengerCount,
                                            ));
                                      } else {
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(msg: 'You need to select the origin & destination');
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Container(
                                        color: grey[100],
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 70,
                                                width: 70,
                                                decoration: BoxDecoration(color: grey[300], borderRadius: BorderRadius.all(Radius.circular(10))),
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  CustomText(
                                                    text: '${e.name}Trip',
                                                    size: 27,
                                                    color: grey[600],
                                                  ),
                                                  SizedBox(height: 10),
                                                  CustomText(
                                                    text: 'An adult male must accompany you',
                                                    size: 19,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList()),
                      )
                    ],
                  )),
            ),
          );
        });
  }

  getMainFeatures() async {
    mainFeatures = await userServices.mainFeatures();
    // print(mainFeatures[0].name);
  }

  getCarFeatures() async {
    setState(() {
      loadCarFeatures = true;
    });
    carFeatures = await travelService.carFeatures();
    setState(() {
      loadCarFeatures = false;
    });
  }
}
