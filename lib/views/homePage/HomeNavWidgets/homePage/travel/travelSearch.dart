import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:forsanway/models/featuresModel.dart';
import 'package:forsanway/models/searchModel.dart';
import 'package:forsanway/services/apiUrls.dart';
import 'package:forsanway/services/cityServices.dart';
import 'package:forsanway/services/travelService.dart';
import 'package:forsanway/views/homePage/HomeNavWidgets/homePage/travel/selectedCar.dart';
import 'package:forsanway/widgets/changeScreen.dart';
import 'package:forsanway/widgets/customText.dart';
import 'package:forsanway/widgets/loading.dart';
import 'package:forsanway/widgets/styling.dart';
import 'package:transparent_image/transparent_image.dart';

class TravelSearch extends StatefulWidget {
  final Future travelResults;
  final String origin;
  final String destination;
  final List destinationImages;
  final String tripDate;
  final List selectedFeatures;
  final int passengerCount;

  const TravelSearch(
      {Key key, this.travelResults, this.origin, this.destination, this.destinationImages, this.tripDate, this.selectedFeatures, this.passengerCount})
      : super(key: key);
  @override
  TravelSearchState createState() => TravelSearchState();
}

class TravelSearchState extends State<TravelSearch> {
  CityServices cityServices = new CityServices();
  int curentIndex = 0;
  List<CarFeaturesModel> carFeatures = [];
  TravelService travelService = new TravelService();
  @override
  void initState() {
    cityServices.getCityList();
    getCarFeatures();
    super.initState();
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
                  // color: grey.withOpacity(.2),
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
                              ),
                          ],
                          options: CarouselOptions(
                            height: 200,
                            disableCenter: true,
                            aspectRatio: 16 / 9,
                            viewportFraction: .999,
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
                            child: CustomText(text: widget.tripDate.toUpperCase() ?? '', size: 14, maxLines: 1, fontWeight: FontWeight.w600, color: grey)),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: widget.travelResults,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<TravelSearchResult> searchResult = snapshot.data;
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                      itemCount: searchResult.length,
                      itemBuilder: (BuildContext context, int index) {
                        var singleCar = searchResult[index];
                        return Container(
                          decoration: BoxDecoration(color: grey[200], borderRadius: BorderRadius.all(Radius.circular(10))),
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(color: grey[300], borderRadius: BorderRadius.all(Radius.circular(10))),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  child: Stack(
                                    children: [
                                      LoadingImages(),
                                      FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          image: '${ApiUrls.imageUrl}' + singleCar.imageUrl,
                                          fit: BoxFit.fill,
                                          height: (MediaQuery.of(context).size.height * .3) / 2,
                                          width: MediaQuery.of(context).size.width),
                                    ],
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
                                      CustomText(text: singleCar.pickUpLocation, color: grey, fontWeight: FontWeight.w600, size: 19),
                                      Expanded(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Row(
                                            children: carFeatures
                                                .map(
                                                  (e) => Padding(
                                                    padding: const EdgeInsets.only(right: 8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        print(e.images['url']);
                                                      },
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
                                                              color: widget.selectedFeatures.contains(e.id) ? green[300] : grey[200]),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                                            child: Stack(
                                                              children: [
                                                                LoadingImages(),
                                                                FadeInImage.memoryNetwork(
                                                                    placeholder: kTransparentImage,
                                                                    image: '${ApiUrls.imageUrl}' + e.images['url'],
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
                                        SelectedCar(
                                          selectedSearchResult: searchResult[index],
                                          selectedFeatures: widget.selectedFeatures,
                                          passengerCount: widget.passengerCount,
                                        ),
                                      ),
                                  icon: Icon(
                                    Icons.arrow_forward_ios_sharp,
                                  ))
                            ],
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
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  getCarFeatures() async {
    carFeatures = await travelService.carFeatures();
    setState(() {});
  }
}
