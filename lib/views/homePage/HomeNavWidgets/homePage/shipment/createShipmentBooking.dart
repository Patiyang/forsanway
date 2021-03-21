import 'package:flutter/material.dart';
import 'package:forsanway/widgets/customText.dart';
import 'package:forsanway/widgets/styling.dart';

class ShipmentBooking extends StatefulWidget {
  final int quantity;

  const ShipmentBooking({Key key, this.quantity}) : super(key: key);
  @override
  ShipmentBookingState createState() => ShipmentBookingState();
}

class ShipmentBookingState extends State<ShipmentBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey[100],
        iconTheme: IconThemeData(color: black),
        title: CustomText(text: 'Shipment Information'),
      ),
    );
  }
}
