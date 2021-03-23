import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:forsanway/models/featuresModel.dart';
import 'package:forsanway/models/searchModel.dart';
import 'package:forsanway/services/apiUrls.dart';
import 'package:forsanway/services/carFeaturesService.dart';
import 'package:forsanway/views/homePage/HomeNavWidgets/homePage/shipment/selectedShipmentCar.dart';
import 'package:forsanway/widgets/changeScreen.dart';
import 'package:forsanway/widgets/customText.dart';
import 'package:forsanway/widgets/loading.dart';
import 'package:forsanway/widgets/styling.dart';
import 'package:transparent_image/transparent_image.dart';

class ShipmentSearch extends StatefulWidget {
  final Future shipmentResult;
  final String origin;
  final String destination;
  final List destinationImages;
  final String shipmentDate;
  final List selectedFeatures;
  final int quantity;

  final int type;
  const ShipmentSearch(
      {Key key, this.shipmentResult, this.origin, this.destination, this.destinationImages, this.shipmentDate, this.selectedFeatures, this.quantity, this.type})
      : super(key: key);

  @override
  _ShipmentSearchState createState() => _ShipmentSearchState();
}

class _ShipmentSearchState extends State<ShipmentSearch> {
  int curentIndex = 0;
  List<CarFeaturesModel> carFeatures = [];
  CarFeaturesService _carFeaturesService = new CarFeaturesService();
  List<int> individualCarFeatures = [];
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
          text: '${widget.origin.toUpperCase()} to ${widget.destination.toUpperCase()}',
          // text: widget.destinationImages.length.toString(),
          color: black,
          size: 19,
        ),
        elevation: .4,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  height: 200,
                  color: grey.withOpacity(.2),
                ),
                Container(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CarouselSlider(
                          items: [
                            for (var item in widget.destinationImages)
                              Stack(
                                children: [
                                  LoadingImages(),
                                  FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: '${ApiUrls.imageUrl}' + item,
                                      fit: BoxFit.fill,
                                      height: 200,
                                      width: MediaQuery.of(context).size.width),
                                ],
                              )
                          ],
                          options: CarouselOptions(
                            height: 200,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.999,
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
                                curentIndex = index;
                              });
                            },
                            scrollDirection: Axis.horizontal,
                          )),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.destinationImages.map((e) {
                            int index = widget.destinationImages.indexOf(e);
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: 8.0,
                                height: 8.0,
                                // margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: curentIndex == index ? grey : black,
                                ),
                              ),
                            );
                          }).toList())
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                        decoration: BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(12))),
                        child:
                            Center(child: CustomText(text: widget.destination.toUpperCase(), size: 14, maxLines: 1, fontWeight: FontWeight.w600, color: grey)),
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                        decoration: BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(12))),
                        child: Center(
                            child: CustomText(text: widget.shipmentDate.toUpperCase() ?? '', size: 14, maxLines: 1, fontWeight: FontWeight.w600, color: grey)),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: widget.shipmentResult,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<ShipmentSearchResult> searchResult = snapshot.data;
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      itemCount: searchResult.length,
                      itemBuilder: (BuildContext context, int index) {
                        individualCarFeatures.clear();
                        var singleCar = searchResult[index];

                        for (int i = 0; i < singleCar.carFeatures.length; i++) {
                          individualCarFeatures.add(singleCar.carFeatures[i]['id']);
                          // print(individualCarFeatures);
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 9),
                          child: Container(
                            decoration: BoxDecoration(color: grey[200], borderRadius: BorderRadius.all(Radius.circular(10))),
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Hero(
                                  tag: searchResult.indexOf(singleCar),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(color: grey[300], borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        child: Stack(
                                          children: [
                                            LoadingImages(),
                                            FadeInImage.memoryNetwork(
                                                placeholder: kTransparentImage,
                                                image: '${ApiUrls.imageUrl}' + singleCar.imageUrl,
                                                fit: BoxFit.cover,
                                                height: 200,
                                                width: MediaQuery.of(context).size.width),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(text: singleCar.carName, color: grey, fontWeight: FontWeight.w600, size: 19),
                                            RatingBar.builder(
                                              itemSize: 17,
                                              initialRating: 3,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
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
                                        CustomText(text: singleCar.pickUpLocation, color: grey, fontWeight: FontWeight.w600, size: 19),
                                        Expanded(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Row(
                                              children: carFeatures
                                                  .map(
                                                    (e) => Padding(
                                                      padding: const EdgeInsets.only(right: 8.0),
                                                      child: Container(
                                                        height: 50,
                                                        width: 50,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(color: grey[300]),
                                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                                            color: white),
                                                        child: Container(
                                                          height: 47,
                                                          width: 47,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                                              color: individualCarFeatures.contains(e.id) ? green[300] : grey[200]),
                                                          child: Center(
                                                              child: ClipRRect(
                                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                                            child: Stack(
                                                              children: [
                                                                LoadingImages(),
                                                                FadeInImage.memoryNetwork(
                                                                    placeholder: kTransparentImage,
                                                                    image: '${ApiUrls.imageUrl}' + e.images['url'],
                                                                    fit: BoxFit.fill,
                                                                    height: 200,
                                                                    width: MediaQuery.of(context).size.width),
                                                              ],
                                                            ),
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                    color: grey,
                                    onPressed: () => changeScreen(
                                        context,
                                        SelectedShipmentCar(
                                          heroTag: searchResult.indexOf(singleCar),
                                          shipmentSearchResult: searchResult[index],
                                          selectedFeatures: individualCarFeatures,
                                          quantity: widget.quantity,
                                        )
                                        // SelectedCar(selectedSearchResult: searchResult[index], selectedFeatures: widget.selectedFeatures, passengerCount: widget.passengerCount,),
                                        ),
                                    icon: Icon(
                                      Icons.arrow_forward_ios_sharp,
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Loading(text: 'Fetching available vehicles...');
                  }
                  if (snapshot.connectionState == ConnectionState.none) {
                    return Center(child: CustomText(text: 'Please check your connection', fontWeight: FontWeight.w600, color: grey, size: 19));
                  }
                  if (!snapshot.hasData) {
                    return Center(child: CustomText(text: 'No data is available', fontWeight: FontWeight.w600, color: grey, size: 19));
                  }
                  if (!snapshot.hasError) {
                    return Center(child: CustomText(text: snapshot.error, fontWeight: FontWeight.w600, color: grey, size: 19));
                  }
                  return Container(
                      // child: fl
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  getCarFeatures() async {
    carFeatures = await _carFeaturesService.carFeatures();
    setState(() {});
  }
}
