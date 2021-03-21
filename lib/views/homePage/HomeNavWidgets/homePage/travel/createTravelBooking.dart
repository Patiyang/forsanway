import 'package:flutter/material.dart';
import 'package:forsanway/widgets/customButton.dart';
import 'package:forsanway/widgets/customText.dart';
import 'package:forsanway/widgets/styling.dart';
import 'package:forsanway/widgets/textField.dart';

class TravelBooking extends StatefulWidget {
  final int passengerCount;

  const TravelBooking({Key key, this.passengerCount}) : super(key: key);
  @override
  _TravelBookingState createState() => _TravelBookingState();
}

class _TravelBookingState extends State<TravelBooking> {
  List<TextEditingController> nameControllerList = [];
  List<TextEditingController> identityControllerList = [];
  List<TextEditingController> mobileControllerList = [];
  List<TextEditingController> emailControllerList = [];

  List<String> identities = [];
  List<String> identityType = [];
  List<String> titleType = [];
  List<String> titles = [];

  List<String> passengers = [];
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey[100],
        iconTheme: IconThemeData(color: black),
        title: CustomText(text: 'Passenger Information'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: key,
              child: ListView.separated(shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                itemCount: widget.passengerCount,
                itemBuilder: (BuildContext context, int index) {
                  // nameControllerList.clear();
                  // identityControllerList.clear();
                  // mobileControllerList.clear();
                  // emailControllerList.clear();

                  passengers.add('Passenger ${index + 1}');
                  identities.clear();
                  titles.clear();

                  nameControllerList.add(TextEditingController());
                  identityControllerList.add(TextEditingController());
                  mobileControllerList.add(TextEditingController());

                  emailControllerList.add(TextEditingController());
                  print('email length is ' + emailControllerList.length.toString());
                  // print('the name is ' + widget.passengerCount.toString());
                  titles.add('Mr');
                  titles.add('Mrs');
                  titleType.add('');

                  identities.add('Passport');
                  identities.add('NID');
                  identityType.add('');
                  return Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 40),
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(19), topLeft: Radius.circular(19))),
                        alignment: Alignment.centerLeft,
                        // width: MediaQuery.of(context).size.width - 100,
                        // height: 50,
                        child: CustomText(text: passengers[index].toUpperCase(), color: white,size: 15,textAlign: TextAlign.end,),
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: grey[300]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: DropdownButtonHideUnderline(
                                child: FittedBox(
                                  // fit: BoxFit.scaleDown,
                                  child: DropdownButton(
                                      icon: Icon(Icons.arrow_drop_down, color: black),
                                      style: TextStyle(color: white),
                                      hint: CustomText(
                                        text: 'Pick Title',
                                      ),
                                      value: titleType[index].isNotEmpty ? titleType[index] : null,
                                      onChanged: (val) {
                                        setState(() {
                                          titleType[index] = val;
                                        });

                                        print(titleType[index]);
                                      },
                                      items: titles
                                          .map(
                                            (e) => DropdownMenuItem(
                                              child: CustomText(text: e, size: 16),
                                              value: e,
                                            ),
                                          )
                                          .toList()),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: LoginTextField(
                              radius: 25,
                              controller: nameControllerList[index],
                              hint: 'Name',
                              validator: (v) {
                                if (v.isEmpty) {
                                  return 'The name cannot be empty';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: grey[300]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: DropdownButtonHideUnderline(
                                child: FittedBox(
                                  // fit: BoxFit.scaleDown,
                                  child: DropdownButton(
                                      icon: Icon(Icons.arrow_drop_down, color: black),
                                      style: TextStyle(color: white),
                                      hint: CustomText(
                                        text: 'Identity Type',
                                      ),
                                      value: identityType[index].isNotEmpty ? identityType[index] : null,
                                      onChanged: (val) {
                                        setState(() {
                                          identityType[index] = val;
                                        });

                                        print(identityType[index]);
                                      },
                                      items: identities
                                          .map(
                                            (e) => DropdownMenuItem(
                                              child: CustomText(text: e, size: 16),
                                              value: e,
                                            ),
                                          )
                                          .toList()),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: LoginTextField(
                              textInputType: TextInputType.numberWithOptions(),
                              radius: 25,
                              controller: identityControllerList[index],
                              hint: 'ID number',
                              validator: (v) {
                                if (v.isEmpty) {
                                  return 'The identity field cannot be empty';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: LoginTextField(
                                textInputType: TextInputType.numberWithOptions(),
                                radius: 25,
                                controller: mobileControllerList[index],
                                hint: 'Mobile Number',
                                validator: (v) {
                                  if (v.isEmpty) {
                                    return 'The phone number cannot be empty';
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: LoginTextField(
                                radius: 25,
                                controller: emailControllerList[index],
                                hint: 'Email Address',
                                validator: (v) {
                                  if (v.isEmpty) {
                                    return 'The email cannot be empty';
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            ),
          ),
          CustomFlatButton(
            radius: 30,
            callback: () => createBooking(),
            text: 'BOOK NOW',
          )
        ],
      ),
    );
  }

  createBooking() {
    if (key.currentState.validate()) {
      print('validated');
      for (int i = 0; i < widget.passengerCount; i++) {
        print(i);
      }
    } else {
      for (int i = 0; i < widget.passengerCount; i++) {
        print(i);
      }
      print('Not validated');
    }
  }
}
