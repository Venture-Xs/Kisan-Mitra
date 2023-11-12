import 'package:flutter/material.dart';

import 'package:kisan_mitra_app/LoanApplication/Components/bank_list.dart';
import 'package:kisan_mitra_app/LoanApplication/banking_option.dart';
import 'package:kisan_mitra_app/pallete.dart';
import 'package:page_transition/page_transition.dart';

// A widget to Display Crop Dta
class BankTile extends StatelessWidget {
  const BankTile({
    Key? key,
    required this.index,
    required this.BankList,
  }) : super(key: key);

  final int index;
  final List<Bank> BankList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: Options(
                  name: BankList[index].name,
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
            //Bank Image over Green Circle
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Pallete.whiteColor.withOpacity(.8),
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    child: Image.asset(BankList[index].imageURL),
                  ),
                ),

                // Rating
                Positioned(
                  bottom: 5,
                  left: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Bank Name
                      Text(
                        BankList[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Pallete.blackColor,
                        ),
                      ),

                      //RATING
                      Text(' Rating' + BankList[index].rating.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
