import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:point_of_sale/models/product_model.dart';

import 'package:point_of_sale/themes_Colors.dart';
import 'package:point_of_sale/utils/drawer.dart';
import 'package:point_of_sale/utils/searchbar.dart';

import '../utils/TextField.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductModel _product_model = ProductModel();
  //Delete fuction for action btn
  Future<void> _deleteProduct(String docId) async {
    await FirebaseFirestore.instance.collection('Products').doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: Colors.black54,
          elevation: 10.0,
          centerTitle: true,
          title: Text("POINT OF SALE",
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
              title: 'PRODUCTS',
              imagePath: 'assets/images/product.png',
            ),
            Flexible(
              flex: 4,
              child: SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                label: 'Product id',
                                isPassword: false,
                                controller: _product_model.pIdController,
                              ),
                            ),
                            Expanded(
                                child: CustomTextField(
                              label: 'Name',
                              isPassword: false,
                              controller: _product_model.pNameController,
                            )),
                            Expanded(
                              child: DecoratedDropdown(_product_model),
                            ),
                            Expanded(
                                child: CustomTextField(
                              label: 'Quantity of Product',
                              isPassword: false,
                              controller: _product_model.pQuantityController,
                            )),
                            Expanded(
                                child: CustomTextField(
                              label: 'Price',
                              isPassword: false,
                              controller: _product_model.pPriceController,
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

                      //Searchbar button
                      const Searchbar(),

                      //DataTable  to show the data in the form of table
                      Container(
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        height: 350,
                        width: double.infinity,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Products')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              var products = snapshot.data!.docs;
                              return SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: DataTable(
                                    columns: const [
                                      DataColumn(label: Text("Product Id")),
                                      DataColumn(label: Text("Name")),
                                      DataColumn(label: Text('Category')),
                                      DataColumn(label: Text("Price")),
                                      DataColumn(label: Text("Quantity")),
                                      DataColumn(label: Text("Action")),
                                    ],
                                    rows: products.map((doc) {
                                      var data =
                                          doc.data() as Map<String, dynamic>;

                                      String docId = doc.id;

                                      return DataRow(cells: [
                                        DataCell(
                                          Text(data['ID'] ?? ''),
                                        ),
                                        DataCell(
                                          Text(data['Name'] ?? ''),
                                        ),
                                        DataCell(Text(data['Category'] ?? '')),
                                        DataCell(Text(
                                            data['Price'].toString() ?? '')),
                                        DataCell(Text(
                                            data['Quantity'].toString() ?? '')),
                                        DataCell(Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  _deleteProduct(docId);
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ))
                                          ],
                                        ))
                                      ]);
                                    }).toList(),
                                  ));
                            }),
                      ),
                      //Buttons
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () =>
                                  _product_model.saveProduct(context, context),
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

                            Container(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Products')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  int categoryCount =
                                      snapshot.data!.docs.length;
                                  return Row(
                                    children: [
                                      const Text(
                                        'Total Products:  ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontFamily: 'Schyler'),
                                      ),
                                      Text(
                                        '$categoryCount',
                                        style: const TextStyle(
                                            fontFamily: 'Schyler',
                                            fontSize: 20,
                                            color: Colors.black),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            // Save for Later Button
                            Container(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Categories')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                        child:
                                            const CircularProgressIndicator());
                                  }
                                  int categoryCount =
                                      snapshot.data!.docs.length;
                                  return Row(
                                    children: [
                                      const Text(
                                        'Total Categories:  ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontFamily: 'Schyler'),
                                      ),
                                      Text(
                                        '$categoryCount',
                                        style: const TextStyle(
                                            fontFamily: 'Schyler',
                                            fontSize: 20,
                                            color: Colors.black),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),

                            // Discard Sale Button
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
