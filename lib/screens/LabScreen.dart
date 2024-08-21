import 'package:flutter/material.dart';
import 'package:point_of_sale/themes_Colors.dart';

import 'package:point_of_sale/utils/drawer.dart';
import '../utils/Summary_card.dart';
import '../utils/TextField.dart';

class LabScreen extends StatefulWidget {
  const LabScreen({super.key});

  @override
  State<LabScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<LabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: Colors.black54,
          elevation: 10.0,
          centerTitle: true,
          title: Text("Lab", style: Theme.of(context).textTheme.headlineLarge),
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
              title: 'Lab',
              imagePath: 'assets/images/mobile.png',
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
                              label: 'Phone Model',
                              isPassword: false,
                            )),
                            Expanded(
                                child: CustomTextField(
                              label: 'Type issue',
                              isPassword: false,
                            )),
                            SizedBox(width: 10),
                            Expanded(
                                child: CustomTextField(
                              label: 'Customer Name',
                              isPassword: false,
                            )),
                            Expanded(
                                child: CustomTextField(
                              label: 'Final date',
                              isPassword: false,
                            )),
                            Expanded(
                                child: CustomTextField(
                              label: 'Repair Cost',
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
                            style: const TextStyle(
                              color: AppColors.primary,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.search,
                                  color: AppColors.primary,
                                ),
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
                            DataColumn(label: Text('Phone Model')),
                            DataColumn(label: Text('Issue')),
                            DataColumn(label: Text('Customer Name')),
                            DataColumn(label: Text('Final Date')),
                            DataColumn(label: Text('Repair Cost')),
                          ],
                          rows: const [
                            DataRow(
                              cells: [
                                DataCell(Text('1')),
                                DataCell(Text('Apple iPhone')),
                                DataCell(Text('2')),
                                DataCell(Text('1200')),
                                DataCell(Text('1200')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('2')),
                                DataCell(Text('Samsung TV')),
                                DataCell(Text('1')),
                                DataCell(Text('800')),
                                DataCell(Text('1200')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('3')),
                                DataCell(Text('Nike Shoes')),
                                DataCell(Text('3')),
                                DataCell(Text('500')),
                                DataCell(Text('1200')),
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
                                backgroundColor: AppColors.primary,
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
                                backgroundColor: Colors.blue,
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
                            SumryCard(
                                title: 'Total Devices for repair',
                                amount: '12'),
                            SumryCard(title: 'Repaired Items:', amount: '100'),
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
