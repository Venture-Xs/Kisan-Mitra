import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kisan_mitra_app/FarmerConsultant/chat_bot.dart';

class Options extends StatefulWidget {
  final String name;
  const Options({super.key, required this.name});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Align(child: Text("South Indian Bank")),
      ),

      //body
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: MediaQuery.of(context).size.height * 0.8,
        child: ChatBot(inputString: ''),
      ),
    );
  }
}
