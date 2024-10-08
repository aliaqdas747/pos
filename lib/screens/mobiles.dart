import 'package:flutter/material.dart';
import 'package:point_of_sale/themes_Colors.dart';

import 'package:point_of_sale/utils/drawer.dart';
import '../utils/Summary_card.dart';
import '../utils/TextField.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<MobileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: Colors.black54,
          elevation: 10.0,
          centerTitle: true,
          title: Text("Mobiles ",
              style: Theme.of(context).textTheme.headlineLarge),
          actions: const [
            SizedBox(
              width: 30,
            )
          ],
          backgroundColor: AppColors.primary,
        ),
        body: Row(
          children: [
            const DrawerWidget(
              title: 'MOBILE',
              imagePath: 'assets/images/phone.png',
            ),
            Flexible(
              flex: 4,
              child: SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: const Row(
                          children: [
                            Expanded(
                                child: CustomTextField(
                              label: 'Id',
                              isPassword: false,
                            )),
                            SizedBox(width: 10),
                            Expanded(
                                child: CustomTextField(
                              label: 'Model',
                              isPassword: false,
                            )),
                            SizedBox(width: 10),
                            Expanded(
                                child: CustomTextField(
                              label: 'Company',
                              isPassword: false,
                            )),
                            SizedBox(width: 10),
                            Expanded(
                                child: CustomTextField(
                              label: 'Price',
                              isPassword: false,
                            )),
                          ],
                        ),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        height: 50,
                        width: double.infinity,
                        child: SizedBox(
                          width: 100,
                          child: TextField(
                            style: const TextStyle(color: AppColors.primary),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.search,
                                    color: AppColors.primary),
                              ),
                              label: const Text(
                                "Search here...",
                                style: TextStyle(
                                    color: AppColors.primary, fontSize: 25),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.primary, width: 1.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.primary, width: 1.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        height: 300,
                        width: double.infinity,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text(' ID')),
                            DataColumn(label: Text('Model')),
                            DataColumn(label: Text('Company Name')),
                            DataColumn(label: Text('Price')),
                          ],
                          rows: const [
                            DataRow(
                              cells: [
                                DataCell(Text('1')),
                                DataCell(Text('Apple iPhone')),
                                DataCell(Text('2')),
                                DataCell(Text('1200')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('2')),
                                DataCell(Text('Samsung TV')),
                                DataCell(Text('1')),
                                DataCell(Text('800')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('3')),
                                DataCell(Text('Nike Shoes')),
                                DataCell(Text('3')),
                                DataCell(Text('500')),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Handle Discard Sale action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Save Product",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            // Save for Later Button
                            ElevatedButton(
                              onPressed: () {
                                // Handle Save for Later action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "UPDATE",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),

                            // Discard Sale Button
                            ElevatedButton(
                              onPressed: () {
                                // Handle Discard Sale action
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "DELETE ITEM",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        width: double.infinity,
                        child: const Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            SumryCard(title: 'Total Items', amount: '12'),
                            SumryCard(title: 'Total Category:', amount: '100'),
                            SumryCard(
                                title: 'Total Product Amount', amount: '1200'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
