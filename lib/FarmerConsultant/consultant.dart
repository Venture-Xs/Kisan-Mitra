import 'package:flutter/material.dart';

class Consultant extends StatefulWidget {
  const Consultant({super.key});

  @override
  State<Consultant> createState() => _ConsultantState();
}

class _ConsultantState extends State<Consultant> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Align(
          alignment: Alignment.center,
          child: Text("Chat with Agri Consultant")),
    );
  }
}
