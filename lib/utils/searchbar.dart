import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({super.key});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  final Color primaryClr = const Color(0xFF6C63FF);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      height: 50,
      width: double.infinity,
      child: SizedBox(
        width: 100,
        child: TextField(
          style: TextStyle(color: primaryClr),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: primaryClr),
            ),
            label: Text(
              "Search here...",
              style: TextStyle(color: primaryClr, fontSize: 25),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryClr, width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryClr, width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
