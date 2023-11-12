import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:kisan_mitra_app/home_page.dart';
import 'package:kisan_mitra_app/pallete.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'KisanMitra',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Pallete.whiteColor,
      ),
      home: const HomePage(),
    );
  }
}

// class BottomNavigator extends StatefulWidget {
//   const BottomNavigator({super.key});

//   @override
//   State<BottomNavigator> createState() => _BottomNavigatorState();
// }

// class _BottomNavigatorState extends State<BottomNavigator> {
//   int _currentIndex = 0;

//   final PageController _pageController = PageController();

//   final List<String> _titles = [
//     'Dashboard',
//     'Agri Consultant',
//     'Disease Detection',
//     'Loan',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Theme.of(context).colorScheme.surface,
//           title: Text(
//             _titles[_currentIndex],
//           )),
//       body: PageView(
//         controller: _pageController,

//         //list of main widgets
//         children: const <Widget>[
//           DashBoard(),
//           Consultant(),
//           DetectDisease(),
//           LoanFinder()
//         ],
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.dashboard,
//                 color: Pallete.blackColor,
//               ),
//               label: 'Home'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.camera, color: Pallete.blackColor),
//               label: 'Chat'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.chat, color: Pallete.blackColor),
//               label: 'Disease'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.money, color: Pallete.blackColor),
//               label: 'Loan'),
//         ],
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//           _pageController.animateToPage(index,
//               duration: const Duration(milliseconds: 200),
//               curve: Curves.easeIn);
//         },
//         currentIndex: _currentIndex,
//       ),
//     );
//   }
// }
