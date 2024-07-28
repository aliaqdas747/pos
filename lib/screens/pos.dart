import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:point_of_sale/models/sales_Model.dart';
import 'package:point_of_sale/utils/Quantity_custom.dart';
import 'package:point_of_sale/utils/TextField.dart';
import 'package:point_of_sale/utils/drawer.dart';
import 'package:provider/provider.dart';

class point_of_sale extends StatefulWidget {
  point_of_sale({super.key});

  @override
  State<point_of_sale> createState() => _point_of_saleState();
}

class _point_of_saleState extends State<point_of_sale> {
  Future<void> _deleteProduct(String docId) async {
    await FirebaseFirestore.instance.collection('Cart').doc(docId).delete();
  }

  ///Now its good ?
  var PrimaryClr = Color(0xFF6C63FF);
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay(hour: 12, minute: 0);

  @override
  Widget build(BuildContext context) {
    final saleModel = Provider.of<SaleModel>(context);
    return Scaffold(
      body: Row(
        children: [
          DrawerWidget(
            title: 'POS',
            imagePath: 'assets/images/pos.png',
          ),
          Flexible(
            flex: 4,
            child: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: PrimaryClr,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 25, right: 25, bottom: 10, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Select Date and Time: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () async {
                                    final DateTime? picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: _selectedDate,
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2030),
                                    );
                                    if (picked != null &&
                                        picked != _selectedDate) {
                                      setState(() {
                                        _selectedDate = picked;
                                      });
                                    }
                                  },
                                  child: Text('Select Date'),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () async {
                                    final TimeOfDay? picked =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: _selectedTime,
                                    );
                                    if (picked != null &&
                                        picked != _selectedTime) {
                                      setState(() {
                                        _selectedTime = picked;
                                      });
                                    }
                                  },
                                  child: Text('Select Time'),
                                ),
                                SizedBox(width: 10),
                                Text(
                                    'Selected Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                                SizedBox(width: 10),
                                Text(
                                    'Selected Time: ${_selectedTime.hour}:${_selectedTime.minute}'),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  label: 'Product id',
                                  onChanged: (value) {
                                    saleModel.fetchNamebyId(context, value);
                                  },
                                  isPassword: false,
                                  controller: saleModel.idController,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: DropdownSearchbar(
                                  nameController: saleModel.nameController,
                                  saleModel: saleModel,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  controller: saleModel.quantityController,
                                  label: 'QUANTITY',
                                  isPassword: false,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  controller: saleModel.priceController,
                                  label: 'Price',
                                  isPassword: false,
                                ),
                              ),
                            ],
                          ),
                          Expanded(child: SizedBox()),
                          Container(
                            color: Colors.grey.shade100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Product_Quantity(),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    // Save for Later Button
                                    CategoryQuantity(),
                                  ],
                                ),
                                Row(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        await saleModel.AddCart(
                                          context,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.shopping_cart_checkout,
                                        color: PrimaryClr,
                                      ),
                                      label: Text("ADD to Cart"),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    //Button for final bill
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        await saleModel.AddCart(
                                          context,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.receipt,
                                        color: PrimaryClr,
                                      ),
                                      label: Text("Finalize"),
                                    )
                                  ],
                                )
                                //Button for add to cart
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    //Table coooooooooooooooooooode
                    Container(
                      decoration: BoxDecoration(
                        color: PrimaryClr,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      height: 300,
                      width: double.infinity,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Cart')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          var CartProducts = snapshot.data!.docs;
                          return SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: DataTable(
                                  columns: [
                                    DataColumn(label: Text("Product Id")),
                                    DataColumn(label: Text("Name")),
                                    DataColumn(label: Text("Quantity")),
                                    DataColumn(label: Text("Price")),
                                    DataColumn(label: Text("Action")),
                                  ],
                                  rows: CartProducts.map((doc) {
                                    var data =
                                        doc.data() as Map<String, dynamic>;
                                    String docId = doc.id;
                                    return DataRow(cells: [
                                      DataCell(Text(data['Id'] ?? '')),
                                      DataCell(Text(data['Name'])),
                                      DataCell(Text(data['Quantity'])),
                                      DataCell(Text(data['Price'])),
                                      DataCell(Tooltip(
                                        message: 'Delete from table',
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            _deleteProduct(docId);
                                          },
                                        ),
                                      )),
                                    ]);
                                  }).toList()));
                        },
                      ),
                    )
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
/*  builder: (context, snapshot) {
                              if (!snapshot.hasData) {*/