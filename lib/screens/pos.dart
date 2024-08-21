import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:point_of_sale/models/sales_Model.dart';
import 'package:point_of_sale/themes_Colors.dart';
import 'package:point_of_sale/utils/Quantity_custom.dart';
import 'package:point_of_sale/utils/TextField.dart';
import 'package:point_of_sale/utils/drawer.dart';
import 'package:provider/provider.dart';

class PointOfSale extends StatefulWidget {
  PointOfSale({super.key});

  @override
  State<PointOfSale> createState() => _PointOfSaleState();
}

class _PointOfSaleState extends State<PointOfSale> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 12, minute: 0);

  Future<void> _deleteProduct(String docId) async {
    await FirebaseFirestore.instance.collection('Cart').doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    final saleModel = Provider.of<SaleModel>(context);
    return Scaffold(
      body: Row(
        children: [
          const DrawerWidget(
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
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
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
                                const SizedBox(width: 10),
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
                                  child: const Text('Select Date'),
                                ),
                                const SizedBox(width: 10),
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
                                  child: const Text('Select Time'),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                    'Selected Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                                const SizedBox(width: 10),
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
                              const SizedBox(width: 10),
                              Expanded(
                                child: DropdownSearchbar(
                                  nameController: saleModel.nameController,
                                  saleModel: saleModel,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  controller: saleModel.quantityController,
                                  label: 'QUANTITY',
                                  isPassword: false,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  controller: saleModel.priceController,
                                  label: 'Price',
                                  isPassword: false,
                                ),
                              ),
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                          Container(
                            color: AppColors.primary,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    SubTotal(),
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
                                      icon: const Icon(
                                        Icons.shopping_cart_checkout,
                                        color: AppColors.primary,
                                      ),
                                      label: const Text("ADD to Cart"),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        saleModel.finalizeSale(context);
                                      },
                                      icon: const Icon(
                                        Icons.receipt,
                                        color: AppColors.primary,
                                      ),
                                      label: const Text("Finalize"),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
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
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          var cartProducts = snapshot.data!.docs;
                          return SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text("Product Id")),
                                DataColumn(label: Text("Name")),
                                DataColumn(label: Text("Quantity")),
                                DataColumn(label: Text("Price")),
                                DataColumn(label: Text("Action")),
                              ],
                              rows: cartProducts.map((doc) {
                                var data = doc.data() as Map<String, dynamic>;
                                String docId = doc.id;
                                return DataRow(cells: [
                                  DataCell(Text(data['Id'].toString())),
                                  DataCell(Text(data['Name'])),
                                  DataCell(Text(data['Quantity'].toString())),
                                  DataCell(Text(data['Price'].toString())),
                                  DataCell(Tooltip(
                                    message: 'Delete from table',
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        _deleteProduct(docId);
                                      },
                                    ),
                                  )),
                                ]);
                              }).toList(),
                            ),
                          );
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
