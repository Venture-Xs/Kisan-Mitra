import 'package:flutter/material.dart';

class DetectDisease extends StatefulWidget {
  const DetectDisease({super.key});

  @override
  State<DetectDisease> createState() => _DetectDiseaseState();
}

class _DetectDiseaseState extends State<DetectDisease> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Align(
          alignment: Alignment.center, child: Text("Disease Detection")),
    );
  }
}
