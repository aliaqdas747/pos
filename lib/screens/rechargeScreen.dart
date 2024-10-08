import 'package:flutter/material.dart';
import 'package:point_of_sale/themes_Colors.dart';

import 'package:point_of_sale/utils/drawer.dart';

import '../utils/dropdown.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({super.key});

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const DrawerWidget(
            title: 'Recharge',
            imagePath: 'assets/images/load.png',
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.all(20),
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Recharge type',
                    style: Theme.of(context)
                        .textTheme!
                        .headlineSmall!
                        .copyWith(color: Colors.black),
                  ),
                  Wrap(
                    children: [
                      Checkbox(
                        value: true, // Initial value of the checkbox (checked)
                        onChanged: (bool? value) {
                          // onChanged callback function
                          // Typically, you would update a state variable here if you want the checkbox to be interactive
                          // For demonstration purposes, you can print the value when it changes
                          print('Checkbox value changed to: $value');
                        },
                      ),
                      Text(
                        'Mobile',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: AppColors.primary,
                                ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Checkbox(
                        value: false, // Initial value of the checkbox (checked)
                        onChanged: (bool? value) {
                          // onChanged callback function
                          // Typically, you would update a state variable here if you want the checkbox to be interactive
                          // For demonstration purposes, you can print the value when it changes
                          print('Checkbox value changed to: $value');
                        },
                      ),
                      Text(
                        'Network',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: AppColors.primary,
                                ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Enter Mobile Number/Account ID:',
                    style: Theme.of(context)
                        .textTheme!
                        .headlineSmall!
                        .copyWith(color: Colors.black),
                  ),
                  const TextField(
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Select Operators ',
                    style: Theme.of(context)
                        .textTheme!
                        .headlineSmall!
                        .copyWith(color: Colors.black),
                  ),
                  const DropButton(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Add Amount ',
                    style: Theme.of(context)
                        .textTheme!
                        .headlineSmall!
                        .copyWith(color: Colors.black),
                  ),
                  const TextField(
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                      "Save Records",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                      height: 500,
                      width: double.infinity,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Recharge Type')),
                          DataColumn(label: Text('Number / ID')),
                          DataColumn(label: Text('Operator')),
                          DataColumn(label: Text('Amount')),
                        ],
                        rows: const [
                          DataRow(
                            cells: [
                              DataCell(Text('Mobile')),
                              DataCell(Text('1039248710324')),
                              DataCell(Text('Telenor')),
                              DataCell(Text('1200')),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text('Network')),
                              DataCell(Text('213412344324')),
                              DataCell(Text('Zong')),
                              DataCell(Text('800')),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text('Mobile')),
                              DataCell(Text('12341234123')),
                              DataCell(Text('Jazz')),
                              DataCell(Text('500')),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text('Network')),
                              DataCell(Text('213412344324')),
                              DataCell(Text('Zong')),
                              DataCell(Text('800')),
                            ],
                          ),
                        ],
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
