import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/screens/LabScreen.dart';
import 'package:point_of_sale/screens/mobiles.dart';
import 'package:point_of_sale/screens/pos.dart';
import 'package:point_of_sale/screens/rechargeScreen.dart';
import 'package:point_of_sale/screens/users.dart';
import 'package:point_of_sale/themes_Colors.dart';
import 'package:point_of_sale/utils/Summary_card.dart';
import 'package:point_of_sale/utils/cards.dart';
import 'package:point_of_sale/utils/todo_card.dart';

import 'Category.dart';
import 'Product.dart';
import 'SalesRecord.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.black54,
        elevation: 10.0,
        centerTitle: true,
        title:
            Text("Dashboard", style: Theme.of(context).textTheme.headlineLarge),
        actions: [
          StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 45)),
            builder: (context, snapshot) {
              return Text(
                  "Time  ${DateTime.now().hour}:${DateTime.now().minute} ",
                  style: Theme.of(context).textTheme.headlineMedium);
            },
          ),
          const SizedBox(
            width: 30,
          )
        ],
        backgroundColor: AppColors.primary,
      ),
      body: Row(
        children: [
          Flexible(
            child: Container(
              width: 300, // Set the width of the drawer
              color: AppColors
                  .secondary, // Optional background color for the drawer
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text("POS",
                        style: Theme.of(context).textTheme.headlineMedium),
                    accountEmail: const Text("POINT OF SALE"),
                    currentAccountPicture: const CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/images/profile.png'), // Your profile image
                    ),
                    decoration: const BoxDecoration(color: AppColors.primary),
                  ),
                  const Flexible(child: Todo_Card()),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'POWERED BY AL-BASTIE',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: AppColors.primary),
                    ),
                  )

                  // Add more ListTiles for other drawer items
                ],
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        home_cards(
                            title: 'POINT OF SALE',
                            cardImg: 'assets/images/pos.png',
                            OnPressed: () {
                              Get.off(() => PointOfSale());
                            }),
                        home_cards(
                            title: 'PRODUCTS',
                            cardImg: 'assets/images/product.png',
                            OnPressed: () {
                              Get.off(() => const ProductScreen());
                            }),
                        home_cards(
                          title: 'CATEGORY',
                          cardImg: 'assets/images/category.png',
                          OnPressed: () {
                            Get.off(() => const CategoryScreen());
                          },
                        ),
                        home_cards(
                          title: 'Recharge',
                          cardImg: 'assets/images/load.png',
                          OnPressed: () {
                            Get.off(() => const RechargeScreen());
                          },
                        ),
                        home_cards(
                          title: 'MOBILE PHONES',
                          cardImg: 'assets/images/phone.png',
                          OnPressed: () {
                            Get.off(() => const MobileScreen());
                          },
                        ),
                        home_cards(
                          title: 'SALES RECORDS',
                          cardImg: 'assets/images/sales.png',
                          OnPressed: () {
                            Get.off(() => SaleRecordsPage());
                          },
                        ),
                        home_cards(
                          title: 'Lab',
                          cardImg: 'assets/images/mobile.png',
                          OnPressed: () {
                            Get.off(() => const LabScreen());
                          },
                        ),
                        home_cards(
                          title: 'USERS',
                          cardImg: 'assets/images/man.png',
                          OnPressed: () {
                            Get.off(() => const UserScreen());
                          },
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      color: AppColors.primary,
                      child: const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 160,
                            ),
                            SumryCard(title: 'Total Sale', amount: '12000'),
                            SumryCard(title: 'Product Count', amount: '12000'),
                            SumryCard(
                                title: 'Categories Count', amount: '12000'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
