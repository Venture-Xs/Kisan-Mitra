import 'package:flutter/material.dart';

import 'package:kisan_mitra_app/ProfilePage/Components/menu_item.dart';
import 'package:kisan_mitra_app/ProfilePage/editprofilepage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(builder: (context, snapshot) {
      // if (snapshot.hasData == false) {
      //   return SizedBox(
      //     height: MediaQuery.of(context).size.height,
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Center(
      //             child: Column(children: [
      //           CircularProgressIndicator(),
      //           SizedBox(
      //             height: 10,
      //           ),
      //           Text(
      //             "Loading Profile",
      //             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      //           ),
      //         ])),
      //       ],
      //     ),
      //   );
      // }
      return Column(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 25),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(125, 223, 100, 0.2),
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 73, 159, 105),
                        width: 2,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color.fromARGB(255, 73, 159, 105),
                                  width: 1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 8, 45, 15)),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Age",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 8, 45, 15)),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Phone Number",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 8, 45, 15)),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen()));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff008A00)),
                        )
                      ],
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MenuItem(
              title: "Blood Group",
              description: snapshot.data.blood_group.toString()),
          SizedBox(
            height: 20,
          ),
          MenuItem(
              title: "Medications",
              description: snapshot.data.medications.toString()),
          SizedBox(
            height: 20,
          ),
          MenuItem(
            title: "Hereditary Diseases",
            description: snapshot.data.herditary.toString(),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              //To do
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color.fromARGB(255, 226, 72, 51),
              ),
              width: MediaQuery.of(context).size.width * 0.3,
              height: 50,
              child: Center(
                child: Text(
                  "Log Out",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 251, 255, 255),
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
