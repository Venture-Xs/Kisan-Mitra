import 'package:flutter/material.dart';

class LoanFinder extends StatefulWidget {
  const LoanFinder({super.key});

  @override
  State<LoanFinder> createState() => _LoanFinderState();
}

class _LoanFinderState extends State<LoanFinder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          const Align(alignment: Alignment.center, child: Text("Loan Finder")),
    );
  }
}
