import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:forsanway/models/featuresModel.dart';
import 'package:forsanway/models/searchModel.dart';
import 'package:forsanway/services/apiUrls.dart';
import 'package:forsanway/services/travelService.dart';
import 'package:forsanway/views/homePage/HomeNavWidgets/homePage/travel/createTravelBooking.dart';
import 'package:forsanway/widgets/changeScreen.dart';
import 'package:forsanway/widgets/customButton.dart';
import 'package:forsanway/widgets/customText.dart';
import 'package:forsanway/widgets/loading.dart';
import 'package:forsanway/widgets/styling.dart';
import 'package:transparent_image/transparent_image.dart';

class SelectedCar extends StatefulWidget {
  final TravelSearchResult selectedSearchResult;
  final List selectedFeatures;
  final int passengerCount;
  final int tripId;
  final String mainEmail;

  const SelectedCar({Key key, this.selectedSearchResult, this.selectedFeatures, this.passengerCount, this.tripId, this.mainEmail}) : super(key: key);
  @override
  _SelectedCarState createState() => _SelectedCarState();
}

class _SelectedCarState extends State<SelectedCar> {
  int currentIndex = 0;
  List<CarFeaturesModel> carFeatures = [];
  TravelService travelService = new TravelService();
  bool obtainingCarFeatures = false;
  @override
  void initState() {
    super.initState();
    getCarFeatures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey[100],
        iconTheme: IconThemeData(color: black),
        title: CustomText(
          text: widget.selectedSearchResult.carName,
          color: grey,
          size: 19,
          fontWeight: FontWeight.w800,
        ),
        elevation: .4,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 200,
              color: grey[100],
              child: Column(
                children: [
                  Expanded(
                    child: CarouselSlider(
                        items: [
                          for (var item in widget.selectedSearchResult.imageList)
                            FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: '${ApiUrls.imageUrl}' + item['url'],
                                fit: BoxFit.cover,
                                height: 200,
                                width: MediaQuery.of(context).size.width),
                        ],
                        options: CarouselOptions(
                          height: 200,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.998,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          onPageChanged: (index, ctx) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          scrollDirection: Axis.horizontal,
                        )),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.selectedSearchResult.imageList.map((e) {
                        int index = widget.selectedSearchResult.imageList.indexOf(e);
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            // margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentIndex == index ? grey : black,
                            ),
                          ),
                        );
                      }).toList())
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: widget.selectedSearchResult.carName, size: 25, color: grey, fontWeight: FontWeight.w300),
                      RatingBar.builder(
                        itemSize: 25,
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomText(text: widget.selectedSearchResult.description, size: 15, color: grey[500], fontWeight: FontWeight.w300),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.location_on_sharp, color: black),
                      CustomText(text: widget.selectedSearchResult.pickUpLocation, size: 15, color: grey[500], fontWeight: FontWeight.w300),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: carFeatures
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: grey[300]), borderRadius: BorderRadius.all(Radius.circular(10)), color: white),
                                      child: Container(
                                        height: 47,
                                        width: 47,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            color: widget.selectedFeatures.contains(e.id) ? green[300] : grey[200]),
                                        child: Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            child: FadeInImage.memoryNetwork(
                                                placeholder: kTransparentImage,
                                                image: '${ApiUrls.imageUrl}' + e.images['url'],
                                                fit: BoxFit.fill,
                                                height: (MediaQuery.of(context).size.height * .3) / 2,
                                                width: MediaQuery.of(context).size.width),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          Visibility(
                              visible: obtainingCarFeatures == true,
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: CustomText(
                                    text: 'Fetching Services...',
                                  )))
                        ],
                      ),
                      // Spacer(),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: grey[300], borderRadius: BorderRadius.all(Radius.circular(120))),
                        child: CartItemRich(
                          boldFont: '120',
                          lightFont: 'SR',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: CustomFlatButton(
                      callback: () => changeScreen(
                          context,
                          TravelBooking(
                            mainEmail: widget.mainEmail,
                            tripId: widget.tripId,
                            passengerCount: widget.passengerCount,
                          )),
                      radius: 30,
                      color: green[600],
                      text: 'Book Now',
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getCarFeatures() async {
    setState(() {
      obtainingCarFeatures = true;
    });
    carFeatures = await travelService.carFeatures();
    setState(() {
      obtainingCarFeatures = false;
    });
  }
}
