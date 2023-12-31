import 'package:flutter/material.dart';
import 'package:kisan_mitra_app/Dashboard/Components/plants.dart';
import 'package:kisan_mitra_app/Widgets/linechart.dart';
import 'package:kisan_mitra_app/pallete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CropDetailPage extends StatefulWidget {
  final Plant plant;
  const CropDetailPage({Key? key, required this.plant}) : super(key: key);

  @override
  State<CropDetailPage> createState() => _CropDetailPageState();
}

class _CropDetailPageState extends State<CropDetailPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference currentPrice =
      FirebaseFirestore.instance.collection('market-price');

  Future<void> getUserData() async {
    print("Getting data");
    QuerySnapshot querySnapshot = await currentPrice.get();
    String crop = 'Wheat';
    String state = 'Assam';

    final allData = querySnapshot.docs
        .where((doc) => doc.id.contains(crop))
        .map((doc) => doc.data())
        .toList();

    List<Map<String, dynamic>> allPrices = [];

    for (var data in allData) {
      Map<String, dynamic> filteredData = data as Map<String, dynamic>;

      List pricesList = filteredData.values.first
          .where((item) => item['state'] == state)
          .map((item) => {
                'modal_price': item['modal_price'],
                'min_price': item['min_price'],
                'max_price': item['max_price']
              })
          .toList();

      if (pricesList.isNotEmpty) {
        allPrices.add(pricesList[0]);
      }
    }

    print(allPrices);
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  //Toggle Favorite button
  bool toggleIsFavorated(bool isFavorited) {
    return !isFavorited;
  }

  //Toggle add remove from cart
  bool toggleIsSelected(bool isSelected) {
    return !isSelected;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              //Go back button
              Positioned(
                top: 30,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Pallete.primaryColor.withOpacity(.15),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Pallete.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                left: 20,
                right: 20,
                child: Container(
                  width: size.width * .8,
                  height: size.height * .8,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      //Crop Data Analysis Chart
                      Text(
                        "Crop Price vs Year Chart",
                        style: TextStyle(
                          color: Pallete.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),

                      Container(
                        width: 400,
                        height: 300,
                        child: LineChartSample2(),
                      ),

                      //Crop Prices
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PlantFeature(
                            title: 'Max Price',
                            plantFeature: 'Rs 1000',
                          ),
                          PlantFeature(
                            title: 'Min Price',
                            plantFeature: 'Rs 500',
                          ),
                          PlantFeature(
                            title: 'Modal Price',
                            plantFeature: 'Rs 750',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              //Crop Description
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
                  height: size.height * .5,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Pallete.primaryColor.withOpacity(.4),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.plant.plantName,
                                style: TextStyle(
                                  color: Pallete.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Sub Information',
                                style: TextStyle(
                                  color: Pallete.blackColor,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              //heading for change in price
                              Text('Change in Price',
                                  style: TextStyle(
                                    color: Pallete.blackColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  )),

                              //change
                              Row(
                                children: [
                                  Text(
                                    widget.plant.rating.toString() + "%",
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Pallete.primaryColor,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_upward,
                                    size: 30.0,
                                    color: Color.fromARGB(255, 24, 152, 28),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),

                      //description
                      Expanded(
                        child: Text(
                          widget.plant.decription,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 18,
                            color: Pallete.blackColor.withOpacity(.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlantFeature extends StatelessWidget {
  final String plantFeature;
  final String title;
  const PlantFeature({
    Key? key,
    required this.plantFeature,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Pallete.blackColor,
          ),
        ),
        Text(
          plantFeature,
          style: TextStyle(
            color: Pallete.primaryColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
