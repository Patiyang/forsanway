import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forsanway/services/shipmentServices.dart';
import 'package:forsanway/views/homePage/HomeNavWidgets/homePage/shipment/shipmentItem.dart';
import 'package:forsanway/views/homePage/HomeNavWidgets/homePage/shipment/shipmentSearch.dart';
import 'package:forsanway/views/homePage/HomeNavWidgets/homePage/travel/travelSearch.dart';
import 'package:forsanway/widgets/changeScreen.dart';
import 'package:forsanway/widgets/customButton.dart';
import 'package:forsanway/widgets/customText.dart';
import 'package:forsanway/widgets/styling.dart';
import 'package:intl/intl.dart';

class Shipment extends StatefulWidget {
  final String origin;
  final String destination;
  final List destinationImages;
  final int originId;
  final int destinationId;

  const Shipment({Key key, this.origin, this.destination, this.destinationImages, this.originId, this.destinationId}) : super(key: key);
  @override
  _ShipmentState createState() => _ShipmentState();
}

class _ShipmentState extends State<Shipment> {
  String weekDay = '';
  String month = '';
  String dateOfMonth = '';
  int shipmentCount = 1;
  String selectedSize = '';
  DateTime dateTime = DateTime.now();
  ShipmentService shipmentService = new ShipmentService();
  String shipmentDate = DateTime.now().toString().substring(0, 10);
  int type = 0;
  @override
  void initState() {
    super.initState();
    getCurrentDate();
  }

  @override
  Widget build(BuildContext context) {
    List<ShipmentItem> shipmentItems = [
      ShipmentItem('XS', false),
      ShipmentItem('Small', false),
      ShipmentItem('Medium', false),
      ShipmentItem('Large', false),
      ShipmentItem('XL', false),
      ShipmentItem('XXL', false),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                              child: GestureDetector(
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
                        shipmentDate = val.toString().substring(0, 10);
                        print(val);
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
                                        CustomText(text: month, size: 30, fontWeight: FontWeight.bold, color: grey),
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
                        CustomText(
                            text: 'NUMBER OF BAGS',
                            textAlign: TextAlign.center,
                            size: 19,
                            fontWeight: FontWeight.w800,
                            color: grey,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        SizedBox(height: 14),
                        Container(
                          height: 70,
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomText(text: shipmentCount.toString(), color: blue, size: 90),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () => increaseShipment(),
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
                                    onTap: () => decreaseShipment(),
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
          SizedBox(height: 10),
          CustomText(text: 'Please select your desired size below', fontWeight: FontWeight.w700, size: 20, maxLines: 1),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: grey[300]),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  icon: Icon(Icons.arrow_drop_down, color: black),
                  hint: CustomText(text: 'Product type', color: black),
                  value: selectedSize.isNotEmpty ? selectedSize : null,
                  onChanged: (val) {
                    setState(() {
                      selectedSize = val;
                    });
                  },
                  items: shipmentItems
                      .map((e) => DropdownMenuItem(
                            value: e.size,
                            child: CustomText(text: e.size),
                            onTap: () {
                              setState(() {
                                type = shipmentItems.indexOf(e);
                              });

                              print(type);
                            },
                          ))
                      .toList()),
            ),
          ),
          CustomFlatButton(
              icon: Icons.search,
              callback: () {
                if (widget.destination.length > 0 && widget.origin.length > 0) {
                  shipmentService.getShipmentSearch('2020-12-06', type.toString(), widget.originId, widget.destinationId, shipmentCount.toString());
                  changeScreen(
                      context,
                      ShipmentSearch(
                        shipmentResult: shipmentService.getShipmentSearch('2020-12-06', type.toString(), widget.originId, widget.destinationId, shipmentCount.toString()),
                        origin: widget.origin,
                        destination: widget.destination,
                        destinationImages: widget.destinationImages,
                        shipmentDate: shipmentDate,
                        type: type,
                        quantity: shipmentCount,
                      ));
                } else {
                  Fluttertoast.showToast(msg: 'You need to select the origin & destination first');
                }
              },
              color: green[700],
              radius: 30,
              text: 'Search',
              fontSize: 17,
              iconSize: 27),
        ],
      ),
    );
  }

  increaseShipment() {
    setState(() {
      shipmentCount++;
    });
  }

  decreaseShipment() {
    if (shipmentCount > 1) {
      setState(() {
        shipmentCount--;
      });
    }
  }

  getCurrentDate() {
    setState(() {
      weekDay = DateFormat.EEEE().format(DateTime.now());
      month = DateFormat.MMMM().format(DateTime.now());
      dateOfMonth = DateTime.now().day.toString();
    });
  }
}
