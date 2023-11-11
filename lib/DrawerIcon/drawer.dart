import 'package:flutter/material.dart';
import 'package:kisan_mitra_app/ProfilePage/editprofilepage.dart';
import 'package:kisan_mitra_app/ProfilePage/profillepage.dart';
import 'package:page_transition/page_transition.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              accountName: Text(
                "Anish Pillai",
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Text("anishp1234@.com"),
              currentAccountPictureSize: Size.square(40),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 165, 255, 137),
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 30.0, color: Colors.blue),
                ), //Text
              ), //circleAvatar
            ), //UserAccountDrawerHeader
          ), //DrawerHeader

          // List Tile
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' My Profile '),
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: ProfileScreen(),
                      type: PageTransitionType.bottomToTop));
            },
          ),

          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text(' Edit Profile '),
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: EditProfileScreen(),
                      type: PageTransitionType.bottomToTop));
            },
          ),

          ListTile(
            leading: const Icon(Icons.book),
            title: const Text(' My CIBIL Score '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.workspace_premium),
            title: const Text(' Government Schemes '),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
