import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/screens/Category.dart';
import 'package:point_of_sale/screens/LabScreen.dart';
import 'package:point_of_sale/screens/Product.dart';
import 'package:point_of_sale/screens/SalesRecord.dart';
import 'package:point_of_sale/screens/homePage.dart';
import 'package:point_of_sale/screens/mobiles.dart';
import 'package:point_of_sale/screens/rechargeScreen.dart';
import 'package:point_of_sale/themes_Colors.dart';

import '../screens/pos.dart';
import '../screens/users.dart';
import 'listTile.dart'; // Assuming this is the correct path to your CustomListTile widget

class DrawerWidget extends StatefulWidget {
  final String title;
  final String imagePath; // Changed from Image to String

  const DrawerWidget({super.key, required this.title, required this.imagePath});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: 300, // Set the width of the drawer
        height: double.infinity,
        color: AppColors.primary, // Optional background color for the drawer
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
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
              CustomListTile(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  onPressed: () {
                    {
                      Get.off(() => const MyHomePage());
                    }
                  }),
              CustomListTile(
                  icon: Icons.shopping_cart,
                  title: 'POINT OF SALE',
                  onPressed: () {
                    Get.off(() => PointOfSale());
                  }),

              CustomListTile(
                  icon: Icons.shopping_bag,
                  title: 'PRODUCTS',
                  onPressed: () {
                    Get.off(() => const ProductScreen());
                  }),
              CustomListTile(
                  icon: Icons.category,
                  title: 'CATEGORY',
                  onPressed: () {
                    Get.off(() => const CategoryScreen());
                  }),
              CustomListTile(
                  icon: Icons.recent_actors_rounded,
                  title: 'Sale Records',
                  onPressed: () {
                    Get.off(() => SaleRecordsPage());
                  }),
              CustomListTile(
                  icon: Icons.mobile_friendly,
                  title: 'MOBILES',
                  onPressed: () {
                    Get.off(() => const MobileScreen());
                  }),
              CustomListTile(
                  icon: Icons.science,
                  title: 'Lab',
                  onPressed: () {
                    Get.off(() => const LabScreen());
                  }),
              CustomListTile(
                  icon: Icons.signal_cellular_alt,
                  title: 'RECHARGES/LOADS',
                  onPressed: () {
                    Get.off(() => const RechargeScreen());
                  }),
              CustomListTile(
                  icon: Icons.supervised_user_circle,
                  title: 'USERS',
                  onPressed: () {
                    Get.off(() => const UserScreen());
                  }),
              // Add more ListTiles for other drawer items
            ],
          ),
        ),
      ),
    );
  }
}
