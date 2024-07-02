import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:point_of_sale/utils/drawer.dart';

import '../utils/dropdown.dart';

class RechargeScreen extends StatefulWidget {

  const RechargeScreen({super.key});

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  final Color primaryClr =const Color(0xFF6C63FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
         const  DrawerWidget(title: 'Recharge', imagePath: 'assets/images/load.png',),
          Flexible(
            child: Container(
              margin: EdgeInsets.all(20),
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select Recharge type',style: Theme.of(context).textTheme!.headlineSmall!.copyWith(color: Colors.black),),
                  Wrap(children: [
                    Checkbox(
                      value: true, // Initial value of the checkbox (checked)
                      onChanged: (bool? value) {
                        // onChanged callback function
                        // Typically, you would update a state variable here if you want the checkbox to be interactive
                        // For demonstration purposes, you can print the value when it changes
                        print('Checkbox value changed to: $value');
                      },
                    ),
                    Text('Mobile',style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: primaryClr),),
                    SizedBox(width: 20,),
                    Checkbox(
                      value: false, // Initial value of the checkbox (checked)
                      onChanged: (bool? value) {
                        // onChanged callback function
                        // Typically, you would update a state variable here if you want the checkbox to be interactive
                        // For demonstration purposes, you can print the value when it changes
                        print('Checkbox value changed to: $value');
                      },
                    ),
                    Text('Network',style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: primaryClr),)
            
                  ],),
                  SizedBox(height: 10,),
                  Text('Enter Mobile Number/Account ID:',style: Theme.of(context).textTheme!.headlineSmall!.copyWith(color: Colors.black),),
                 TextField(
                   style: TextStyle(
                     color: Colors.black
                   ),
                 ),
                  SizedBox(height: 10,),
                  Text('Select Operators ',style: Theme.of(context).textTheme!.headlineSmall!.copyWith(color: Colors.black),),
                  DropButton(),
                  SizedBox(height: 10,),
                  Text('Add Amount ',style: Theme.of(context).textTheme!.headlineSmall!.copyWith(color: Colors.black),),
                  TextField(
                    style: TextStyle(
                        color: Colors.black
                    ),
                  ),
               SizedBox(height: 20,),
                  ElevatedButton(
            
                    onPressed: () {
                      // Handle Discard Sale action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryClr,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
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
                      decoration: BoxDecoration(
                          color: primaryClr,
                          borderRadius:const  BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                      ),
                      margin:const EdgeInsets.only(left: 20, right: 20),
                      height: 500,
                      width: double.infinity,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Product ID')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('CATEGORY')),
                          DataColumn(label: Text('Price')),
                        ],
                        rows:const [
                          DataRow(
                            cells:  [
                              DataCell(Text('1')),
                              DataCell(Text('Apple iPhone')),
                              DataCell(Text('2')),
                              DataCell(Text('1200')),
                            ],
                          ),
                          DataRow(
                            cells:  [
                              DataCell(Text('2')),
                              DataCell(Text('Samsung TV')),
                              DataCell(Text('1')),
                              DataCell(Text('800')),
                            ],
                          ),
                          DataRow(
                            cells:  [
                              DataCell(Text('3')),
                              DataCell(Text('Nike Shoes')),
                              DataCell(Text('3')),
                              DataCell(Text('500')),
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
