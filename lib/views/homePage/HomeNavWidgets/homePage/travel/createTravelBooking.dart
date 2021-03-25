import 'package:flutter/material.dart';
import 'package:forsanway/services/travelService.dart';
import 'package:forsanway/widgets/customButton.dart';
import 'package:forsanway/widgets/customText.dart';
import 'package:forsanway/widgets/loading.dart';
import 'package:forsanway/widgets/styling.dart';
import 'package:forsanway/widgets/textField.dart';

class TravelBooking extends StatefulWidget {
  final int passengerCount;
  final int tripId;
  final String mainEmail;

  const TravelBooking({Key key, this.passengerCount, this.tripId, this.mainEmail}) : super(key: key);
  @override
  _TravelBookingState createState() => _TravelBookingState();
}

class _TravelBookingState extends State<TravelBooking> {
  TravelService travelService = new TravelService();

  List<TextEditingController> nameControllerList = [];
  List<TextEditingController> identityControllerList = [];
  List<TextEditingController> mobileControllerList = [];
  List<TextEditingController> emailControllerList = [];

  List<String> identities = [];
  List<String> identityType = [];
  List<String> titleType = [];
  List<String> titles = [];

  List<String> passengerTitles = [];
  List<String> passengerIdentities = [];

  bool termsAndConditions = false;
  bool loading = false;

  List<String> passengers = [];

  //DATA TO BE PASSED TO BACKEND USING API
  List<String> dBnames = [];
  List<int> dBTitles = [];
  List<int> dBIdentities = [];
  List<String> idNumbers = [];
  List<String> mobileNumbers = [];
  List<String> passengerEmails = [];

  final key = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getColumnItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: grey[100],
        iconTheme: IconThemeData(color: black),
        title: CustomText(text: 'Passenger Information'),
      ),
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            primary: false,
            children: [
              Form(
                key: key,
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  itemCount: widget.passengerCount,
                  itemBuilder: (BuildContext context, int index) {
                    passengers.add('Passenger ${index + 1}');
                    identities.clear();
                    titles.clear();

                    titles.add('Mr');
                    titles.add('Mrs');
                    titleType.add('');

                    identities.add('Passport');
                    identities.add('NID');
                    identityType.add('');

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: EdgeInsets.only(left: 40),
                            padding: EdgeInsets.all(7),
                            decoration:
                                BoxDecoration(color: blue, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(19), topLeft: Radius.circular(19))),
                            alignment: Alignment.centerLeft,
                            // width: MediaQuery.of(context).size.width - 100,
                            // height: 50,
                            child: CustomText(
                              text: passengers[index].toUpperCase(),
                              color: white,
                              size: 15,
                              textAlign: TextAlign.end,
                            ),
                          ),
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
                                            passengerTitles[index] = titles.indexOf(titleType[index]).toString();
                                          });

                                          print('the passenger titles $passengerTitles');
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
                                            passengerIdentities[index] = identities.indexOf(identityType[index]).toString();
                                          });
                                          print('the passenger identities $passengerIdentities');
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
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(v))
                                      return 'Please make sure your email address format is valid';
                                    else
                                      return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                      value: termsAndConditions,
                      onChanged: (val) {
                        setState(() {
                          termsAndConditions = val;
                        });
                        print(termsAndConditions);
                      }),
                  CustomText(text: 'Terms and Conditions >>>>>', fontWeight: FontWeight.w700)
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: CustomFlatButton(
                  // width: 200,
                  radius: 30,
                  callback: () => createBooking(),
                  text: 'BOOK NOW',
                ),
              )
            ],
          ),
          Visibility(visible: false, child: Loading(text: 'Uploading your data'))
        ],
      ),
    );
  }

  createBooking() async {
    if (termsAndConditions == true) {
      if (key.currentState.validate()) {
        setState(() {
          loading = true;
        });
        dBnames.clear();
        idNumbers.clear();
        mobileNumbers.clear();
        passengerEmails.clear();
        for (int i = 0; i < widget.passengerCount; i++) {
          dBnames.add(nameControllerList[i].text);
          idNumbers.add(identityControllerList[i].text);
          mobileNumbers.add(mobileControllerList[i].text);
          passengerEmails.add(emailControllerList[i].text);
        }
        print(dBnames);
        print(idNumbers);
        print(mobileNumbers);
        print(passengerEmails);
        await travelService.createTravelBooking(
          widget.tripId,
          widget.passengerCount,
          dBnames,
          passengerTitles,
          passengerIdentities,
          identities,
          mobileNumbers,
          passengerEmails,
        )
            // .
            //     onError((error, stackTrace) {
            //   print(error);
            //   setState(() {
            //     loading = false;
            //   });
            //   return null;
            // })

            ;
        setState(() {
          loading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomText(
        text: 'You need to accept the terms and conditions first',
        textAlign: TextAlign.center,
        color: red,
        fontWeight: FontWeight.w700,
      )));
    }
  }

  getColumnItems() {
    print(widget.tripId);
    for (int i = 0; i < widget.passengerCount; i++) {
      passengerTitles.add("0");
      passengerIdentities.add('0');
      nameControllerList.add(TextEditingController());
      identityControllerList.add(TextEditingController());
      mobileControllerList.add(TextEditingController());
      emailControllerList.add(TextEditingController());
    }

    print('the passenger titles $passengerTitles');
    print('the passenger identities $passengerIdentities');
  }
}
