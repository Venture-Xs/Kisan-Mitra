import 'package:flutter/material.dart';
import 'package:kisan_mitra_app/LoanApplication/Components/bank_list.dart';
import 'package:kisan_mitra_app/LoanApplication/Components/bank_tile.dart';
import 'package:page_transition/page_transition.dart';

class LoanFinder extends StatefulWidget {
  const LoanFinder({super.key});

  @override
  State<LoanFinder> createState() => _LoanFinderState();
}

//List of crops
List<Bank> _bankList = Bank.indianBanks;

class _LoanFinderState extends State<LoanFinder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              "Chat With Bank",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cera Pro'),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        SingleChildScrollView(
          child: Container(
            height: 500,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
                itemCount: _bankList.length,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: const Placeholder(),
                                type: PageTransitionType.bottomToTop));
                      },
                      child: BankTile(index: index, BankList: _bankList));
                }),
          ),
        ),
      ],
    );
  }
}
