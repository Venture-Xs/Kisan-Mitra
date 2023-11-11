import 'dart:async';
import 'package:flutter/material.dart';

final List<String> bloodGroups = <String>[
  'A+',
  'A-',
  'B+',
  'B-',
  'AB+',
  'AB-',
  'O+',
  'O-',
];

String blood = bloodGroups.first;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late StreamController<dynamic> estream;
  TextEditingController medicationsController = TextEditingController();
  TextEditingController hereditaryController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  // fetchProfile() async {
  //   var result = await fetchAndStoreProfileFromNet();
  //   estream.add(result);
  //   nameController.text = result.name;
  //   ageController.text = result.age.toString();
  //   phoneNumberController.text = result.phone.toString();
  //   medicationsController.text = result.medications;
  //   hereditaryController.text = result.herditary;
  // }

  void initState() {
    super.initState();
    estream = StreamController<dynamic>();
    // fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.0, 0.0), // 50% 50% at 50% 50%
              colors: [
                Color.fromRGBO(
                    125, 223, 100, 0.25), // rgba(125, 223, 100, 0.25)
                Color.fromRGBO(125, 223, 100, 0.5), // rgba(125, 223, 100, 0.5)
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Color.fromARGB(255, 8, 45, 15),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Edit Patient Details",
                      style: TextStyle(
                          color: Color(0xff082D0F),
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.64,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: StreamBuilder<dynamic>(
                        stream: estream.stream,
                        builder: (ctx, snapshot) {
                          if (!snapshot.hasData) {
                            {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Column(children: [
                                      CircularProgressIndicator(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Loading Data",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ])),
                                  ],
                                ),
                              );
                            }
                          } else {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name of Patient",
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 73, 159, 105),
                                          width: 1,
                                        ),
                                      ),
                                      hintText:
                                          "Please Enter The Name of Patient",
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 8, 45, 15),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Age of Patient",
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: ageController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 73, 159, 105),
                                          width: 1,
                                        ),
                                      ),
                                      hintText:
                                          "Please Enter The Age of Patient",
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 8, 45, 15),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Blood Group of Patient",
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            Color.fromARGB(255, 73, 159, 105),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          StatefulBuilder(
                                            builder: (ctx, setState) =>
                                                DropdownButton(
                                              underline: SizedBox(),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              hint: Text(
                                                  'Select a blood group'), // Default value shown
                                              value:
                                                  blood, // Initially selected value
                                              onChanged: (String? val) {
                                                setState(() {
                                                  blood = val!;
                                                });
                                              }, // Callback function to update selected value
                                              items: bloodGroups.map((bg) {
                                                return DropdownMenuItem(
                                                  child: new Text(bg),
                                                  value: bg,
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Phone Number of Patient",
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: phoneNumberController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 73, 159, 105),
                                          width: 1,
                                        ),
                                      ),
                                      hintText:
                                          "Please Enter The Phone Number of Patient",
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 8, 45, 15),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Past Medications of Patient",
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: medicationsController,
                                    minLines: 5,
                                    maxLines: 7,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 73, 159, 105),
                                          width: 1,
                                        ),
                                      ),
                                      hintText:
                                          "Please Enter The Past Medications of Patient (If Any)",
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 8, 45, 15),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Hereditary Diseases of Patient",
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: hereditaryController,
                                    minLines: 5,
                                    maxLines: 7,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 73, 159, 105),
                                          width: 1,
                                        ),
                                      ),
                                      hintText:
                                          "Please Enter The Hereditary Diseases of Patient (If Any)",
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 8, 45, 15),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ]);
                          }
                        }),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  InkWell(
                    child: Container(
                      width: 110,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 8, 45, 15)),
                      child: Center(
                        child: Text(
                          "Update",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                    onTap: () async {
                      final user = {
                        "name": nameController.text,
                        "age": ageController.text,
                        "blood_group": blood,
                        "phone": phoneNumberController.text,
                        "medications": medicationsController.text,
                        "herditary": hereditaryController.text,
                      };
                      print(user);
                      // var response = await updateProfile(user);
                      // if (response) {
                      //   Navigator.pop(context);
                      // }
                    },
                  ),
                ]),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
