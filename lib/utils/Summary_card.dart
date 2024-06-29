import 'package:flutter/material.dart';

class SumryCard extends StatefulWidget {
  final String title;
  final String amount;

  const SumryCard({super.key, required this.title, required this.amount});

  @override
  State<SumryCard> createState() => _SumryCardState();
}

class _SumryCardState extends State<SumryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      width: 180,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Colors.deepPurpleAccent,
              fontSize: 18, // Increased font size
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10), // Added space between title and amount
          Text(
            widget.amount,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Colors.black,
              fontSize: 22, // Increased font size
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
