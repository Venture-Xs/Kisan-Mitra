import 'package:flutter/material.dart';

//A package for creating badges. Badges can be used for an additional marker for any widget,
import 'package:badges/badges.dart' as badges;

//Flutter package for using Iconly Icons.
import 'package:iconly/iconly.dart';

import 'package:kisan_mitra_app/Dashboard/dashboard.dart';
import 'package:kisan_mitra_app/DiseasePrediction/disease_prediction.dart';
import 'package:kisan_mitra_app/FarmerConsultant/consultant.dart';
import 'package:kisan_mitra_app/LoanApplication/loan_finder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pages = [
    const DashBoard(),
    const Consultant(),
    const DetectDisease(),
    const LoanFinder()
  ];
  int currentPageIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(),
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi Anish 👋🏾",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text("Enjoy our services",
                style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: badges.Badge(
                badgeContent: const Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                position: badges.BadgePosition.topEnd(top: -15, end: -12),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.green,
                ),
                child: const Icon(Icons.notifications_outlined),
              ),
            ),
          ),
        ],
      ),
      body: pages[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPageIndex,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Home",
            activeIcon: Icon(Icons.dashboard),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Consultant",
            activeIcon: Icon(Icons.chat),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.query_stats),
            label: "Disease",
            activeIcon: Icon(Icons.query_stats),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance,
            ),
            label: "Loan",
            activeIcon: Icon(Icons.account_balance),
          ),
        ],
      ),
    );
  }
}
