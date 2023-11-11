import 'package:flutter/material.dart';
import 'package:kisan_mitra_app/Dashboard/Components/crop_detail_page.dart';

import 'package:kisan_mitra_app/Dashboard/Components/plants.dart';
import 'package:kisan_mitra_app/pallete.dart';
import 'package:page_transition/page_transition.dart';

// A widget to Display Crop Dta
class CropTile extends StatelessWidget {
  const CropTile({
    Key? key,
    required this.index,
    required this.plantList,
  }) : super(key: key);

  final int index;
  final List<Plant> plantList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      //Display Crop Detail Page
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: CropDetailPage(
                  plant: plantList[index],
                ),
                type: PageTransitionType.bottomToTop));
      },

      //Design
      child: Container(
        decoration: BoxDecoration(
          color: Pallete.primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(15),
        ),
        height: 80.0,
        padding: const EdgeInsets.only(left: 10, top: 10),
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Crop Image over Green Circle
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Pallete.primaryColor.withOpacity(.8),
                    shape: BoxShape.circle,
                  ),
                ),

                //crop image
                Positioned(
                  bottom: 5,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 80.0,
                    child: Image.asset(plantList[index].imageURL),
                  ),
                ),

                // Crop Category and Name
                Positioned(
                  bottom: 5,
                  left: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Crop Name
                      Text(
                        plantList[index].plantName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Pallete.blackColor,
                        ),
                      ),

                      //Category
                      Text(plantList[index].category),
                    ],
                  ),
                ),
              ],
            ),
            // Price Detail
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                r'Rs' + plantList[index].price.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Pallete.primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
