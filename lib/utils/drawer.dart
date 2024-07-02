import 'package:flutter/material.dart';

import 'listTile.dart'; // Assuming this is the correct path to your CustomListTile widget

class DrawerWidget extends StatefulWidget {
  final String title;
  final String imagePath; // Changed from Image to String

  const DrawerWidget({super.key, required this.title, required this.imagePath});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  var PrimaryClr = const Color(0xFF6C63FF);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: 300, // Set the width of the drawer
        height: double.infinity,
        color: PrimaryClr, // Optional background color for the drawer
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.imagePath, // Use widget.imagePath here
                      height: 100, // Set the height of the image
                    ),
                    Text(widget.title, style: Theme.of(context).textTheme.headlineLarge,),
                  ],
                ),
              ),
              CustomListTile(icon: Icons.dashboard, title: 'Dashboard', onPressed: (){}),
              CustomListTile(icon: Icons.shopping_cart, title: 'POINT OF SALE', onPressed: (){}),
              CustomListTile(icon: Icons.shopping_bag, title: 'PRODUCTS', onPressed: (){}),
              CustomListTile(icon: Icons.category, title: 'CATEGORY', onPressed: (){}),
              CustomListTile(icon: Icons.recent_actors_rounded, title: 'Sale Records', onPressed: (){}),
              CustomListTile(icon: Icons.mobile_friendly, title: 'MOBILES', onPressed: (){}),
              CustomListTile(icon: Icons.science, title: 'Lab', onPressed: (){}),
              CustomListTile(icon: Icons.signal_cellular_alt, title: 'RECHARGES/LOADS', onPressed: (){}),
              CustomListTile(icon: Icons.supervised_user_circle, title: 'USERS', onPressed: (){}),
              // Add more ListTiles for other drawer items
            ],
          ),
        ),
      ),
    );
  }
}